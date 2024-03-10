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
//Attack Sprites
const unsigned char upAttSprite[]={
	  0,  0,0x44,0,
	  8,  0,0x45,0,
	  0,  8,0x54,0,
	  8,  8,0x55,0,
	128
};

const unsigned char downAttSprite[]={
	  0,  0,0x40,0,
	  8,  0,0x41,0,
	  0,  8,0x50,0,
	  8,  8,0x51,0,
	128
};

const unsigned char leftAttSprite[]={
	  8,  0,0x42,0|OAM_FLIP_H,
	  0,  0,0x43,0|OAM_FLIP_H,
	  8,  8,0x52,0|OAM_FLIP_H,
	  0,  8,0x53,0|OAM_FLIP_H,
	128
};

const unsigned char rightAttSprite[]={
	  0,  0,0x42,0,
	  8,  0,0x43,0,
	  0,  8,0x52,0,
	  8,  8,0x53,0,
	128
};

const unsigned char upSwd[]={
	  0,  0,0x36,0,
	  8,  0,0x37,0,
	128
};
const unsigned char rightSwd[]={
	  0,  0,0x46,0,
	  0,  8,0x56,0,
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

const unsigned char wolfL[]={
	  0,  0,0x08,0,
	  8,  0,0x09,0,
	  16,  0,0x0A,0,
	  24,  0,0x0B,0,
	  0,  8,0x18,0,
	  8,  8,0x19,0,
	  16,  8,0x1A,0,
	  23,  8,0x1B,0,
	  0,  16,0x28,0,
	  8,  16,0x29,0,
	  16,  16,0x2A,0,
	  23,  16,0x2B,0,
	128
};

const unsigned char wolfR[]={
	  24,  0,0x08,0|OAM_FLIP_H,
	  16,  0,0x09,0|OAM_FLIP_H,
	  8,  0,0x0A,0|OAM_FLIP_H,
	  0,  0,0x0B,0|OAM_FLIP_H,

	  24,  8,0x18,0|OAM_FLIP_H,
	  16,  8,0x19,0|OAM_FLIP_H,
	  8,  8,0x1A,0|OAM_FLIP_H,
	  0,  8,0x1B,0|OAM_FLIP_H,

	  24,  16,0x28,0|OAM_FLIP_H,
	  16,  16,0x29,0|OAM_FLIP_H,
	  8,  16,0x2A,0|OAM_FLIP_H,
	  0,  16,0x2B,0|OAM_FLIP_H,

	128
};

const unsigned char null[]={
	128
};

const unsigned char srdU[]={
	0,  0,0x36,0,
	8,  0,0x37,0,
	128
};

const unsigned char srdD[]={
	0,  0,0x26,0|OAM_FLIP_V,
	8,  0,0x27,0|OAM_FLIP_V,
	128
};

const unsigned char srdR[]={
	0,  0,0x46,0,
	0,  8,0x56,0,
	128
};

const unsigned char srdL[]={
	0,  0,0x46,0|OAM_FLIP_H,
	0,  8,0x56,0|OAM_FLIP_H,
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
BLACK,0x17,PINK,0x27,
0,0,0,0,
0,0,0,0
}; 
const  char paletteSp[]={//palette for the sprites
PINK, DK_GY, BLUE, BROWN,
WHITE,0x16,0x19,0x00,
0,0x26,0x06,0x16,
0,0,0,0
}; 