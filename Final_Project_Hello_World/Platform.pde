class Platform {


  // variables
  int x;
  int y;
  int w;
  int h;

  int left;
  int right;
  int top;
  int bottom;

  // constructor
  Platform(int startingX, int startingY) {
    rectMode(CENTER);

    x = startingX;
    y = startingY;

    w = max(70, 150 - (millis()-gameStart)/1000*80/30);

    h = 10;

    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }

  void render() {
    stroke(0, 0, 255);
    fill(0);
    rect(x, y, w, h, 25);
  }

  void collide(Player aPlayer) {
    if (left < aPlayer.right &&
      right > aPlayer.left &&
      top < aPlayer.bottom &&
      bottom > aPlayer.bottom &&
      p1.isJumping == false && 
      p1.isFalling == true) {

      //aPlayer.isFalling = false; // stop falling
      //aPlayer.y = y - h/2 - aPlayer.h/2;
        p1.isJumping = true; // start a new jump
        p1.isFalling = false;
        p1.highestY = p1.y - p1.jumpHeight;
        // println("up");
        //  jumpSound.play();
      
    }
  }

  void move() {
    y = y + 2;

    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
  }
  
  

  // POSSIBLY MAKE A REMOVE FEATURE FOR THE PLATFORMS
  // ADD FEATURE THAT REMOVES PLATFORM ONCE PLAYER JUMPS
  // ON IT AFTER X AMOUNT OF TIME
  
  

}
