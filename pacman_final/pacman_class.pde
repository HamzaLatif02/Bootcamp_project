class Pacman {
  PVector position;
  float radius, speed;
  color colour;
  boolean alive;
  PShape shp1,shp2,shp3,shp4,shp5;
  int state;

  Pacman() {
    position = new PVector(width/2, height/2);
    speed = 10;
    radius = 50;
    colour = color(255, 255, 0);
    shp1 = loadShape("pacmanRigth.svg"); //load shape for right movement
    shp2 = loadShape("pacmanLeft.svg"); //load shape for left movement
    shp3 = loadShape("pacmanUp.svg"); //load shape for up movement
    shp4 = loadShape("pacmanDown.svg"); //load shape for down movement
    shp5 = loadShape("pacmanClosed.svg"); //load shape for closed mouth effect
    state = 0;
  }

  void draw() {
    outOfCanvas();
    
    if (frameCount % 20 == 0){ // every third of a second close mouth
      drawClosed();
    } else if (state == 0){
      drawRight();
    } else if (state == 1){
      drawLeft();
    } else if (state == 2){
      drawUp();
    } else if (state == 3){
      drawDown();
    }
  }
    
  void outOfCanvas() { //if the user has reached the end of the canvas, pacman redraws on the other side
    if (position.x > width + radius) {
      position.x = -radius;
    } else if (position.x < -radius) {
      position.x = width;
    } else if (position.y > height + radius) {
      position.y = -radius;
    } else if (position.y < -radius) {
      position.y = height;
    }
  }

  void drawLeft(){
   shape(shp2, position.x - radius, position.y - radius, radius*2,radius*2);
   }

  void drawRight() {
    shape(shp1, position.x - radius, position.y - radius, radius*2,radius*2);
  }

  void drawUp(){
   shape(shp3, position.x - radius, position.y - radius, radius*2,radius*2);
   }

  void drawDown(){
   shape(shp4, position.x - radius, position.y - radius, radius*2,radius*2);
   }
   
   void drawClosed(){
      shape(shp5, position.x - radius, position.y - radius, radius*2,radius*2);
   }
}
