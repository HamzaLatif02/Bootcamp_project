class SpeedBoost{
  PVector position;
  float size;
  color colour;
  PShape shp;
  
  SpeedBoost(){
    position = new PVector(random(size, width-size), random(size, height-size));
    size = 20;
    colour = color(255,230,0);
    shp = loadShape("speedboost2.svg"); //load speed boost shape
  }
  
  void draw(){
    fill(colour);
    shape(shp, position.x,position.y,size,size); //draw speed boost shape
  }
}
