
// GLOBAL VARIABLES
// all variables should be global for speed  //I'm sorry Marius
// zeropage global is even faster

unsigned char pad1;
unsigned char collision;
const unsigned char text[]="You truly are the dark soul"; // zero terminated c string


// there's some oddities in the palette code, black must be 0x0f, white must be 0x30
 

 struct hollow { //basic entity
	unsigned char x;
	unsigned char y;
	unsigned char width;
	unsigned char height;
};


struct hollow knight = {20,20,15,15};
struct hollow Enemy = {200, 147, 15, 15};


//Prototypes
void drawSprites(void);
void move(void);	
void testCollision(void);