import processing.sound.*;

 SoundFile gameStartSound;
 SoundFile killGhostSound;
 SoundFile deadPacSound;
 SoundFile backgroundSound;
 SoundFile startScreenSound;

boolean gameStarted;
boolean pacDied;

// declaring my vars
Player p1;

Platform plat1;
Platform plat2;
Platform plat3;
Platform plat4;
Platform plat5;

ArrayList<Platform> platformList;

ArrayList<Bullet> bulletList;

Enemy e1;
// Enemy e2;
ArrayList<Enemy> enemyList;

int platformTimer;
int enemyTimer;
int gameStart;

int state = 0;

int scoreTime;

PImage gameoverScreen;

PImage iconic;
PImage redG;
PImage blueG;
PImage pinkG;
PImage orangeG;

PImage pac1;
PImage redG1;
PImage blueG1;
PImage pinkG1;
PImage orangeG1;

// PAC MAN
PImage[] pacImages = new PImage[2];
Animation pacAnimation;

// B-GHOST
PImage[] bGhost = new PImage[2];
Animation bGhostAnimation;

// O-GHOST
PImage[] oGhost = new PImage[2];
Animation oGhostAnimation;

// P-GHOST
PImage[] pGhost = new PImage[2];
Animation pGhostAnimation;

// R-GHOST
PImage[] rGhost = new PImage[2];
Animation rGhostAnimation;

int ghostColor = int (random(1,4));

void setup() {
  size(800, 600);
  rectMode(CENTER);
  // initialize my vars
  p1 = new Player(width/2, height/2 + 50, 50, 50);

  plat1 = new Platform(width/2, 500);
  plat2 = new Platform(width/2 + 100, 400);
  plat3 = new Platform(width/2 - 150, 250);
  plat4 = new Platform(width/2 - 150, 100);
  plat5 = new Platform(width/2 + 200, 50);

  platformList = new ArrayList<Platform>();
  
      platformList.add(plat1);
      platformList.add(plat2);
      platformList.add(plat3);
      platformList.add(plat4);
      platformList.add(plat5);

  //gameoverScreen = loadImage("background.png");
  //rectMode(CENTER);
  //imageMode(CENTER);
  //gameoverScreen.resize(width, height);
  
    gameStartSound = new SoundFile(this, "gameStart.wav");
    killGhostSound = new SoundFile(this, "killGhost.wav");
    deadPacSound = new SoundFile(this, "pacdied.wav");
    backgroundSound = new SoundFile(this, "background.wav");
    startScreenSound = new SoundFile(this, "startScreenSound.wav");

  bulletList = new ArrayList<Bullet>();

 // e1 = new Enemy(300, -100, 55, 55);
  //e2 = new Enemy(500, -50, 55, 55);

  enemyList = new ArrayList<Enemy>();
  //enemyList.add(e1);
  // enemyList.add(e2);

  platformTimer = millis();
  gameStart = millis();
  enemyTimer = millis();
  
  gameStarted = true;
  
  // PAC IMAGES<======= AND GHOSTS
  // GHOSTSS <=====================
  
  for(int index=0; index<pacImages.length; index++){
    pacImages[index] = loadImage("pac" + index + ".png");
  }
 pacAnimation = new Animation(pacImages, .15, 3.0);
 
  for(int index=0; index<bGhost.length; index++){
    bGhost[index] = loadImage("Bghosts" + index + ".png");
  }
 bGhostAnimation = new Animation (bGhost, .20, 3.0);  
  
  for(int index=0; index<oGhost.length; index++){
    oGhost[index] = loadImage("Oghosts" + index + ".png");
  }
 oGhostAnimation = new Animation (oGhost, .20, 3.0);  
 
  for(int index=0; index<pGhost.length; index++){
    pGhost[index] = loadImage("Pghosts" + index + ".png");
  }
 pGhostAnimation = new Animation (pGhost, .20, 3.0);  
 
 for(int index=0; index<rGhost.length; index++){
    rGhost[index] = loadImage("Rghosts" + index + ".png");
  }
 rGhostAnimation = new Animation (rGhost, .20, 3.0);  
  
   iconic = loadImage("iconic.png");
   iconic.resize(300, 70);
   redG = loadImage("redG.png");
   redG.resize(70, 70);
   blueG = loadImage("blueG.png");
   blueG.resize(70, 70);
   pinkG = loadImage("pinkG.png");
   pinkG.resize(70, 70);
   orangeG = loadImage("orangeG.png");
   orangeG.resize(70, 70);
   
   redG1 = loadImage("Rghosts0.png");
   redG1.resize(150, 150);
   blueG1 = loadImage("Bghosts0.png");
   blueG1.resize(150, 150);
   pinkG1 = loadImage("Pghosts0.png");
   pinkG1.resize(150, 150);
   orangeG1 = loadImage("Oghosts0.png");
   orangeG1.resize(150, 150);
   
   pac1 = loadImage("pac1.png");
   pac1.resize(150, 150);
  rectMode(CENTER);
  imageMode(CENTER);
}




void draw() {
  background(0);
  //println(p1.isJumping);

  switch(state) {

  case 0:
    deadPacSound.stop();
    backgroundSound.stop();
    startScreen();
    gameStarted = true;
    break;

  case 1:
  startScreenSound.stop();
    border();
    p1.render();
    p1.move();
    p1.jumping();
    p1.falling();
    p1.topOfJump();
    p1.land();
    p1.fallOfPlatform(platformList);
    pacAnimation.display(p1.x, p1.y);
    // println(...);
   // pacAnimation.isAnimating = true;
    scoreTime = millis() - gameStart;
    
    displayTimer(scoreTime);
    
    for (Enemy anEnemy : enemyList) {
      p1.collisonEnemy(anEnemy);
    }

    spawningItems();
    forLoopsforMyArrays();
    pacDied = true;
    break;

  case 2:
  gameStartSound.stop();
  backgroundSound.stop();
   //   image(gameoverScreen, width/2, height/2);
   
    removingItems();
    deadScreen();
    
    fill(0, 0, 255);
    score(scoreTime);  
    break;
  }

if (state == 0 && startScreenSound.isPlaying() == false){
  startScreenSound.play();
}


if (state == 1 && gameStarted == true){
     gameStartSound.play();
     gameStarted = false;
     // boolean ... next music sound for background 
  }
 
 if (state == 2 && pacDied == true){
     deadPacSound.play();
     pacDied = false;
  }

 if (backgroundSound.isPlaying() == false && gameStartSound.isPlaying() == false){
   backgroundSound.play();
 }



  //   if (p1.isJumping == false && p1.isFalling == false){
  //      p1.isJumping = true; // start a new jump
  //      p1.highestY = p1.y - p1.jumpHeight;
  ////  jumpSound.play();
  //  }
}

void removingItems() {
  for (int i = 0; i<platformList.size(); i++) {
    platformList.remove(platformList.get(i));
  }

  for (int i = 0; i<enemyList.size(); i++) {
    enemyList.remove(enemyList.get(i));
  }
}

void border(){
  stroke(0, 0, 255);
  fill(0);
  strokeWeight(4);
  rect(width/2, height/2 - 10, 795, 615);
  strokeWeight(1);
}

void deadScreen() {
//  background(42);
  fill(255);
  textSize(80);
  textAlign(CENTER, CENTER);
  fill(#F0DF24);
  text("Game Over", width/2, height/2 - 50);
  textSize(20);
  fill(255);
  text("Press Space to Continue", width/2, height/2 + 50);
  
  image(redG, 680, 150);
  image(blueG, 720, 250);
  image(pinkG, 720, 350);
  image(orangeG, 680, 450);
  
  image(redG1, 140, 150);
  image(blueG1, 100, 250);
  image(pinkG1, 100, 350);
  image(orangeG1, 140, 450);
  
  image(pac1, width/2, height/2 + 150);
}

 //<>//

void forLoopsforMyArrays() {
  for (Enemy anEnemy : enemyList) {
    //anEnemy.render();
    anEnemy.move();
    
     if(anEnemy.c == 1){
    pGhostAnimation.display(anEnemy.x, anEnemy.y);
    pGhostAnimation.isAnimating = true;
    }
     if(anEnemy.c == 2){
    bGhostAnimation.display(anEnemy.x, anEnemy.y);
    bGhostAnimation.isAnimating = true;
    }
    if(anEnemy.c == 3){
    oGhostAnimation.display(anEnemy.x, anEnemy.y);
    oGhostAnimation.isAnimating = true;
    }
     if(anEnemy.c == 4){
    rGhostAnimation.display(anEnemy.x, anEnemy.y);
    rGhostAnimation.isAnimating = true;
    }
  }
  //<>//
  
  

  // for loop to go through all platforms
  for (Platform aPlatform : platformList) {
    aPlatform.move();
    aPlatform.render();
    aPlatform.collide(p1);
  }

  // for loop that goes through all bullets
  for (Bullet aBullet : bulletList) {
    aBullet.render();
    aBullet.move();
    aBullet.checkRemove();

    for (Enemy anEnemy : enemyList) {
      aBullet.shootEnemy(anEnemy);
    }
  }
  // for loop that removes unwanted bullets
  for (int i = bulletList.size()-1; i >= 0; i -= 1) {
    Bullet aBullet = bulletList.get(i);

    if (aBullet.shouldRemove == true) {
      bulletList.remove(aBullet);
    }
  }
  // for loop that removes killed enemies
  for (int i = enemyList.size()-1; i >= 0; i -= 1) {
    Enemy anEnemy = enemyList.get(i);

    if (anEnemy.shouldRemove == true) {
      enemyList.remove(anEnemy);
      killGhostSound.play();
    }
  }
}

void spawningItems() {
  //  SPAWNING PLATFORMS AS TIME GOES ON <========
  if (millis() - platformTimer > 1000) {
    platformList.add(new Platform(int(random(175, width-175)), -30));
    platformTimer = millis();
  }
  //  SPAWNING ENEMIES AS TIME GOES ON <=====
  if (millis() - enemyTimer > 5000) {
    enemyList.add(new Enemy(int(random(23, width-23)), -30, 40, 40));
    enemyTimer = millis();
  }
}

void displayTimer(int time) {
  // Convert milliseconds to seconds and minutes
//  int seconds = (int)(time / 1000) % 60;
//  int minutes = (int)((time / (1000*60)) % 60);
  
  // Display the timer
  textAlign(CENTER, CENTER);
  textSize(32);
  fill(255);
  text(time, width/10, height/10);
}

void score(int time){
  textSize(32);
  text(time, width/2, height/4);
}

void startScreen() {
  
//  image(iconic, width/2, 100);
  image(redG, 680, 150);
  image(blueG, 720, 250);
  image(pinkG, 720, 350);
  image(orangeG, 680, 450);
  
  image(redG1, 140, 150);
  image(blueG1, 100, 250);
  image(pinkG1, 100, 350);
  image(orangeG1, 140, 450);
  
  image(pac1, width/2, height/2 + 150);
  
  stroke(0, 255, 255);
  strokeWeight(3);
  fill(#F0DF24);
  textSize(80);
  textAlign(CENTER, CENTER);
  text("Paccle Jump", width/2, height/2 - 50);
  fill(255);
  textSize(20);
  text("Press Space to Continue", width/2, height/2 + 50);
}

void keyPressed() {
  if (key == 'a') {
    p1.isMovingLeft = true;
  }

  if (key == 'd') {
    p1.isMovingRight = true;
  }

  //if (key == 'w' && p1.isJumping == false && p1.isFalling == false) {
  //  p1.isJumping = true; // start a new jump
  //  p1.highestY = p1.y - p1.jumpHeight;
  //   jumpSound.play();
  //}

  if (state == 1 && key == ' ') {
    bulletList.add( new Bullet(p1.x, p1.y) );
    pacAnimation.isAnimating = true;
  }

  if (state == 0 || state == 2 && key == ' ') {
    gameStart = millis();
    p1.x = width/2;
    p1.y = height/2;
    p1.isFalling = true;
    p1.isJumping = false;

    if (state == 1 || state == 2) {
      plat1 = new Platform(width/2, 500);
      plat2 = new Platform(width/2 + 100, 400);
      plat3 = new Platform(width/2 - 150, 250);
      plat4 = new Platform(width/2 - 150, 100);
      plat5 = new Platform(width/2 + 200, 50);

      platformList.add(plat1);
      platformList.add(plat2);
      platformList.add(plat3);
      platformList.add(plat4);
      platformList.add(plat5);
    }

    state = 1;
  }

  if (state >= 3) {
    state = 0;
  }
}

void keyReleased() {
  if (key == 'a') {
    p1.isMovingLeft = false;
  }

  if (key == 'd') {
    p1.isMovingRight = false;
  }
}
