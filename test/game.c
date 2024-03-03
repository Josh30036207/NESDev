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
	clearScreen();
	set_scroll_y(0xff); //shift the bg down 1 pixel
	
	mapPos = center; //setting the mapPos to the center of map
	regenTimer = timerSpeed;
	playerSprite = downSprite;
	draw_bg();
	
	//ppu_on_all(); //	turn on screen now in draw_bg();
	
	


	while (loop){
		// infinite loop
		// game code can go here later.
		ppu_wait_nmi();
		pad1 = pad_poll(0); //read first controller input
		pad1_new = get_pad_new(0); // newly pressed button. do pad_poll first

		move();//move the player
		nextRoom();
		testCollision();//sprite collisions
		drawSprites();
		stBtn();
		selBtn();
		updateHealth();
		updateStamina();
		loseCheck();
		aBtn();
		bBtn();
		
		if (iFrame > 0){
				iFrame -= 1;
		}else{
			roll = 0;
		}
	}
	while (1){ //prevents crashes on "win"
		//hamburger
	}
}
	
void move (void){
	if(roll){
		knight.x += rHVal;
		knight.y += rVVal;

		bgCollision();//cant roll through walls
		if(collision_R) knight.x -= 3;
		if(collision_L) knight.x += 3;
		if(collision_D) knight.y -= 3;
		if(collision_U) knight.y += 3;
	}
	else{
		if(pad1 & PAD_LEFT){
			playerSprite = leftSprite;
			dir = 4;
			knight.x -= 2;
			rHVal = -3;
			
		}
		else if (pad1 & PAD_RIGHT){
			playerSprite = rightSprite;
			dir = 2;
			knight.x += 2;
			rHVal = 3;
		}else{rHVal = 0;}
		bgCollision();
		if(collision_R) knight.x -= 2;
		if(collision_L) knight.x += 2;
		if(pad1 & PAD_UP){
			playerSprite = upSprite;
			dir = 1;
			knight.y -= 2;
			rVVal = -3;
		}
		else if (pad1 & PAD_DOWN){
			playerSprite = downSprite;
			dir = 3;
			knight.y += 2;
			rVVal = 3;
		}else{rVVal = 0;}
		bgCollision();
		if(collision_D) knight.y -= 2;
		if(collision_U) knight.y += 2;
	}
	
}

void drawSprites(void){
	ppu_wait_nmi(); // wait till beginning of the frame
	// clear all sprites from sprite buffer
	oam_clear();
	bank_spr(1);//switch to player spritesheet

	
	{oam_meta_spr(knight.x, knight.y, playerSprite);}
	
	
	if(which_bg == 9){
		oam_meta_spr(winBlock.x, winBlock.y , fire);
	}else{
		for(i = 0; i < numberOfE; i++){
			oam_meta_spr(E[i].x, E[i].y , hollowSprite);
		}
	}
	
}

void testCollision(void){//tests collisions against sprites
	for(i = 0; i < numberOfE; i++){
		collision = check_collision(&knight, &E[i]); 
		// change the BG color, if sprites are touching
		if (collision){
			E[i].y++;
			if (iFrame <= 0 && roll == 0){
				health -= 1;
				iFrame = 26;
				
			}
			
		}
	}
	if(which_bg == 9){
		collision = check_collision(&knight, &winBlock);
		 if (collision){win();}}
}

void draw_bg(void){ //change this as is shit - only allows to draw from 1 palette
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
			else if(c_map[temp1] == 9){
				vram_put(0x33); // Flask 
				vram_put(0x82); // Flask 
				
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
			else if(c_map[temp1] == 9){
				vram_put((0x00)); // Flask 
				vram_put(0x00); // Flask 
				
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

void loadEnemyData(void){ //need to load enemies from map //not fully implimented yet
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
	numberOfE = 3;
	

}

void updateHealth(void){
	for(i = 0; i < health; i++){
		oam_spr((i*8), 0, 0x80, 1);
	}
	
}

void clearScreen(void){
	ppu_off(); // screen off
	vram_adr(NTADR_A(0,0));//set to top corner
	i = 0;
	do{
		vram_put(0);
		i++;
	}while(i < 960);//32*30
	ppu_on_all();
}

void loseCheck(void){//
	if(health <= 0){
		//lose
		pal_fade_to(4,0); // fade to black
		//you died
		
		
		oam_clear();//clear sprite buffer
		clearScreen();
		vram_adr(NTADR_A(12,14)); // screen is 32 x 30 tiles
		vram_write(text,sizeof(text));
		pal_bright(4); // back to normal brightness	
		i = 0;
		do{
			ppu_wait_nmi();
			i++;
		}while(i <= 180);
		
		
		
		//respawn at start
		pal_fade_to(4,0); // fade to black
		ppu_off(); // screen off //make this better and fade in/out after saying you died
		clearScreen();
		which_bg = 0;
		mapPos = center;
		draw_bg();
		health = maxHealth;
		stamina = maxStam;
		knight.x = 120;
		knight.y = 112;
		flasks = 3;
		ppu_wait_nmi();
		ppu_on_all();
		pal_bright(4); // back to normal brightness	
		
	}
}

void nextRoom(void){ //currently just iterates the background - need to change to follow a proper map.
	if(knight.y < 13){
		pal_fade_to(4,0); // fade to black
		knight.y = 221;
		mapPos -= mapWidth;
		which_bg = worldMap[mapPos];
		draw_bg();
		drawSprites();
		ppu_wait_nmi();
		pal_bright(4); // back to normal brightness	
		loadRoomData();
	}
	else if(knight.y > 221){
		pal_fade_to(4,0); // fade to black
		knight.y = 13;
		mapPos += mapWidth;
		which_bg = worldMap[mapPos];
		draw_bg();
		drawSprites();
		ppu_wait_nmi();
		pal_bright(4); // back to normal brightness	
		loadRoomData();
	}
	else if(knight.x <= 3 ){
		pal_fade_to(4,0); // fade to black
		knight.x = 236;
		mapPos=mapPos-1;
		which_bg = worldMap[mapPos];
		draw_bg();
		drawSprites();
		ppu_wait_nmi();
		pal_bright(4); // back to normal brightness	
		loadRoomData();
	}
	else if(knight.x >= 237){
		pal_fade_to(4,0); // fade to black
		knight.x = 4;//can't go less than 0, so have to be a pixel over
		mapPos=mapPos+1;
		which_bg = worldMap[mapPos];
		draw_bg();
		drawSprites();
		ppu_wait_nmi();
		pal_bright(4); // back to normal brightness	
		loadRoomData();
	}
	
	
}

void win(void){
	pal_fade_to(4,0); // fade to black
		//you win - temp win screen for demo
		oam_clear();//clear sprite buffer
		clearScreen();
		loop = 0;
		vram_adr(NTADR_A(12,14)); // screen is 32 x 30 tiles
		vram_write(winTxt,sizeof(winTxt));
		pal_bright(4); // back to normal brightness	
	
		
}

void loadRoomData(void){
	if(which_bg == 9) {numberOfE = 0;}
	else{numberOfE = 3;}
}

void updateStamina(void){
	if(stamina < maxStam && regenTimer <= 0){
		stamina++;
		regenTimer = timerSpeed;
	}else{regenTimer -= 1;}
	
	for(i = 0; i < stamina; i++){
		oam_spr((i*8), 8, 0x90, 1);
	}
}

void aBtn(void){//attack
	if(pad1_new & PAD_A ){
		if(stamina >= 1){
			switch(dir){
				case 1:
				playerSprite=upAttSprite;
				break;
				case 2:
				playerSprite=rightAttSprite;
				break;
				case 3:
				playerSprite=downAttSprite;
				break;
				case 4:
				playerSprite=leftAttSprite;
				break;
			}
			stamina-=1;
			//still need to draw rest of blade
		}
	}
}

void bBtn(void){//roll
	if(pad1_new & PAD_B){
		if (stamina >= 1){
				stamina -= 1;
				roll = 1;
				playerSprite = rollSprite;
				iFrame = 18;
				
			}
	}

	
}


void stBtn(void){//heal 
	
	if(pad1_new & PAD_START && flasks > 0){
		flasks -=1;
		health += 4;
		if (health > maxHealth){health=maxHealth;};
		
		
		

	}	
}

void selBtn(void){//menu //Currently used to test Health/Stamina
	if(pad1_new & PAD_SELECT){
		health -= 1;
		stamina -=1;
		regenTimer = timerSpeed;
	}
	
}

//TODO - Minimum
//Player Roll //DONE
//Player Attack //Change enemy load first
//Player Heal //DONE (Ish need to put a visual for number of heals left, but need to change background load first)
//Enemy Random Spawn
//Better Enemy Attack
//Boss Fight
//Better room load