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
const unsigned char *swordSpr;

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
int swdTime = 5;
int canLeave = 1;

int respawnPos = 0;

 struct hollow { //basic entity
	unsigned char x;
	unsigned char y;
	unsigned char width;
	unsigned char height;
};


struct hollow knight = {120,94,15,15};
struct hollow sword = {0, 0, 15, 15};
int numberOfE = 3; // Can't use value for creating an array 
unsigned char bossType;
struct hollow E[3]; //Maximum of 3 enemies per row, prob don't want more than that anyway
struct hollow tempE[3];

struct hollow bonfire = {120, 112, 15, 7};

struct hollow winBlock = {120, 112, 15, 7};

struct boss { //basic entity
	unsigned char x;
	unsigned char y;
	unsigned char width;
	unsigned char height;
	unsigned int health;
	unsigned int maxHth;
};
struct boss wolf = {120, 100, 32, 24, 10, 10};//BOSS 1
const unsigned char *wolfSpr = wolfL;
unsigned int wolfCharge = 50;
unsigned int wolfChX;
unsigned int wolfChY;
unsigned int dx;
unsigned int dy;
unsigned int squ;
unsigned char c_map[240];
// collision map 
const unsigned char * const All_Collision_Maps[] = {map0, map1,map2,map3,map4,map5,map6,map7,map8,fireRoom,wolfRoom,map11,map12,wolfRoomOpn};//add the maps to the array


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
void eBgCol(void);
void wait(int time);
void eMove(void);
void wolfMove(void);
void rest(void);




// bg draw variables
int address;
unsigned char x; 
unsigned char y;
unsigned char index;

int posChk = 0;
int pause = 0;
