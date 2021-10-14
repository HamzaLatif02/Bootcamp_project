class Food{
  PVector position;
  float radius;
  color colour;
  PShape shp;
  
  Food(){
    position = new PVector(random(radius*2, width-radius*2), random(radius*2, height-radius*2));
    radius = 10;
    colour = color(216,98,98);
    shp = loadShape("cherryred.svg"); //load shape for food
  }
  
  void draw(){
    fill(colour);
    shape(shp, position.x-radius,position.y-radius,radius*2,radius*2); //draw shape for food
  }
}
