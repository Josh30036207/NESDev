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

		move();//move the player
		nextRoom();
		testCollision();//sprite collisions
		drawSprites();
		check_start();
		testButton();//currently select
		updateHealth();
		loseCheck();
		
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
	bank_spr(1);//switch to player spritesheet
	// draw 2 metasprites
	
	oam_meta_spr(knight.x, knight.y, metasprite);
	
	
	
	for(i = 0; i < numberOfE; i++){
		oam_meta_spr(E[i].x, E[i].y , metasprite2);
	}
	
}

void testCollision(void){//currently only checks the 1 enemy. Need to change to check all of them
	for(i = 0; i < numberOfE; i++){
		collision = check_collision(&knight, &E[i]); 
		// change the BG color, if sprites are touching
		if (collision){
			E[i].y++;
		}
	}
	
}



void draw_bg(void){
	ppu_off(); // screen off
	
	p_maps = All_Collision_Maps[which_bg];
	// copy the collision map to c_map
	memcpy (c_map, p_maps, 240);
	
	// this sets a start position on the BG, top left of screen
	vram_adr(NAMETABLE_A);
	
	// draw a row of tiles //Each "block" is a 2X2 tile, so call vram_put twice to per row for each block
	//Check what block is in the map. Put a 0 for an empty space
	for(temp_y = 0; temp_y < 15; ++temp_y){
		for(temp_x = 0; temp_x < 16; ++temp_x){
			temp1 = (temp_y << 4) + temp_x;

			if(c_map[temp1] == 1){
				vram_put(0x02); // wall
				vram_put(0x02);
			}
			else if(c_map[temp1] == 2){
				vram_put(0x03); // Pink
				vram_put(0x03);
			}
			else if(c_map[temp1] == 3){
				vram_put(0x07); // Heart 
				vram_put(0x08); // Heart 
			}
			else{
				vram_put(0); // blank
				vram_put(0);
			}
		}
		
		// draw a second row of tiles
		for(temp_x = 0; temp_x < 16; ++temp_x){
			temp1 = (temp_y << 4) + temp_x;

			if(c_map[temp1] == 1){
				vram_put(0x02); // wall
				vram_put(0x02);
			}
			else if(c_map[temp1] == 2){
				vram_put(0x03); // Pink
				vram_put(0x03);
			}
			else if(c_map[temp1] == 3){
				vram_put(0x17); // Heart 
				vram_put(0x18);
			}
			else{
				vram_put(0); // blank
				vram_put(0);
			}
		}
	}
	loadEnemyData();
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

void check_start(void){//Testing loading backgrounds
	// if START is pressed, load another background
	if(pad1_new & PAD_START){
		++which_bg;
		if(which_bg >= 2) which_bg = 0;
		draw_bg();
	}	
}

void loadEnemyData(void){ //need to load enemies from map
	E[0].x = 64;
	E[0].y = 64;
	E[0].width = 15;
	E[0].height = 15;

	E[1].x = 128;
	E[1].y = 128;
	E[1].width = 15;
	E[1].height = 15;

	E[2].x = 420;
	E[2].y = 64;
	E[2].width = 15;
	E[2].height = 15;

	
	// which_bg holds a char with the level number. e.g. map_1 = 1
	numberOfE = which_bg+1;
	

}

void updateHealth(void){
	for(i = 0; i < health; i++){
		oam_spr((i*8), 0, 0x80, 1);
	}
	
}

void loseCheck(void){//
	if(health < 0){
		//lose
		ppu_off(); // screen off //make this better and fade in/out after saying you died
		which_bg = 0;
		draw_bg();
		health = maxHealth;
		knight.x = 120;
		knight.y = 112;
		ppu_wait_nmi();
		ppu_on_all();
	}
}


void testButton(void){
	if(pad1_new & PAD_SELECT){
		health -= 1;
		
	}
	
}

void nextRoom(void){ //currently just iterates the background - need to change to follow a proper map.
	if(knight.y < 16){
		pal_fade_to(4,0); // fade to black
		knight.y = 224;
		mapPos -= mapWidth;
		which_bg = worldMap[mapPos];
		draw_bg();
		drawSprites();
		ppu_wait_nmi();
		pal_bright(4); // back to normal brightness	
	}
	else if(knight.y > 224){
		pal_fade_to(4,0); // fade to black
		knight.y = 16;
		mapPos += mapWidth;
		which_bg = worldMap[mapPos];
		draw_bg();
		drawSprites();
		ppu_wait_nmi();
		pal_bright(4); // back to normal brightness	
	}
	else if(knight.x <= 0 ){
		pal_fade_to(4,0); // fade to black
		knight.x = 239;
		mapPos=mapPos-1;
		which_bg = worldMap[mapPos];
		draw_bg();
		drawSprites();
		ppu_wait_nmi();
		pal_bright(4); // back to normal brightness	
	}
	else if(knight.x >= 240){
		pal_fade_to(4,0); // fade to black
		knight.x = 1;//can't go less than 0, so have to be a pixel over
		mapPos=mapPos+1;
		which_bg = worldMap[mapPos];
		draw_bg();
		drawSprites();
		ppu_wait_nmi();
		pal_bright(4); // back to normal brightness	
	}
	
	
}
