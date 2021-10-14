class SpecialFood{
  PVector position;
  float radius;
  color colour;
  PShape shp;
  
  SpecialFood(){
    position = new PVector(random(radius*2, width-radius*2), random(radius*2, height-radius*2));
    radius = 10;
    colour = color(13,210,250);
    shp = loadShape("cherryblue.svg"); //load special food shape
  }
  
  void draw(){
    fill(colour);
    shape(shp, position.x-radius,position.y-radius,radius*2,radius*2); //draw special food shape
  }

}
