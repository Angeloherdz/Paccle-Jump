class Bullet {
   
  // variables
  int x;
  int y;
  int d;
  
  int speed;
  
  boolean shouldRemove;
  
  int left;
  int right;
  int top;
  int bottom;
  
  // constructor
  Bullet(int startingX, int startingY){
    x = startingX;
    y = startingY;
   
    d = 15;
    
    speed = 15;
    
    shouldRemove = false;
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }
  
  void render(){
    stroke(#F0DF24);
    fill(#F0DF24);
    circle(x,y,d);
    fill(0);
  }
  
  void move(){
    y -= speed; // y = y - speed
    
    left = x - d/2;
    right = x + d/2;
    top = y - d/2;
    bottom = y + d/2;
  }
  
  void checkRemove(){
   if (y < 0 || key == 'r'){
   shouldRemove = true;
   }
  }
  
  void shootEnemy(Enemy anEnemy){
    // if the bullet collides with the enemy
    // then flag the enemy to be removed
    if (top <= anEnemy.bottom &&
        bottom >= anEnemy.top && 
        left <= anEnemy.right &&
        right >= anEnemy.left){
         anEnemy.shouldRemove = true;
         shouldRemove = true;
         //println("shot enemy");
          
        }
  }
  
}
