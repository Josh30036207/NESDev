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

int i;
int health = 8;
int stamina = 8;
int maxHealth = 8;
int maxStam = 8;
int regenTimer;
int timerSpeed = 70;
int iFrame = 0;
int loop = 1;


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
void check_start(void);
void loadEnemyData(void);
void updateHealth(void);
void loseCheck(void);
void testButton(void); //used to test features
void nextRoom(void);//load next room if the player walks off the edge
void clearScreen(void);
void win(void);
void loadRoomData(void);
void updateStamina(void);