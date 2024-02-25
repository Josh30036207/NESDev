const unsigned char upSprite[]={
	  0,  0,0x24,0,
	  8,  0,0x25,0,
	  0,  8,0x34,0,
	  8,  8,0x35,0,
	128
};

const unsigned char downSprite[]={
	  0,  0,0x20,0,
	  8,  0,0x21,0,
	  0,  8,0x30,0,
	  8,  8,0x31,0,
	128
};

const unsigned char leftSprite[]={
	  8,  0,0x22,0|OAM_FLIP_H,
	  0,  0,0x23,0|OAM_FLIP_H,
	  8,  8,0x32,0|OAM_FLIP_H,
	  0,  8,0x33,0|OAM_FLIP_H,
	128
};

const unsigned char rightSprite[]={
	  0,  0,0x22,0,
	  8,  0,0x23,0,
	  0,  8,0x32,0,
	  8,  8,0x33,0,
	128
};

const unsigned char rollSprite[]={
	  0,  0,0x02,0,
	  8,  0,0x03,0,
	  0,  8,0x12,0,
	  8,  8,0x13,0,
	128
};

const unsigned char hollowSprite[]={
	  0,  0,0x01,0|OAM_FLIP_H,
	  0,  8,0x11,0|OAM_FLIP_H,
	  8,  0,0x01,0,
	  8,  8,0x11,0,
	128
};


const unsigned char fire[]={
	  0,  0,0x81,2,
	  8,  0,0x82,2,
	128
};



//Colours
#define BLACK 0x0f
#define DK_GY 0x00
#define LT_GY 0x10
#define WHITE 0x30
#define BLUE 0x0C
#define BROWN 0x07
#define PINK 0x25

const  char paletteBg[]={ //palette for the background
BLACK, DK_GY, BLUE, 0x16,
WHITE,0,0,0,
0,0,0,0,
0,0,0,0
}; 
const  char paletteSp[]={//palette for the sprites
PINK, DK_GY, BLUE, BROWN,
WHITE,0x16,0x19,0x00,
0,0x26,0x06,0x16,
0,0,0,0
}; 