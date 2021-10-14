class Ghost {
  PVector position;
  PVector speed;
  float radius;
  color colour;

  Ghost() {
    position = new PVector(random(radius*2, width-radius*2), random(radius*2, height-radius*2));
    validInitPos();
    speed = new PVector(random(-1, 1), random(-1, 1));
    radius = 50;
    colour = color(random(255), random(255), random(255));
  }

  void draw() {
    // draw body
    noStroke();
    fill(colour);
    //rotation of arc
    pushMatrix();
    translate(position.x,position.y); //move origin to center of arc
    rotate(PI); //rotate 180 degrees
    translate(-position.x,-position.y); // move back origin
    arc(position.x, position.y, radius*2, radius*2, 0,PI); // draw arc
    popMatrix();
    //end rotation
    noStroke();
    fill(colour);
    for (int i = 0; i< (radius*2)+1; i+=20){
      triangle(position.x-radius,position.y, position.x+radius,position.y, position.x -radius+i, position.y+radius);
    }
    
    //draw white part of eye
    stroke(2);
    fill(255);
    ellipse(position.x-20,position.y-20, 10,20);
    ellipse(position.x+20,position.y-20, 10,20);
    
    //draw eyeball
    fill(0);
    circle(position.x-20,position.y-15, radius/5);
    circle(position.x+20,position.y-15, radius/5);
    
    
    move(); //move ghosts
    checkCollision(); //check if the ghosts collided with the border
  }

  void move() { //move ghosts
    position.x += speed.x;
    position.y += speed.y;
  }

  void checkCollision() { //check if ghosts reached the border, if it has then bounce off
    if (position.x + radius > width && speed.x > 0) {
      speed.x = -1*speed.x;
    } else if (position.x - radius < 0 && speed.x < 0) {
      speed.x = -1*speed.x;
    }
    
    if(position.y + radius > width && speed.y > 0){
      speed.y = -1*speed.y;
    } else if (position.y - radius < 0 && speed.y < 0){
      speed.y = -1*speed.y;
    }
  }
  
  void validInitPos(){ //make sure the initial position of ghosts is not too close with the user in order to play the game
    while((position.x  > width/2-width/4 && position.x < width/2+width/4) || (position.y > height/2-height/4 && position.y < height/2+height/4)){
      position = new PVector(random(radius*2, width-radius*2), random(radius*2, height-radius*2));
    }
  }
}
