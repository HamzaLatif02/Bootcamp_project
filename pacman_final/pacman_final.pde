//declare all the variable used
Pacman pacman;
Food[] foods;
Ghost[] ghosts;
SpecialFood[] sFoods;
SpeedBoost[] sBoosts;

int totScore;
int timeDeath, timeExit;
int clickedFrame = 0;
boolean alive, gameStarted;
int seconds, minutes;
String timer;
PFont font1, font2;  

void setup() {
  
  //initialise all the variables used
  size(800, 800);
  totScore = 0;
  timeDeath = 0;
  timeExit = 0;
  alive = true;
  gameStarted = false;
  seconds = 0;
  minutes = 0;
  
  font1 = createFont("Pacmania Italic.otf", 100);
  font2 = createFont("upheavtt.ttf", 30);

  pacman = new Pacman();
  foods = new Food[10];
  ghosts = new Ghost[4];
  sFoods = new SpecialFood[3];
  sBoosts = new SpeedBoost[1];
  
  //initialise all the elements in the array, in this case 10
  for (int i=0; i< foods.length; i++) {
    foods[i] = new Food();
  }
  
  //initialise all the elements in the array, in this case 3
  for (int i=0; i< sFoods.length; i++) {
    sFoods[i] = new SpecialFood();
  }
  
  //initialise all the elements in the array, in this case 1
  for (int i=0; i< sBoosts.length; i++) {
    sBoosts[i] = new SpeedBoost();
  }
  
  //initialise all the elements in the array, in this case 4
  for (int i=0; i< ghosts.length; i++) {
    ghosts[i] = new Ghost();
  }
}

void draw() {
  background(0); //set background as black every draw

  if (gameStarted == false) { //if the game hasn't started yet, then display menu
    drawMenu();
  } else if (totScore >= 300 ) { //if the score is greater or equal than 300 the user wins, so display the win screen
    drawWin();
  } else {
    playGame();  //otherwise play the game
  }
}

void playGame() { //all the functions required to play the game
  stillAlive(); //check if the user is still alive

  if (alive == false) {  //if the user is dead then display the loss screen
    drawLoss();
  } else {
    for (Food food : foods) {  //draw all the elements in the food array
      food.draw();
    }

    for (SpecialFood sFood : sFoods) {  //draw all the elements in the special food array
      sFood.draw();
    }
    
    for (SpeedBoost sBoost : sBoosts){ //draw the speed booster element
      sBoost.draw(); 
    }
    
    for (Ghost ghost : ghosts) { //draw all the elements in the ghost array
      ghost.draw();
    }

    pacman.draw(); //draw pacman

    foodEaten(); //check if a food element has been eaten
    specialFoodEaten(); //check if a special food has been eaten
    sBoostEaten(); //check if a speed booster has been eaten
    ghostSpeed(); //increase ghosts speed every 30 seconds by 50%
    updateBoostPos(); //every 30 seconds the position of the speed booster changes
    drawTimer(); // draw the timer, bottom left corner
    drawScore(); //draw current score, bottom right corner
  }
}

void drawMenu() { //draw the menu

  //draw the title in a custom font at the top center position
  textFont(font1);
  textSize(100);
  textAlign(CENTER, CENTER);
  fill(250, 150, 0);
  text("PACMAN 1.1", width/2, height/2 - 200);
  fill(250, 240, 60);
  text("PACMAN 1.1", width/2+2, height/2 - 198);
  
  //draw subtitle in a custom font at the top center position
  textFont(font2);
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(175, 25, 25);
  text("RULES AND INFO", width/2, height/2 - 50);
  fill(250, 130, 60);
  text("RULES AND INFO", width/2 +2, height/2 - 48);
  
  //draw all the rules and info in a custom font at the center of the screen
  textFont(font2);
  textSize(30);
  textAlign(CENTER, CENTER);
  fill(255);
  text("1. WHEN YOU TOUCH A GHOST, THE GAME IS OVER", width/2, height/2);
  text("2. YOU CAN GO THROUGH THE BORDER, GHOSTS CAN'T", width/2, height/2 + 50);
  text("3. RED FOOD = 1 POINT, BLUE FOOD = 10 POINTS", width/2, height/2+100);
  text("ORANGE TUBE INCREASES PACMAN SPEED BY 5% ", width/2, height/2+150);
  text("4. EVERY 30 SEC GHOST'S SPEED INCREASES BY 50%", width/2, height/2+200);
  text("5. REACH 300 POINTS TO WIN", width/2, height/2+250);
  
  //draw instructions to start the game
  textFont(font2);
  textSize(50);
  textAlign(CENTER, CENTER);
  fill(20, 156, 162);
  text("PRESS SPACEBAR TO START!", width/2, height/2 + 350);
  fill(139, 250, 247);
  text("PRESS SPACEBAR TO START!", width/2+2, height/2 + 352);
}

void drawLoss() { //draw screen in case of loss

  //draw "game over" title in a custom font at the top center position
  textFont(font1);
  textSize(100);
  textAlign(CENTER, CENTER);
  fill(255);
  text("GAME OVER", width/2, height/2-100);
  fill(255, 0, 0);
  text("GAME OVER", width/2+2, height/2-98);
  
  //draw score and time values in a custom font at the center of the screen
  textFont(font2);
  textSize(50);
  fill(255);
  text("YOUR SCORE: " + totScore, width/2, height/2+50);
  text("YOUR TIME: " + timer, width/2, height/2+100);
  
  //draw instructions in a custom font to exit the game
  textFont(font2);
  textSize(50);
  fill(33, 219, 78);
  text("CLICK TO EXIT", width/2, height/2+300);
  fill(194, 240, 200);
  text("CLICK TO EXIT", width/2+2, height/2+302);

  //wait 60 seconds before the user click is accepted again
  if (frameCount < clickedFrame + 60) { //if user clicks anywhere inside the screen than exit the game
    exit();
  }
}

void drawWin() { //draw screen in case of victory
  
  //draw "you won" title in a custom font at top center position
  textFont(font1);
  textSize(100);
  textAlign(CENTER, CENTER);
  fill(255);
  text("YOU WON!", width/2, height/2-100);
  fill(57, 160, 227);
  text("YOU WON!", width/2+2, height/2-98);
  
  //draw score and time values in a custom font at the center of the screen
  textFont(font2);
  textSize(50);
  fill(255);
  text("YOUR SCORE: " + totScore, width/2, height/2+50);
  text("YOUR TIME: " + timer, width/2, height/2+100);
  
  //draw instructions in a custom font to exit the game
  textFont(font2);
  textSize(50);
  fill(33, 219, 78);
  text("CLICK TO EXIT", width/2, height/2+300);
  fill(194, 240, 200);
  text("CLICK TO EXIT", width/2+2, height/2+302);

  //wait 60 seconds before the user click is accepted
  if (frameCount < clickedFrame + 60) {
    exit();
  }
}

void drawTimer() { //draw timer in format minutes:seconds
  if (seconds < 10 && minutes < 10) {
    timer = "0" + minutes + ":0" + seconds;
  } else if (seconds < 10) {
    timer = minutes + ":0" + seconds;
  } else if (minutes < 10) {
    timer = "0" + minutes + ":" + seconds;
  } else {
    timer = minutes + ":" + seconds;
  }

  if (frameCount % 60 == 0) {
    seconds++;
  } else if (seconds == 60) {
    minutes++;
    seconds = 0;
  }
  
  textFont(font2);
  textSize(30);
  textAlign(LEFT);
  fill(210,210,210);
  text(timer, 50, height-50);
}

void drawScore(){ //every time red food is eaten score increases by 1, every time blue food is eaten score increases by 10
  textFont(font2);
  textSize(30);
  textAlign(RIGHT);
  fill(47,245,35);
  text("SCORE: " + totScore, width-50, height-50);
}

void stillAlive() { //check if the user is still alive
  for (Ghost ghost : ghosts) {
    if (dist(pacman.position.x, pacman.position.y, ghost.position.x, ghost.position.y)<100) {
      alive = false;
    }
  }
}

void foodEaten() { //check if the distance between the food and pacman is less than the radius of pacman, if it is then the food has been eaten
  for (Food food : foods) {
    if (dist(pacman.position.x, pacman.position.y, food.position.x, food.position.y) < pacman.radius) {
      food.position = new PVector(random(food.radius*2, width-food.radius*2), random(food.radius*2, height-food.radius*2));
      totScore += 1;
    }
  }
}

void specialFoodEaten() { //check if the distance between the food and pacman is less than the radius of pacman, if it is then the food has been eaten
  for (SpecialFood sFood : sFoods) {
    if (dist(pacman.position.x, pacman.position.y, sFood.position.x, sFood.position.y) < pacman.radius) {
      sFood.position = new PVector(random(sFood.radius*2, width-sFood.radius*2), random(sFood.radius*2, height-sFood.radius*2));
      totScore += 10;
    }
  }
}

void sBoostEaten() { //check if the distance between the boost and pacman is less than the radius of pacman, if it is then the boost has been eaten
    for (SpeedBoost sBoost : sBoosts){
    if (dist(pacman.position.x, pacman.position.y, sBoost.position.x, sBoost.position.y) < pacman.radius) {
      sBoost.position = new PVector(random(sBoost.size*2, width-sBoost.size*2), random(sBoost.size*2, height-sBoost.size*2));
      pacman.speed *= 1.05;
    }
    }
}

void ghostSpeed() { //increaes ghost speed by 50% every 30 seconds
  if (frameCount % 1800 == 0) {
    for (Ghost ghost : ghosts) {
      ghost.speed.x *= 1.5;
      ghost.speed.y *= 1.5;
    }
  }
}

void updateBoostPos(){ //change speed boost position every 30 seconds
  if (frameCount % 1800 == 0){
    for (SpeedBoost sBoost : sBoosts){
    sBoost.position = new PVector (random(sBoost.size*2, width-sBoost.size*2), random(sBoost.size*2, height-sBoost.size*2));  
  }
  }
}

void keyPressed() { //check what key has been pressed and proceed accordingly
  if (alive == true) {
    if (key == 'w' || keyCode == UP) {
      pacman.state = 2;
      pacman.position.y -= pacman.speed;
    } else if (key == 's' || keyCode == DOWN) {
      pacman.state = 3;
      pacman.position.y += pacman.speed;
    } else if (key == 'a' || keyCode == LEFT) {
      pacman.state = 1;
      pacman.position.x -= pacman.speed;
    } else if (key == 'd' || keyCode == RIGHT) {
      pacman.state = 0;
      pacman.position.x += pacman.speed;
    }
  }

  if (key == ' ') {
    gameStarted = true;
  }
}

void mousePressed() { 
  clickedFrame = frameCount;
}
