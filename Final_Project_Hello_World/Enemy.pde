class Enemy{
  // variables
  int x;
  int y;
  int w;
  int h;

  int left;
  int right;
  int top;
  int bottom;
  
  int xSpeed;
  
  boolean shouldRemove;
  
  int c;
  
Enemy(int startingX, int startingY, int startingW, int startingH){
  x = startingX;
  y = startingY;
  w = startingW;
  h = startingH;
  
  left = x - w/2;
  right = x + w/2;  //ADD THIS INTO THE MOVE FUNCTION WHEN CREATED
  top = y - h/2;
  bottom = y + h/2;
  
  shouldRemove = false;
  
  xSpeed = 5;
  
  c = int(random(0,5));
}

  void render(){
    rectMode(CENTER);
    rect(x, y, w,h);
    
  }

  void move(){
     x = x + xSpeed;
     
     if (x + w/2 >= width){ 
       xSpeed = -abs(xSpeed);
       y = y + 25;
     }
     
     if (x - w/2 <= 0){ 
       xSpeed = abs(xSpeed);
       y = y + 25;
     }
 
    
    left = x - w/2;
    right = x + w/2; 
    top = y - h/2;
    bottom = y + h/2; 
  }


}
