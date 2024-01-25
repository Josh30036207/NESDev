#include "LIB/neslib.h"
#include "LIB/nesdoug.h" 
#include "sprites.h"
#include "game.h"

#pragma bss-name(push, "ZEROPAGE")


	

void main (void) {
	
	ppu_off(); // screen off

	pal_bg(paletteBg); //	load the BG palette
	pal_spr(paletteSp);//load the sprite palette
	bank_spr(1);
	// set a starting point on the screen
	// vram_adr(NTADR_A(x,y));
	vram_adr(NTADR_A(3,3)); // screen is 32 x 30 tiles
	vram_write(text,sizeof(text)); 
	
	bank_spr(1);
	
	set_scroll_y(0xff); //shift the bg down 1 pixel
	
	draw_bg();
	
	//ppu_on_all(); //	turn on screen
	
	


	while (1){
		// infinite loop
		// game code can go here later.
		ppu_wait_nmi();
		pad1 = pad_poll(0); //read first controller input
		pad1_new = get_pad_new(0); // newly pressed button. do pad_poll first

		move();
		testCollision();//sprite collisions
		drawSprites();
		check_start();
		
		
	}
}
	
void move (void){
	if(pad1 & PAD_LEFT){
		knight.x -= 1;
	}
	else if (pad1 & PAD_RIGHT){
		knight.x += 1;
	}
	bgCollision();
	if(collision_R) knight.x -= 1;
	if(collision_L) knight.x += 1;
	if(pad1 & PAD_UP){
		knight.y -= 1;
	}
	else if (pad1 & PAD_DOWN){
		knight.y += 1;
	}
	bgCollision();
	if(collision_D) knight.y -= 1;
	if(collision_U) knight.y += 1;
}

void drawSprites(void){
	ppu_wait_nmi(); // wait till beginning of the frame
	// clear all sprites from sprite buffer
	oam_clear();
	
	// draw 2 metasprites
	oam_meta_spr(knight.x, knight.y, metasprite);
	
	oam_meta_spr(Enemy.x, Enemy.y, metasprite2);
}

void testCollision(void){
	collision = check_collision(&knight, &Enemy); //currently only checks the 1 enemy. Need to change to check all of them
		
	// change the BG color, if sprites are touching
	if (collision){
		pal_col(0,PINK); 
	}
	else{
		pal_col(0,BLACK);
	}
}



void draw_bg(void){
	ppu_off(); // screen off
	
	p_maps = All_Collision_Maps[which_bg];
	// copy the collision map to c_map
	memcpy (c_map, p_maps, 240);
	
	// this sets a start position on the BG, top left of screen
	vram_adr(NAMETABLE_A);
	
	// draw a row of tiles
	for(temp_y = 0; temp_y < 15; ++temp_y){
		for(temp_x = 0; temp_x < 16; ++temp_x){
			temp1 = (temp_y << 4) + temp_x;

			if(c_map[temp1]){
				vram_put(0x02); // wall
				vram_put(0x02);
			}
			else{
				vram_put(0); // blank
				vram_put(0);
			}
		}
		
		// draw a second row of tiles
		for(temp_x = 0; temp_x < 16; ++temp_x){
			temp1 = (temp_y << 4) + temp_x;

			if(c_map[temp1]){
				vram_put(0x02); // wall
				vram_put(0x02);
			}
			else{
				vram_put(0); // blank
				vram_put(0);
			}
		}
	}
	
	ppu_on_all(); // turn on screen
}

void bgCollision(){
	// sprite collision with backgrounds
	
	collision_L = 0;
	collision_R = 0;
	collision_U = 0;
	collision_D = 0;
	
	temp_x = knight.x; // left side
	temp_y = knight.y; // top side
	
	if(temp_y >= 0xf0) return;
	// y out of range
	
	coordinates = (temp_x >> 4) + (temp_y & 0xf0); // upper left
	if(c_map[coordinates]){ // find a corner in the collision map
		++collision_L;
		++collision_U;
	}
	
	temp_x = knight.x + knight.width; // right side
	
	coordinates = (temp_x >> 4) + (temp_y & 0xf0); // upper right
	if(c_map[coordinates]){
		++collision_R;
		++collision_U;
	}
	
	temp_y = knight.y + knight.height; // bottom side
	if(temp_y >= 0xf0) return;
	// y out of range
	
	coordinates = (temp_x >> 4) + (temp_y & 0xf0); // bottom right
	if(c_map[coordinates]){
		++collision_R;
		++collision_D;
	}
	
	temp_x = knight.x; // left side
	
	coordinates = (temp_x >> 4) + (temp_y & 0xf0); // bottom left
	if(c_map[coordinates]){
		++collision_L;
		++collision_D;
	}
}

void check_start(void){
	// if START is pressed, load another background
	if(pad1_new & PAD_START){
		++which_bg;
		if(which_bg >= 3) which_bg = 0;
		draw_bg();
	}	
}