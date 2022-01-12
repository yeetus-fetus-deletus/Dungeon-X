void drawRoomG() { //Gryffindor theme room ========================================================================================================================
  //walls ========================================
  background(#740001);
  strokeWeight(2);
  stroke(#C0C0C0);
  line(0, 0, width/3, height/2);
  line(width, 0, width*2/3, height/2);
  line(width, height, width*2/3, height/2);
  line(0, height, width/3, height/2);

  //decoration ========================================
  noFill();
  stroke(#D3A625);

  strokeWeight(4);
  rectMode(CORNER);
  //northwest
  triangle(0, 0, 60, 0, 0, 60);
  triangle(40, 40, 85, 40, 40, 85);
  triangle(70, 70, 100, 70, 70, 100);
  triangle(90, 90, 105, 90, 90, 105);
  rect(0, 60, 40, 25);
  rect(60, 0, 25, 40);
  rect(40, 85, 30, 15);
  rect(85, 40, 15, 30);
  rect(70, 100, 20, 5);
  rect(100, 70, 5, 20);
  rect(90, 105, 10, 3);
  rect(105, 90, 3, 10);
  //northeast
  triangle(width, 0, width-60, 0, width, 60);
  triangle(width-40, 40, width-85, 40, width-40, 85);
  triangle(width-70, 70, width-100, 70, width-70, 100);
  triangle(width-90, 90, width-105, 90, width-90, 105);
  rect(width-40, 60, 40, 25);
  rect(width-85, 0, 25, 40);
  rect(width-70, 85, 30, 15);
  rect(width-100, 40, 15, 30);
  rect(width-90, 100, 20, 5);
  rect(width-105, 70, 5, 20);
  rect(width-100, 105, 10, 3);
  rect(width-108, 90, 3, 10);
  //southwest
  triangle(0, height, 60, height, 0, height-60);
  triangle(40, height-40, 85, height-40, 40, height-85);
  triangle(70, height-70, 100, height-70, 70, height-100);
  triangle(90, height-90, 105, height-90, 90, height-105);
  rect(0, height-85, 40, 25);
  rect(60, height-40, 25, 40);
  rect(40, height-100, 30, 15);
  rect(85, height-70, 15, 30);
  rect(70, height-105, 20, 5);
  rect(100, height-90, 5, 20);
  rect(90, height-108, 10, 3);
  rect(105, height-100, 3, 10);
  //southeast
  triangle(width, height, width-60, height, width, height-60);
  triangle(width-40, height-40, width-85, height-40, width-40, height-85);
  triangle(width-70, height-70, width-100, height-70, width-70, height-100);
  triangle(width-90, height-90, width-105, height-90, width-90, height-105);
  rect(width-40, height-85, 40, 25);
  rect(width-85, height-40, 25, 40);
  rect(width-70, height-100, 30, 15);
  rect(width-100, height-70, 15, 30);
  rect(width-90, height-105, 20, 5);
  rect(width-105, height-90, 5, 20);
  rect(width-100, height-108, 10, 3);
  rect(width-108, height-100, 3, 10);
  rectMode(CENTER);
  strokeWeight(5);

  int i = 0;
  while (i < nGX) {
    line(xGa[i], 0, xGb[i], 400);
    line(xGa[i], 800, xGb[i], 400);
    i = i + 1;
  }
  i = 0;
  while (i < nGY) {
    line(0, yGa[i], 600, yGb[i]);
    line(1200, yGa[i], 600, yGb[i]);
    i = i + 1;
  }

  line(0, 0, 550, 100);
  line(650, 100, 1200, 0);
  line(0, 0, 100, 350);
  line(100, 450, 0, 800);
  line(width, height, width-550, height-100);
  line(width-650, height-100, 0, height);
  line(width, 0, width-100, 350);
  line(width-100, 450, width, 800);

  drawFloor();
  strokeWeight(5);
  stroke(#D3A625);
  drawExits();
}


void drawRoomR() { //Ravenclaw theme room ========================================================================================================================
  //walls ========================================
  background(#222F5B);
  strokeWeight(2);
  stroke(#5D5D5D);
  line(0, 0, width/3, height/2);
  line(width, 0, width*2/3, height/2);
  line(width, height, width*2/3, height/2);
  line(0, height, width/3, height/2);

  //decoration ========================================
  strokeWeight(4);
  stroke(#946B2D);
  noFill();

  rect(width/2, height/2, width-30, height-30, 80);
  rect(width/2, height/2, width-100, height-100, 60);
  rect(width/2, height/2, width-150, height-150, 40);
  rect(width/2, height/2, width-180, height-180, 20);

  rect(width/2, height/2, width-30, height-30, 40);
  rect(width/2, height/2, width-100, height-100, 30);
  rect(width/2, height/2, width-150, height-150, 20);
  rect(width/2, height/2, width-180, height-180, 10);

  rect(width/2, height/2, width-30, height-30);
  rect(width/2, height/2, width-100, height-100);
  rect(width/2, height/2, width-150, height-150);
  rect(width/2, height/2, width-180, height-180);

  line(100, 100, 325, 0);
  line(325, 0, 550, 100);
  line(650, 100, 875, 0);
  line(875, 0, 1100, 100);

  line(100, 100, 0, 225);
  line(0, 225, 100, 350);
  line(100, 450, 0, 575);
  line(0, 575, 100, 700);

  line(width-100, height-100, width-325, height);
  line(width-325, height, width-550, height-100);
  line(width-650, height-100, width-875, height);
  line(width-875, height, width-1100, height-100);

  line(width-100, 100, width, 225);
  line(width, 225, width-100, 350);
  line(width-100, 450, width, 575);
  line(width, 575, width-100, 700);

  arc(width/2, -20, width-20, 238, 0, PI);
  arc(width/2, height+20, width-20, 238, PI, TAU);
  arc(-20, height/2, 238, height-20, HALF_PI, TAU+HALF_PI);
  arc(width+20, height/2, 238, height-20, HALF_PI, PI+HALF_PI);

  drawFloor();
  strokeWeight(5);
  stroke(#946B2D);
  drawExits();
}

void drawRoomS() { //Slytherin theme room ========================================================================================================================
  //walls ========================================
  background(#1A472A);
  strokeWeight(2);
  stroke(#AAAAAA);
  line(0, 0, width/3, height/2);
  line(width, 0, width*2/3, height/2);
  line(width, height, width*2/3, height/2);
  line(0, height, width/3, height/2);

  //decoration ========================================
  strokeWeight(5);
  stroke(#2A623D);
  noFill();

  int i = 0;
  while (i < nSX) {
    line(width/2, 0, xSb[i], 100);
    line(width/2, 800, xSb[i], 700);
    i = i + 1;
  }
  i = 0;
  while (i < nSY) {
    line(0, height/2, 100, ySb[i]);
    line(1200, height/2, 1100, ySb[i]);
    i = i + 1;
  }

  strokeWeight(8);
  stroke(#5D5D5D);
  //northwest
  arc(25, 25, 50, 50, radians(225), radians(360));
  arc(25, 25, 50, 50, radians(0), radians(45));
  arc(58, 58, 42, 42, radians(45), radians(225));
  arc(85, 85, 32, 32, radians(225), radians(360));
  arc(85, 85, 32, 32, radians(0), radians(45));
  //northeast
  arc(width-25, 25, 50, 50, radians(135), radians(315));
  arc(width-58, 58, 42, 42, radians(315), radians(360));
  arc(width-58, 58, 42, 42, radians(0), radians(135));
  arc(width-85, 85, 32, 32, radians(135), radians(315));
  //southwest
  arc(25, height-25, 50, 50, radians(315), radians(360));
  arc(25, height-25, 50, 50, radians(0), radians(135));
  arc(58, height-58, 42, 42, radians(135), radians(315));
  arc(85, height-85, 32, 32, radians(315), radians(360));
  arc(85, height-85, 32, 32, radians(0), radians(135));
  //southeast
  arc(width-25, height-25, 50, 50, radians(45), radians(225));
  arc(width-58, height-58, 42, 42, radians(225), radians(360));
  arc(width-58, height-58, 42, 42, radians(0), radians(45));
  arc(width-85, height-85, 32, 32, radians(45), radians(225)); 

  stroke(#10311B);
  //northwest
  arc(25, 25, 50, 50, radians(45), radians(225));
  arc(58, 58, 42, 42, radians(225), radians(405));
  arc(85, 85, 32, 32, radians(45), radians(225));
  //northeast
  arc(width-25, 25, 50, 50, radians(315), radians(495));
  arc(width-58, 58, 42, 42, radians(135), radians(315));
  arc(width-85, 85, 32, 32, radians(315), radians(495));
  //southwest
  arc(25, height-25, 50, 50, radians(135), radians(315));
  arc(58, height-58, 42, 42, radians(315), radians(495));
  arc(85, height-85, 32, 32, radians(135), radians(315));
  //southeast
  arc(width-25, height-25, 50, 50, radians(225), radians(405));
  arc(width-58, height-58, 42, 42, radians(45), radians(225));
  arc(width-85, height-85, 32, 32, radians(225), radians(405));

  strokeWeight(20);
  arc(172, 50, 125, 80, radians(20), radians(225));
  arc(305, 73, 150, 80, radians(200), radians(340));
  arc(450, 50, 150, 80, radians(0), radians(160));
  arc(width-172, 50, 125, 80, radians(315), radians(520));
  arc(width-305, 73, 150, 80, radians(200), radians(340));
  arc(width-450, 50, 150, 80, radians(20), radians(180));
  arc(172, height-50, 125, 80, radians(135), radians(340));
  arc(305, height-73, 150, 80, radians(20), radians(160));
  arc(450, height-50, 150, 80, radians(200), radians(360));
  arc(width-172, height-50, 125, 80, radians(200), radians(405));
  arc(width-305, height-73, 150, 80, radians(20), radians(160));
  arc(width-450, height-50, 150, 80, radians(180), radians(340));
  strokeWeight(15);
  stroke(#AAAAAA);
  arc(50, 162, 80, 125, radians(225), radians(420));
  arc(92, 270, 80, 130, radians(120), radians(240));
  arc(50, height-162, 80, 125, radians(300), radians(495));
  arc(92, height-270, 80, 130, radians(120), radians(240));

  arc(width-50, 162, 80, 125, radians(120), radians(315));
  arc(width-92, 270, 80, 130, radians(300), radians(420));
  arc(width-50, height-162, 80, 125, radians(45), radians(240));
  arc(width-92, height-270, 80, 130, radians(300), radians(420));

  drawFloor();
  strokeWeight(5);
  stroke(#5D5D5D);
  drawExits();
}


void drawRoomH() { //Hufflepuff theme room ========================================================================================================================
  //walls ========================================
  background(black);
  strokeWeight(2);
  stroke(white);
  line(0, 0, width/3, height/2);
  line(width, 0, width*2/3, height/2);
  line(width, height, width*2/3, height/2);
  line(0, height, width/3, height/2);

  //decoration ========================================
  strokeWeight(3);
  stroke(#FFDB00);
  noFill();

  rectMode(CORNER);
  int i = 0;
  while (i < nHX) {
    square(xHa[i], yHa[i], 25);
    square(xHa[i], yHb[i], 25);
    square(xHb[i], yHc[i], 25);
    square(xHb[i], yHd[i], 25);
    i = i + 1;
  }
  i = 0;
  while (i < nHY) {
    square(xHc[i], yHe[i], 25);
    square(xHd[i], yHe[i], 25);
    square(xHe[i], yHf[i], 25);
    square(xHf[i], yHf[i], 25);
    i = i + 1;
  }
  rectMode(CENTER);

  strokeWeight(10);
  stroke(#60605C);
  arc(100, 0, width-200, 200, 0, HALF_PI);
  arc(width-100, 0, width-200, 200, HALF_PI, PI);
  arc(100, height, width-200, 200, PI+HALF_PI, TAU);
  arc(width-100, height, width-200, 200, PI, PI+HALF_PI);
  arc(0, 100, 200, height-200, 0, HALF_PI);
  arc(width, 100, 200, height-200, HALF_PI, PI);
  arc(0, height-100, 200, height-200, PI+HALF_PI, TAU);
  arc(width, height-100, 200, height-200, PI, PI+HALF_PI);

  drawFloor();
  strokeWeight(5);
  stroke(#FFF4B1);
  drawExits();
}
void drawFloor() {
  //floor ========================================
  noStroke();
  rect(width/2, height/2, width-200, height-200);
  image(floor, (width/4)+50, (height/4)+50, (width/2)-100, (height/2)-100);
  image(floor, (width/4)+50, (height*3/4)-50, (width/2)-100, (height/2)-100);
  image(floor, (width*3/4)-50, (height/4)+50, (width/2)-100, (height/2)-100);
  image(floor, (width*3/4)-50, (height*3/4)-50, (width/2)-100, (height/2)-100);
}
void drawExits() {
  //exits: find directions ========================================
  north = map.get(myHero.roomX, myHero.roomY-1);
  east  = map.get(myHero.roomX+1, myHero.roomY);
  south = map.get(myHero.roomX, myHero.roomY+1);
  west  = map.get(myHero.roomX-1, myHero.roomY);
  //exits: draw doors ========================================
  fill(black);
  if (north != #FFFFFF) quad(width/2-60, 30, width/2+60, 30, width/2+30, 100, width/2-30, 100);
  if (east != #FFFFFF) quad(width-30, 340, width-30, 460, width-100, 430, width-100, 370);
  if (south != #FFFFFF) quad(width/2-60, height-30, width/2+60, height-30, width/2+30, height-100, width/2-30, height-100);
  if (west != #FFFFFF) quad(30, 340, 30, 460, 100, 430, 100, 370);
}
