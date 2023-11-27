#include "LIB/neslib.h"
#include "LIB/nesdoug.h" 

#define BLACK 0x0f
#define DK_GY 0x00
#define LT_GY 0x10
#define WHITE 0x30
#define PINK 0x25
// there's some oddities in the palette code, black must be 0x0f, white must be 0x30
 
 
 
#pragma bss-name(push, "ZEROPAGE")

// GLOBAL VARIABLES
// all variables should be global for speed  //I'm sorry Marius
// zeropage global is even faster

unsigned char i;



const unsigned char text[]="Test Time"; // zero terminated c string

const unsigned char palette[]={
BLACK, DK_GY, LT_GY, WHITE,
PINK,0,0,0,
0,0,0,0,
0,0,0,0
}; 



	

void main (void) {
	
	ppu_off(); // screen off

	pal_bg(palette); //	load the BG palette
		
	// set a starting point on the screen
	// vram_adr(NTADR_A(x,y));
	vram_adr(NTADR_A(12,9)); // screen is 32 x 30 tiles
	
	vram_write(text,sizeof(text)); 

	
	ppu_on_all(); //	turn on screen
	
	
	while (1){
		// infinite loop
		// game code can go here later.
		
	}
}
	