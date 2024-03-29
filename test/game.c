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
	//vram_adr(NTADR_A(3,3)); // screen is 32 x 30 tiles
	//clearScreen();
	
	set_vram_buffer(); // do at least once, sets a pointer to a buffer
	draw_bg();
	set_scroll_y(0xff); //shift the bg down 1 pixel
	
	mapPos = center; //setting the mapPos to the center of map
	respawnPos = center;
	regenTimer = timerSpeed;
	playerSprite = downSprite;
	
	
	ppu_on_all(); //	turn on screen now in draw_bg();
	
	
	//while (loop){}

	while (loop){
		// infinite loop
		// game code can go here later.
		ppu_wait_nmi();
		pad1 = pad_poll(0); //read first controller input
		pad1_new = get_pad_new(0); // newly pressed button. do pad_poll first

		move();//move the player
		nextRoom();
		testCollision();//sprite collisions
		eBgCol();
		drawSprites();
		stBtn();
		selBtn();
		updateHealth();
		updateStamina();
		loseCheck();
		aBtn();
		bBtn();

		eMove();
		
		if (iFrame > 0){
				iFrame -= 1;
		}else if (roll == 1){
			roll = 0;
			playerSprite = downSprite; dir = 3;
		}

		while (pause){ //pause
			pad1 = pad_poll(0); //read first controller input
			pad1_new = get_pad_new(0); // newly pressed button. do pad_poll first
			selBtn();
		}
	}
	while (1){ //prevents crashes on "win"
		//hamburger
	}
}
	
void move (void){
	if(roll){
		knight.x += rHVal;
		

		bgCollision();//cant roll through walls
		if(collision_R) knight.x -= 3;
		if(collision_L) knight.x += 3;

		knight.y += rVVal;
		bgCollision();
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

		}else{rVVal = 0; }
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
	oam_meta_spr(sword.x, sword.y, swordSpr);
	
	if( which_bg == 13 && wolf.health <= 0){//which_bg == 13 is temp as only 1 boss
		oam_meta_spr(winBlock.x, winBlock.y , winSpr);
	}
	else if(bossType == 'W'){
		oam_meta_spr(wolf.x, wolf.y , wolfSpr);
	}
	else{
		for(i = 0; i < numberOfE; i++){
			oam_meta_spr(E[i].x, E[i].y , hollowSprite);
		}
	}

	if(iMap[mapPos] == 1){
		oam_meta_spr(bonfire.x, bonfire.y , fireSpr);
	}
	
}

void testCollision(void){//tests collisions against sprites
	for(i = 0; i < numberOfE; i++){
		collision = check_collision(&knight, &E[i]); 
		// change the BG color, if sprites are touching
		if (collision){
			//E[i].y++;
			
			if (iFrame <= 0 && roll == 0){
				health -= 1;
				iFrame = 26;
				
			}
			
		}
	}

	//sword
	for(i = 0; i < numberOfE; i++){
		collision = check_collision(&sword, &E[i]); 
		if (collision){
			for(j = 0; j < numberOfE; j++){//grab a temp copy of the enemy array
				tempE[j] = E[j];
			}

			for(j = i; j < numberOfE; j++){
				E[j] = tempE[j+1];
				
			}
			numberOfE -= 1;
		}
	}

	

	for(i = 0; i < numberOfE; i++){//check enemy sprite collisions
		for(j = 1; j < numberOfE; j++){
			collision = check_collision(&E[i], &E[i+j]); 
			if(collision){
				E[j].y++;//move it down
			}
			
		}
	}
	if(wolf.health <= 0){
		collision = check_collision(&knight, &winBlock);
		 if (collision){win();}
	}else
	if((bossType == 'W') && (wolf.health > 0)){//boss wolf
		
		collision = check_collision(&knight, &wolf);
		 if (collision){if (iFrame <= 0 && roll == 0){
				health -= 1;
				iFrame = 26;
				
			}}

		collision = check_collision(&sword, &wolf); 
		if (collision){
			wolf.health -= 1;
			if(wolf.health <= 0){
				wolfSpr = null;
				
				drawSprites();
				i = 0;
				do{
					ppu_wait_nmi();
					i++;
				}while(i <= 35);
				// //open up boss gates
				canLeave = 1;
				worldMap[mapPos] = 13;
				which_bg = worldMap[mapPos];
				eMap[mapPos] = 0;
				pal_fade_to(4,0); // fade to black
				i = 0;
				do{
					ppu_wait_nmi();
					i++;
				}while(i <= 30);
				draw_bg();
				pal_fade_to(0,4); // back to normal brightness	
			}
				
		
		}
	}else if(iMap[mapPos] == 1){
		collision = check_collision(&knight, &bonfire); 
		if (collision){rest();}
	}
}

void draw_bg(void){
	mapTiles[35] = 48+flasks; //Update the mapTiles to have the correct number of flasks

	ppu_off(); // screen off
	set_vram_buffer(); // do at least once, sets a pointer to a buffer
	//copy the room to the collision map
	p_maps = All_Collision_Maps[which_bg];
	memcpy (c_map, p_maps, 240);
	set_data_pointer(p_maps);
	set_mt_pointer(mapTiles);
	for(y=0; ;y+=0x20){
		for(x=0; ;x+=0x20){
			address = get_ppu_addr(0, x, y);
			index = (y & 0xf0) + (x >> 4);
			buffer_4_mt(address, index); // ppu_address, index to the data
			flush_vram_update2();
			if (x == 0xe0) break;
		}
		if (y == 0xe0) break;
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

void loadEnemyData(void){ //loads random enemy positions
	
	// which_bg holds a char with the level number. e.g. map_1 = 1
	//numberOfE = 3;
	loadRoomData();
	for(i = 0; i < numberOfE; i++){
		E[i].width = 15;//set size of enemy
		E[i].height = 15;


		do{
		 	E[i].x = 4*rand8();
		}while(!(E[i].x <= 224 && E[i].x >= 16));

		do{
			E[i].y = 4*rand8();
		}while(!((E[i].y <= 208) && (E[i].y >= 32)));	
	}	
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
		//which_bg = respawn;
		mapPos = respawnPos;
		which_bg = worldMap[mapPos];
		
		draw_bg();
		health = maxHealth;
		stamina = maxStam;
		knight.x = 120;
		knight.y = 112;
		flasks = 3;
		roll = 0;
		if(wolf.health > 0){wolf.health = wolf.maxHth;} //Remove for multiple bosses
		canLeave = 1;
		dir = 3;
		playerSprite = downSprite;
		ppu_wait_nmi();
		ppu_on_all();
		pal_bright(4); // back to normal brightness	
		
	}
}

void nextRoom(void){ 
	if(canLeave){
		if(knight.y < 13){
			pal_fade_to(4,0); // fade to black
			
			knight.y = 221;
			mapPos -= mapWidth;
			which_bg = worldMap[mapPos];
			//draw_bg();
			
			draw_bg();
			drawSprites();
			ppu_wait_nmi();
			pal_bright(4); // back to normal brightness	
			
		}
		else if(knight.y > 221){
			pal_fade_to(4,0); // fade to black
			knight.y = 13;
			mapPos += mapWidth;
			which_bg = worldMap[mapPos];
			//draw_bg();
			draw_bg();
			drawSprites();
			ppu_wait_nmi();
			pal_bright(4); // back to normal brightness	
			
		}
		else if(knight.x <= 3 ){
			pal_fade_to(4,0); // fade to black
			knight.x = 236;
			mapPos=mapPos-1;
			which_bg = worldMap[mapPos];
			//draw_bg();
			draw_bg();
			drawSprites();
			ppu_wait_nmi();
			pal_bright(4); // back to normal brightness	
			
		}
		else if(knight.x >= 237){
			pal_fade_to(4,0); // fade to black
			knight.x = 4;//can't go less than 0, so have to be a pixel over
			mapPos=mapPos+1;
			which_bg = worldMap[mapPos];
			//draw_bg();
			draw_bg();
			drawSprites();
			ppu_wait_nmi();
			pal_bright(4); // back to normal brightness	
			
		}
		
	}else{
		if(knight.y < 32){
			knight.y += 4;
			
			
		}
		else if(knight.y > 208){
			knight.y -= 4;
			
		}
		else if(knight.x < 16 ){
			knight.x += 4;
			
		}
		else if(knight.x > 224){
			knight.x -= 4;
			
		}
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
	if( eMap[mapPos] >= 0 && eMap[mapPos] <= 9 ){numberOfE = eMap[mapPos]; bossType = 0; }
	else{bossType = eMap[mapPos]; numberOfE = 0; canLeave = 0;}

	
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
	if((pad1_new & PAD_A)&& (!roll) ){
		if(stamina >= 1){
			stamina-=1;
			switch(dir){
				case 1:
				playerSprite=upAttSprite;
				swordSpr=srdU;
				sword.y = knight.y-8;
				sword.x = knight.x;
				testCollision();
				wait(swdTime);
				playerSprite=upSprite;
				break;
				case 2:
				playerSprite=rightAttSprite;
				swordSpr=srdR;
				sword.x = knight.x+16;
				sword.y = knight.y;
				testCollision();
				wait(swdTime);
				playerSprite=rightSprite;
				break;
				case 3:
				playerSprite=downAttSprite;
				swordSpr=srdD;
				sword.y = knight.y+16;
				sword.x = knight.x;
				testCollision();
				wait(swdTime);
				playerSprite=downSprite;
				break;
				case 4:
				playerSprite=leftAttSprite;
				swordSpr=srdL;
				sword.x = knight.x-8;
				sword.y = knight.y;
				testCollision();
				wait(swdTime);
				playerSprite=leftSprite;
				break;
			}
			swordSpr=null;
			sword.x = 0;//move it so enemies can't collide
			sword.y = 0;
			//still need to draw rest of blade
		}
	}
}

void bBtn(void){//roll
	if(pad1_new & PAD_B && (!roll)){
		if (stamina >= 1){
				stamina -= 1;
				roll = 1;
				playerSprite = rollSprite;
				iFrame = 26;
				
			}

		
	}

	
}


void stBtn(void){//heal 
	
	if(pad1_new & PAD_START && flasks > 0 && roll == 0){
		flasks -=1;
		health += 4;
		if (health > maxHealth){health=maxHealth;}//Ensure no overheal
		
		//update GUI
		mapTiles[35] = 48+flasks; //Update the mapTiles to have the correct number of flasks
		address = get_ppu_addr(0, 0xF0, 0); //Address of the flask
		buffer_1_mt(address, 7); // redraw just the flasks - no need to update entire screen + doesn't require the screen to be turned off
		
		
	}	
}

void selBtn(void){//menu //Currently Pause 
	if(pad1_new & PAD_SELECT){
		if (pause == 0){
			pause = 1;
		}else{pause = 0;}
		
	}
	// 	address = get_ppu_addr(0, 0xF0, 0x10); //Address of the flask
	// 	buffer_1_mt(address, 7); // put metatile #0 here = blank grass
	// }
	
}


void eBgCol(void){
	//OK do the same for the enemies - Very slow may change, but as works rn will fix when it becomes an issue
	for(i = 0; i < numberOfE; i++){//check enemy sprite collisions
		
		collision_L = 0;
		collision_R = 0;
		collision_U = 0;
		collision_D = 0;
		
		temp_x = E[i].x; // left side
		temp_y = E[i].y; // top side
		
		if(temp_y >= 0xf0) return;
		// y out of range
		
		coordinates = (temp_x >> 4) + (temp_y & 0xf0); // upper left
		if(c_map[coordinates]){ // find a corner in the collision map
			++collision_L;
			++collision_U;
		}
		
		temp_x = E[i].x + E[i].width; // right side
		
		coordinates = (temp_x >> 4) + (temp_y & 0xf0); // upper right
		if(c_map[coordinates]){
			++collision_R;
			++collision_U;
		}
		
		temp_y = E[i].y + E[i].height; // bottom side
		if(temp_y >= 0xf0) return;
		// y out of range
		
		coordinates = (temp_x >> 4) + (temp_y & 0xf0); // bottom right
		if(c_map[coordinates]){
			++collision_R;
			++collision_D;
		}
		
		temp_x = E[i].x; // left side
		
		coordinates = (temp_x >> 4) + (temp_y & 0xf0); // bottom left
		if(c_map[coordinates]){
			++collision_L;
			++collision_D;
		}


		if(collision_D) E[i].y -= 1;
		if(collision_U) E[i].y += 1;
		if(collision_L) E[i].x += 1;
		if(collision_R) E[i].x -= 1;
	}
};

void wait(time){
	
	while(time >= 0){
		drawSprites();
		updateHealth();
		updateStamina();
		ppu_wait_nmi();
		eMove();
		eBgCol();
		time -= 1;
	}
}

void eMove(void){//Basic Move towards player - it is bad, but usable
	for(i = 0; i < numberOfE; i++){
		if(E[i].x > knight.x){
			E[i].x -= 1;
		}
		if(E[i].x < knight.x){
			E[i].x += 1;
		}
		if(E[i].y > knight.y){
			E[i].y -= 1;
		}
		if(E[i].y < knight.y){
			E[i].y += 1;
		}
	}

	if(bossType == 'W' && wolf.health > 0){wolfMove();}
		
	
}

void wolfMove(void){//wolf Boss attack


	if (wolfCharge >= 35){//charging
		wolfCharge -= 1;
		wolf.x += wolfChX;
		if(wolf.x < 16){wolf.x = 16;}
		else if(wolf.x > 208){wolf.x = 208;}
		wolf.y += wolfChY;
		if(wolf.y < 32){wolf.y = 32;}
		else if(wolf.y > 200){wolf.y = 200;}



	}else if (wolfCharge > 0){//waiting
		wolfCharge -= 1;
	}else{//start  new charge
		wolfCharge = 60;

		wolfChX = (knight.x - wolf.x)/10; //should really make the speed constistant regardless of distance, but I think this is funny so ¯\(-_-)/¯
		wolfChY = (knight.y - wolf.y)/10;
		
		
		if((knight.x - wolf.x) < 0){wolfSpr = wolfL;}else{wolfSpr = wolfR;}//change sprite direction
	}	

	
}


void rest(void){
	respawnPos = mapPos;
	flasks = 3;
	health = maxHealth;
	//update GUI
	mapTiles[35] = 48+flasks; //Update the mapTiles to have the correct number of flasks
	address = get_ppu_addr(0, 0xF0, 0); //Address of the flask
	buffer_1_mt(address, 7);
}

//TODO - Minimum
//Player Roll //DONE
//Player Attack //Change enemy load first//Enemy load done //Done
//Player Heal //DONE 
//Enemy Random Spawn//DONE
//Stop animation canceling on roll //DONE
//Better Enemy Attack //GOOD ENOUGH
//fix attack sprite flickering - either flicker the sprites properly / shrink the sprites / stop enemies walking into a row with > 2 enemies in it //FIX LATER
//Boss Fight//DONE KINDA
//Better room load //DONE

//ROLL through corners bug... DONE