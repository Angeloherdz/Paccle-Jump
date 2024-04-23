class Player{

    // variables
    int x;
    int y;
    
    int w;
    int h;
    
    color c;
    
    boolean isMovingLeft;
    boolean isMovingRight;
    
    boolean isJumping;
    boolean isFalling;
    
    int speed;
    
    int jumpHeight; // distance that you can jump upwards
    int highestY; // y value of the top of your jump
    
    int left;
    int right;
    int top;
    int bottom;
    
    //boolean onPlatform; 
    
    // constructor
    Player(int startingX, int startingY, int startingW, int startingH){
    x = startingX;
    y = startingY;
    w = startingW;
    h = startingH;
    
    isMovingLeft = false;
    isMovingRight = false;
    
    isJumping = false;
    isFalling = false;
    
    speed = 10;
    
    jumpHeight = 185;
    //highestY = y - jumpHeight;
     
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2;
    
    //onPlatform = false;
    }

  // functions
  void render(){
  stroke(0);
  rectMode(CENTER);
  rect(x, y, w, h);
  }

  void move(){
    
    
    if(isMovingLeft == true && x > 0 + w/2){
      x -= speed; // x = x - speed;
    }
    
    if(isMovingRight == true && x < width - w/2){
      x += speed; // x = x + speed;
    }
    // update the bounds of the player 
    
    if (isFalling == false && y < height - h/2){
     y = y + 2;
    }
    
    if (y > height - h/2){
   // println("dead by void");
    state += 1;
    x = width/2;
    y = height/2;
    isFalling = true;
    }
    
        
    left = x - w/2;
    right = x + w/2;
    top = y - h/2;
    bottom = y + h/2; 
    
    
  }


  void jumping(){
    if(isJumping == true){
      y -= speed;
    }
  }

  void falling(){
    if(isFalling == true){
      y += speed;
    }
  }

  void topOfJump(){
    if(y <= highestY){
    isJumping = false; // stop jumping upward
    isFalling = true; // start falling downward
    //println("go down now");
  }
 }
  void land(){
    if(y >= height - h/2){
      isFalling = false; // stop falling 
    }
  }

  // check to see if the player is colliding with any platform
  // if the player is not colliding with any platforms, then
  // make the player start falling
  void fallOfPlatform(ArrayList<Platform> aPlatformList){
  
      // check that the player is not in the middle of a jump
      // and check that the player is not on the ground 
      if (isJumping == false && y < height - h/2){
      
        boolean onPlatform = false;
        
        for (Platform aPlatform : aPlatformList){
          // if the player is colliding with a platform
          if (top <= aPlatform.bottom &&
              bottom >= aPlatform.top &&
              left <= aPlatform.right &&
              right >= aPlatform.left){
                 onPlatform = true; // make onPlatform true
              }
        }
            // if you are not on a platform,
            // start falling
            if (onPlatform == false){
              isFalling = true;
           
        }
         
      }
  }
  
  void collisonEnemy(Enemy anEnemy){
    if (top <= anEnemy.bottom &&
        bottom >= anEnemy.top && 
        left <= anEnemy.right &&
        right >= anEnemy.left && 
        anEnemy.y > 0 + 5){
        //  println("dead by enemy");
          x = width/2;
          y = height/2;
          isFalling = true;
          isJumping = false;
          state = 2;

        }
  }
  
 


}
