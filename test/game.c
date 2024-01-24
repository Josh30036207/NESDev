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
	

	
	ppu_on_all(); //	turn on screen
	
	
	while (1){
		// infinite loop
		// game code can go here later.
		pad1 = pad_poll(0); //read first controller input
		
		move();
		testCollision();
		drawSprites();
		
		
	}
}
	
void move (void){
	if(pad1 & PAD_LEFT){
		knight.x -= 1;
		}
		else if (pad1 & PAD_RIGHT){
			knight.x += 1;
		}
		if(pad1 & PAD_UP){
			knight.y -= 1;
		}
		else if (pad1 & PAD_DOWN){
			knight.y += 1;
		}
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