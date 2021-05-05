PImage title, gameover, startNormal, startHovered, restartNormal, restartHovered;
PImage groundhogIdle, groundhogLeft, groundhogRight, groundhogDown;
PImage bg, life, cabbage, stone1, stone2, soilEmpty;
PImage soldier;
PImage soil0, soil1, soil2, soil3, soil4, soil5;
PImage[][] soils, stones;

final int GAME_START = 0, GAME_RUN = 1, GAME_OVER = 2;
int gameState = 0;

final int GRASS_HEIGHT = 15;
final int SOIL_COL_COUNT = 8;
final int SOIL_ROW_COUNT = 24;
final int SOIL_SIZE = 80;

int[][] soilHealth;

final int START_BUTTON_WIDTH = 144;
final int START_BUTTON_HEIGHT = 60;
final int START_BUTTON_X = 248;
final int START_BUTTON_Y = 360;

float[] cabbageX, cabbageY, soldierX, soldierY;
float soldierSpeed = 2f;

float playerX, playerY;
int playerCol, playerRow;
final float PLAYER_INIT_X = 4 * SOIL_SIZE;
final float PLAYER_INIT_Y = - SOIL_SIZE;
boolean leftState = false;
boolean rightState = false;
boolean downState = false;
int playerHealth = 2;
final int PLAYER_MAX_HEALTH = 5;
int playerMoveDirection = 0;
int playerMoveTimer = 0;
int playerMoveDuration = 15;
int soilEmptyX,soilEmptyaX,soilEmptybX,soilEmptycX,soilEmptydX,soilEmptyeX,soilEmptyfX;
int soilEmptygX,soilEmptyhX,soilEmptyiX,soilEmptyjX,soilEmptykX,soilEmptylX,soilEmptymX;
int soilEmptynX,soilEmptyoX,soilEmptypX,soilEmptyqX,soilEmptyrX,soilEmptysX,soilEmptytX;
int soilEmptyuX,soilEmptyvX;
int soilEmptyY;


boolean demoMode = false;

void setup() {
	size(640, 480, P2D);
	bg = loadImage("img/bg.jpg");
	title = loadImage("img/title.jpg");
	gameover = loadImage("img/gameover.jpg");
	startNormal = loadImage("img/startNormal.png");
	startHovered = loadImage("img/startHovered.png");
	restartNormal = loadImage("img/restartNormal.png");
	restartHovered = loadImage("img/restartHovered.png");
	groundhogIdle = loadImage("img/groundhogIdle.png");
	groundhogLeft = loadImage("img/groundhogLeft.png");
	groundhogRight = loadImage("img/groundhogRight.png");
	groundhogDown = loadImage("img/groundhogDown.png");
	life = loadImage("img/life.png");
	soldier = loadImage("img/soldier.png");
	cabbage = loadImage("img/cabbage.png");

	soilEmpty = loadImage("img/soils/soilEmpty.png");

	// Load soil images used in assign3 if you don't plan to finish requirement #6
	soil0 = loadImage("img/soil0.png");
	soil1 = loadImage("img/soil1.png");
	soil2 = loadImage("img/soil2.png");
	soil3 = loadImage("img/soil3.png");
	soil4 = loadImage("img/soil4.png");
	soil5 = loadImage("img/soil5.png");

  //load stone
  stone1 = loadImage("img/stone1.png");
  stone2 = loadImage("img/stone2.png");

	// Load PImage[][] soils
	soils = new PImage[6][5];
	for(int i = 0; i < soils.length; i++){
		for(int j = 0; j < soils[i].length; j++){
			soils[i][j] = loadImage("img/soils/soil" + i + "/soil" + i + "_" + j + ".png");
		}
	}

	// Load PImage[][] stones
	stones = new PImage[2][5];
	for(int i = 0; i < stones.length; i++){
		for(int j = 0; j < stones[i].length; j++){
			stones[i][j] = loadImage("img/stones/stone" + i + "/stone" + i + "_" + j + ".png");
		}
	}

	// Initialize player
	playerX = PLAYER_INIT_X;
	playerY = PLAYER_INIT_Y;
	playerCol = (int) (playerX / SOIL_SIZE);
	playerRow = (int) (playerY / SOIL_SIZE);
	playerMoveTimer = 0;
	playerHealth = 2;

	// Initialize soilHealth
	soilHealth = new int[SOIL_COL_COUNT][SOIL_ROW_COUNT];
	for(int i = 0; i < soilHealth.length; i++){
		for (int j = 0; j < soilHealth[i].length; j++) {
			 // 0: no soil, 15: soil only, 30: 1 stone, 45: 2 stones
			soilHealth[i][j] = 15;

    //stone 1-8
    if((i==0 && j==0 || i==1 && j==1 || i==2 && j==2 || i==3 && j==3)
    ||(i==4 && j==4 || i==5 && j==5 || i==6 && j==6 || i==7 && j==7)
    
    //stone 9-16
    ||(i==0||i==3||i==4||i==7)&&(j==9||j==10||j==13||j==14)
    ||(i==1||i==2||i==5||i==6)&&(j==8||j==11||j==12||j==15)
    
    //stone 17-24
    ||(i==1||i==4||i==7)&&(j==16||j==19||j==22)
    ||(i==0||i==3||i==6)&&(j==17||j==20||j==23)
    ||(i==2||i==5)&&(j==18||j==21)){
      soilHealth[i][j] = 30;
    
    //stone2 17-24
     }else if((i==2||i==5)&&(j==16||j==19||j==22)
     ||(i==1||i==4||i==7)&&(j==17||j==20||j==23)
     ||(i==0||i==3||i==6)&&(j==18||j==21)){
     soilHealth[i][j] = 45;
     }
	 }
	}

    //empty soil
    soilEmptyX = floor(random(0,8))*80; //1
    soilEmptyaX = floor(random(0,8))*80;//2
    soilEmptybX = floor(random(0,8))*80;//3
    soilEmptycX = floor(random(0,8))*80;//4
    soilEmptydX = floor(random(0,8))*80;//5
    soilEmptyeX = floor(random(0,8))*80;//6
    soilEmptyfX = floor(random(0,8))*80;//7
    soilEmptygX = floor(random(0,8))*80;//8
    soilEmptyhX = floor(random(0,8))*80;//9
    soilEmptyiX = floor(random(0,8))*80;//10
    soilEmptyjX = floor(random(0,8))*80;//11
    soilEmptykX = floor(random(0,8))*80;//12
    soilEmptylX = floor(random(0,8))*80;//13
    soilEmptymX = floor(random(0,8))*80;//14
    soilEmptynX = floor(random(0,8))*80;//15
    soilEmptyoX = floor(random(0,8))*80;//16
    soilEmptypX = floor(random(0,8))*80;//17
    soilEmptyqX = floor(random(0,8))*80;//18
    soilEmptyrX = floor(random(0,8))*80;//19
    soilEmptysX = floor(random(0,8))*80;//20
    soilEmptytX = floor(random(0,8))*80;//21
    soilEmptyuX = floor(random(0,8))*80;//22
    soilEmptyvX = floor(random(0,8))*80;//23
    
    soilEmptyY = 80;
  

	// Initialize soidiers and their position

	// Initialize cabbages and their position

}

void draw() {

	switch (gameState) {

		case GAME_START: // Start Screen
		image(title, 0, 0);
		if(START_BUTTON_X + START_BUTTON_WIDTH > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_HEIGHT > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(startHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;
			}

		}else{

			image(startNormal, START_BUTTON_X, START_BUTTON_Y);

		}

		break;

		case GAME_RUN: // In-Game
		// Background
		image(bg, 0, 0);

		// Sun
	    stroke(255,255,0);
	    strokeWeight(5);
	    fill(253,184,19);
	    ellipse(590,50,120,120);

	    // CAREFUL!
	    // Because of how this translate value is calculated, the Y value of the ground level is actually 0
		pushMatrix();
		translate(0, max(SOIL_SIZE * -18, SOIL_SIZE * 1 - playerY));

		// Ground
		fill(124, 204, 25);
		noStroke();
		rect(0, -GRASS_HEIGHT, width, GRASS_HEIGHT);

		// Soil
		for(int i = 0; i < soilHealth.length; i++){
			for (int j = 0; j < soilHealth[i].length; j++) {

				// Change this part to show soil and stone images based on soilHealth value
				// NOTE: To avoid errors on webpage, you can either use floor(j / 4) or (int)(j / 4) to make sure it's an integer.
				int areaIndex = floor(j / 4);
				image(soils[areaIndex][4], i * SOIL_SIZE, j * SOIL_SIZE);
				
			}
		}
    //empty soil
    
    for(int i=1; i<3; i++){
        image(soilEmpty, soilEmptyX*i, soilEmptyY);//1
        image(soilEmpty, soilEmptyaX*i, soilEmptyY+80);//2
        image(soilEmpty, soilEmptybX*i, soilEmptyY+160);//3
        image(soilEmpty, soilEmptycX*i, soilEmptyY+240);//4
        image(soilEmpty, soilEmptydX*i, soilEmptyY+320);//5
        image(soilEmpty, soilEmptyeX*i, soilEmptyY+400);//6
        image(soilEmpty, soilEmptyfX*i, soilEmptyY+480);//7
        image(soilEmpty, soilEmptygX*i, soilEmptyY+560);//8
        image(soilEmpty, soilEmptyhX*i, soilEmptyY+640);//9
        image(soilEmpty, soilEmptyiX*i, soilEmptyY+720);//10
        image(soilEmpty, soilEmptyjX*i, soilEmptyY+800);//11
        image(soilEmpty, soilEmptykX*i, soilEmptyY+880);//12
        image(soilEmpty, soilEmptylX*i, soilEmptyY+960);//13
        image(soilEmpty, soilEmptymX*i, soilEmptyY+1040);//14
        image(soilEmpty, soilEmptynX*i, soilEmptyY+1120);//15
        image(soilEmpty, soilEmptyoX*i, soilEmptyY+1200);//16
        image(soilEmpty, soilEmptypX*i, soilEmptyY+1280);//17
        image(soilEmpty, soilEmptyqX*i, soilEmptyY+1360);//18
        image(soilEmpty, soilEmptyrX*i, soilEmptyY+1440);//19
        image(soilEmpty, soilEmptysX*i, soilEmptyY+1520);//20
        image(soilEmpty, soilEmptytX*i, soilEmptyY+1600);//21
        image(soilEmpty, soilEmptyuX*i, soilEmptyY+1680);//22
        image(soilEmpty, soilEmptyvX*i, soilEmptyY+1760);//23
     }

    //all stones
    //stone 1-8
    for(int i = 0; i < 8; i++){
      image(stone1, i*80, i*80);
    }
    //stone 9-16
    for(int i = 0; i < 8; i++){
      for(int j = 0; j < 8; j++){
        if((i==0||i==3||i==4||i==7)
        && (j==1||j==2||j==5||j==6)){
        image(stone1, i*80, j*80+640);
        }else if((i==1||i==2||i==5||i==6)
        && (j==0||j==3||j==4||j==7)){
        image(stone1, i*80, j*80+640);
        }
      }
    }
    //stone 17-24
    for(int x = 0; x < 8; x++){
      for(int y = 0; y < 8; y++){
        if((x==0||x==3||x==6)
        && (y==1||y==2||y==4||y==5||y==7)){
        image(stone1, x*80, y*80+640+640);
        }else if((x==1||x==4||x==7)
        && (y==0||y==1||y==3||y==4||y==6||y==7)){
        image(stone1, x*80, y*80+640+640);
        }else if((x==2||x==5)
        && (y==0||y==2||y==3||y==5||y==6)){
        image(stone1, x*80, y*80+640+640);
        }
      }
    }
    //stone 17-24
    for(int x = 0; x < 8; x++){
      for(int y = 0; y < 8; y++){
        if((x==0||x==3||x==6)
        && (y==2||y==5)){
        image(stone2, x*80, y*80+640+640);
        }else if((x==1||x==4||x==7)
        && (y==1||y==4||y==7)){
        image(stone2, x*80, y*80+640+640);
        }else if((x==2||x==5)
        && (y==0||y==3||y==6)){
        image(stone2, x*80, y*80+640+640);
        }
      }
    }



		// Cabbages
		// > Remember to check if playerHealth is smaller than PLAYER_MAX_HEALTH!

		// Groundhog

		PImage groundhogDisplay = groundhogIdle;

		// If player is not moving, we have to decide what player has to do next
		if(playerMoveTimer == 0){

			// HINT:
			// You can use playerCol and playerRow to get which soil player is currently on

			// Check if "player is NOT at the bottom AND the soil under the player is empty"
			// > If so, then force moving down by setting playerMoveDirection and playerMoveTimer (see downState part below for example)
			// > Else then determine player's action based on input state

			if(leftState){

				groundhogDisplay = groundhogLeft;

				// Check left boundary
				if(playerCol > 0){

					// HINT:
					// Check if "player is NOT above the ground AND there's soil on the left"
					// > If so, dig it and decrease its health
					// > Else then start moving (set playerMoveDirection and playerMoveTimer)

					playerMoveDirection = LEFT;
					playerMoveTimer = playerMoveDuration;

				}

			}else if(rightState){

				groundhogDisplay = groundhogRight;

				// Check right boundary
				if(playerCol < SOIL_COL_COUNT - 1){

					// HINT:
					// Check if "player is NOT above the ground AND there's soil on the right"
					// > If so, dig it and decrease its health
					// > Else then start moving (set playerMoveDirection and playerMoveTimer)

					playerMoveDirection = RIGHT;
					playerMoveTimer = playerMoveDuration;

				}

			}else if(downState){

				groundhogDisplay = groundhogDown;

				// Check bottom boundary

				// HINT:
				// We have already checked "player is NOT at the bottom AND the soil under the player is empty",
				// and since we can only get here when the above statement is false,
				// we only have to check again if "player is NOT at the bottom" to make sure there won't be out-of-bound exception
				if(playerRow < SOIL_ROW_COUNT - 1){

					// > If so, dig it and decrease its health

					// For requirement #3:
					// Note that player never needs to move down as it will always fall automatically,
					// so the following 2 lines can be removed once you finish requirement #3

					playerMoveDirection = DOWN;
					playerMoveTimer = playerMoveDuration;


				}
			}

		}

		// If player is now moving?
		// (Separated if-else so player can actually move as soon as an action starts)
		// (I don't think you have to change any of these)

		if(playerMoveTimer > 0){

			playerMoveTimer --;
			switch(playerMoveDirection){

				case LEFT:
				groundhogDisplay = groundhogLeft;
				if(playerMoveTimer == 0){
					playerCol--;
					playerX = SOIL_SIZE * playerCol;
				}else{
					playerX = (float(playerMoveTimer) / playerMoveDuration + playerCol - 1) * SOIL_SIZE;
				}
				break;

				case RIGHT:
				groundhogDisplay = groundhogRight;
				if(playerMoveTimer == 0){
					playerCol++;
					playerX = SOIL_SIZE * playerCol;
				}else{
					playerX = (1f - float(playerMoveTimer) / playerMoveDuration + playerCol) * SOIL_SIZE;
				}
				break;

				case DOWN:
				groundhogDisplay = groundhogDown;
				if(playerMoveTimer == 0){
					playerRow++;
					playerY = SOIL_SIZE * playerRow;
				}else{
					playerY = (1f - float(playerMoveTimer) / playerMoveDuration + playerRow) * SOIL_SIZE;
				}
				break;
			}

		}

		image(groundhogDisplay, playerX, playerY);

		// Soldiers
		// > Remember to stop player's moving! (reset playerMoveTimer)
		// > Remember to recalculate playerCol/playerRow when you reset playerX/playerY!
		// > Remember to reset the soil under player's original position!

		// Demo mode: Show the value of soilHealth on each soil
		// (DO NOT CHANGE THE CODE HERE!)

		if(demoMode){	

			fill(255);
			textSize(26);
			textAlign(LEFT, TOP);

			for(int i = 0; i < soilHealth.length; i++){
				for(int j = 0; j < soilHealth[i].length; j++){
					text(soilHealth[i][j], i * SOIL_SIZE, j * SOIL_SIZE);
				}
			}

		}

		popMatrix();

		// Health UI

		break;

		case GAME_OVER: // Gameover Screen
		image(gameover, 0, 0);
		
		if(START_BUTTON_X + START_BUTTON_WIDTH > mouseX
	    && START_BUTTON_X < mouseX
	    && START_BUTTON_Y + START_BUTTON_HEIGHT > mouseY
	    && START_BUTTON_Y < mouseY) {

			image(restartHovered, START_BUTTON_X, START_BUTTON_Y);
			if(mousePressed){
				gameState = GAME_RUN;
				mousePressed = false;

				// Initialize player
				playerX = PLAYER_INIT_X;
				playerY = PLAYER_INIT_Y;
				playerCol = (int) (playerX / SOIL_SIZE);
				playerRow = (int) (playerY / SOIL_SIZE);
				playerMoveTimer = 0;
				playerHealth = 2;

				// Initialize soilHealth
				soilHealth = new int[SOIL_COL_COUNT][SOIL_ROW_COUNT];
				for(int i = 0; i < soilHealth.length; i++){
					for (int j = 0; j < soilHealth[i].length; j++) {
						 // 0: no soil, 15: soil only, 30: 1 stone, 45: 2 stones
						soilHealth[i][j] = 15;
					}
       //soil array

				}

				// Initialize soidiers and their position

				// Initialize cabbages and their position
				
			}

		}else{

			image(restartNormal, START_BUTTON_X, START_BUTTON_Y);

		}
		break;
		
	}
}

void keyPressed(){
	if(key==CODED){
		switch(keyCode){
			case LEFT:
			leftState = true;
			break;
			case RIGHT:
			rightState = true;
			break;
			case DOWN:
			downState = true;
			break;
		}
	}else{
		if(key=='b'){
			// Press B to toggle demo mode
			demoMode = !demoMode;
		}
	}
}

void keyReleased(){
	if(key==CODED){
		switch(keyCode){
			case LEFT:
			leftState = false;
			break;
			case RIGHT:
			rightState = false;
			break;
			case DOWN:
			downState = false;
			break;
		}
	}
}
