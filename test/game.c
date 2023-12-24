#include "LIB/neslib.h"
#include "LIB/nesdoug.h" 
#include "Sprites.h"

#define BLACK 0x0f
#define DK_GY 0x00
#define LT_GY 0x10
#define WHITE 0x30
#define BLUE 0x0C
#define BROWN 0x07
#define PINK 0x25
// there's some oddities in the palette code, black must be 0x0f, white must be 0x30
 
 
 
#pragma bss-name(push, "ZEROPAGE")

// GLOBAL VARIABLES
// all variables should be global for speed  //I'm sorry Marius
// zeropage global is even faster

unsigned char yPos=0x40;
unsigned char xPos=0x88;
unsigned char pad1;



const unsigned char text[]="You truly are the dark soul"; // zero terminated c string
const unsigned char palette[]={
BLACK, DK_GY, BLUE, PINK,
WHITE,0,0,0,
0,0,0,0,
0,0,0,0
}; 
const unsigned char palette2[]={
BLACK, DK_GY, BLUE, BROWN,
WHITE,0,0,0,
0,0,0,0,
0,0,0,0
}; 



	

void main (void) {
	
	ppu_off(); // screen off

	pal_bg(palette); //	load the BG palette
	pal_spr(palette2);//load the sprite palette
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
		if(pad1 & PAD_LEFT){
		xPos -= 1;
		}
		else if (pad1 & PAD_RIGHT){
			xPos += 1;
		}
		if(pad1 & PAD_UP){
			yPos -= 1;
		}
		else if (pad1 & PAD_DOWN){
			yPos += 1;
		}
		ppu_wait_nmi(); // wait till beginning of the frame
		oam_clear(); //Clear the sprite buffer.
		//oam_spr(xPos,yPos,0,0); //Push 1 sprite to the buffer
		oam_meta_spr(xPos,yPos,metasprite); //Push 1 metasprite to the buffer.
		oam_meta_spr(xPos-18,yPos+25,metasprite2);
		oam_meta_spr(xPos+18,yPos+25,metasprite3);
	}
}
	
	