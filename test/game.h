// collision data, made by exporting csv from Tiled, and slight modification by CSV2C.py
#include "BG/maps.c" 


// GLOBAL VARIABLES
// all variables should be global for speed  //I'm sorry Marius
// zeropage global is even faster

unsigned char pad1;
unsigned char pad1_new;
unsigned char collision;
unsigned char text[]="You Died"; // zero terminated c string
unsigned char winTxt[]="You Win";
unsigned char collision_L;
unsigned char collision_R;
unsigned char collision_U;
unsigned char collision_D;
unsigned char which_bg;
const unsigned char * p_maps;
unsigned char coordinates;
unsigned char temp1;
unsigned char temp2;
unsigned char temp3;
unsigned char temp4;
unsigned char temp_x;
unsigned char temp_y;

const unsigned char *playerSprite;

int i;
int j;
int health = 8;
int stamina = 8;
int maxHealth = 8;
int maxStam = 8;
int regenTimer;
int timerSpeed = 70;
int iFrame = 0;
int loop = 1;
int roll = 0;
int rHVal = 0;
int rVVal = 0;
int dir = 3;
int canMove = 1;
int flasks = 3;


 struct hollow { //basic entity
	unsigned char x;
	unsigned char y;
	unsigned char width;
	unsigned char height;
};


struct hollow knight = {40,62,15,15};
struct hollow Enemy = {64, 147, 15, 15};
int numberOfE = 3; // Can't use value for creating an array 
struct hollow E[3]; //Maximum of 3 enemies per row, prob don't want more than that anyway
struct hollow tempE[3];

struct hollow winBlock = {120, 112, 15, 7};


unsigned char c_map[240];
// collision map 
const unsigned char * const All_Collision_Maps[] = {map0, map1,map2,map3,map4,map5,map6,map7,map8,winRoom};//add the maps to the array


//Prototypes
void drawSprites(void);
void move(void);	
void testCollision(void);
void draw_bg(void);
void bgCollision(void);
void loadEnemyData(void);
void updateHealth(void);
void loseCheck(void);
void nextRoom(void);//load next room if the player walks off the edge
void clearScreen(void);
void win(void);
void loadRoomData(void);
void updateStamina(void);
void selBtn(void); //Select
void stBtn(void);//Start
void aBtn(void);
void bBtn(void);


char mapTiles[]={ //per row TTL, TR, BL, BR, Colour 
	0, 0, 0, 0,  0,//Empty Space
	2, 2, 2, 2,  0,//Tiles
	3, 3, 3, 3,  0,
	0, 0, 0, 0,  0,
	0, 0, 0, 0,  0,
	0, 0, 0, 0,  0,
	0, 0, 0, 0,  0,
	48, 130, 0, 0,  1 //Flask
};

// bg draw variables
int address;
unsigned char x; 
unsigned char y;
unsigned char index;

int posChk = 0;
