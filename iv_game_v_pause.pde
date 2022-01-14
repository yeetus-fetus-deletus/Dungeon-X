void game() { //game mode ================================================================================
  //println(myObjects.size());
  //println(myHero.dir.heading());
  //println(PIECES);
  bossMode = false;

  //room colours ========================================
  if (myHero.roomX <= map.width/2-1 && myHero.roomY <= map.height/2-1) {
    drawRoomG();
  } else if (myHero.roomX >= map.width/2 && myHero.roomY <= map.height/2-1) {
    drawRoomR();
  } else if (myHero.roomX <= map.width/2-1 && myHero.roomY >= map.height/2) {
    drawRoomS();
  } else if (myHero.roomX >= map.width/2 && myHero.roomY >= map.height/2) {
    drawRoomH();
  }
  drawObjects();
  if (!vision) {
    drawDarkness();
  }
  drawMessages();
  drawMap();

  rectMode(CORNER);
  textAlign(RIGHT, CORNER);
  textFont(revamped);
  textSize(20);

  //weapon menu ========================================
  strokeWeight(5);
  stroke(white);
  fill(darkGrey);
  if (choose == 0) {
    fill(blue);
    rect(960, 505, 250, 40);
    fill(white);
    text("AUTO", 1180, 530);
  } else if (choose == 1) {
    rect(960, 545, 250, 40);
  } else if (choose == 2) {
    rect(960, 585, 250, 40);
  } else if (choose == 3) {
    rect(960, 625, 250, 40);
  } else if (choose == 4) {
    rect(960, 665, 250, 40);
  }

  fill(white);
  text("PISTOL", 1180, 570);
  text("SHOTGUN", 1180, 610);
  text("FLAMETHROWER", 1180, 650);
  text("LASER", 1180, 690);



  //health bar ========================================

  float hitpoints = map(myHero.hpMax, 0, myHero.hpMax, 0, 300);
  float damage    = map(myHero.hp, 0, myHero.hpMax, 0, 300);
  textAlign(CORNER, CORNER);
  strokeWeight(3);
  stroke(0);
  fill(white);
  rect(width/6, height*0.9, hitpoints, 20);
  fill(red);
  rect(width/6, height*0.9, damage, 20);
  line(hitpoints*0.1+200, 720, hitpoints*0.1+200, 740);
  line(hitpoints*0.2+200, 720, hitpoints*0.2+200, 740);
  line(hitpoints*0.3+200, 720, hitpoints*0.3+200, 740);
  line(hitpoints*0.4+200, 720, hitpoints*0.4+200, 740);
  line(hitpoints*0.5+200, 720, hitpoints*0.5+200, 740);
  line(hitpoints*0.6+200, 720, hitpoints*0.6+200, 740);
  line(hitpoints*0.7+200, 720, hitpoints*0.7+200, 740);
  line(hitpoints*0.8+200, 720, hitpoints*0.8+200, 740);
  line(hitpoints*0.9+200, 720, hitpoints*0.9+200, 740);
  fill(white);
  textSize(20);
  text(myHero.hp/10+" HP  /  "+myHero.hpMax/10+"  HP", 210, height*0.96);

  //ship speedometer ========================================
  strokeWeight(5);
  stroke(black);
  fill(green);
  arc(width/12, height*0.96, 180, 150, radians(180), radians(200), PIE);
  arc(width/12, height*0.96, 180, 150, radians(200), radians(220), PIE);
  fill(#D0FF03);
  arc(width/12, height*0.96, 180, 150, radians(220), radians(240), PIE);
  fill(yellow);
  arc(width/12, height*0.96, 180, 150, radians(240), radians(260), PIE);
  fill(#FFC503);
  arc(width/12, height*0.96, 180, 150, radians(260), radians(280), PIE);
  fill(orange);
  arc(width/12, height*0.96, 180, 150, radians(280), radians(300), PIE);
  fill(#FF5500);
  arc(width/12, height*0.96, 180, 150, radians(300), radians(320), PIE);
  fill(red);
  arc(width/12, height*0.96, 180, 150, radians(320), radians(340), PIE);
  arc(width/12, height*0.96, 180, 150, radians(340), radians(360), PIE);

  float speedometer = map(myHero.vel.mag(), 0, myHero.speedMax, 180, 360);
  noFill();
  stroke(blue);
  arc(width/12, height*0.96, 180, 150, radians(180), radians(speedometer), PIE);
  stroke(black);
  arc(width/12, height*0.96, 180, 150, radians(180), radians(360), PIE);

  textAlign(CENTER, CORNER);
  textSize(30);
  fill(white);
  text(myHero.speed+"  KN", width/12, height*0.85);
  textAlign(CORNER, CENTER);

  //key pieces collection ========================================
  strokeWeight(6);
  stroke(white);
  fill(#0E5808);
  rect(700, 700, 250, 80);
  if (PIECES == 3) {
    image(piece1, 750, 740, 32.25, 38.25);
  } else if (PIECES == 2) {
    image(piece1, 750, 740, 32.25, 38.25);
    image(piece2, 800, 740, 32.25, 38.25);
  } else if (PIECES == 1) {
    image(piece1, 750, 740, 32.25, 38.25);
    image(piece2, 800, 740, 32.25, 38.25);
    image(piece3, 850, 740, 32.25, 38.25);
  } else if (PIECES == 0) {
    image(piece1, 750, 740, 32.25, 38.25);
    image(piece2, 800, 740, 32.25, 38.25);
    image(piece3, 850, 740, 32.25, 38.25);
    image(piece4, 900, 740, 32.25, 38.25);
  }

  //current floor ========================================
  textAlign(CENTER, CENTER);
  fill(white);
  textSize(35);
  text("FLOOR:  "+myHero.roomZ, 1075, 740);
  textAlign(CORNER, CORNER);

  drawConsole(0, 0);

  textAlign(CENTER, CENTER);
  rectMode(CENTER);

  //pause button ========================================
  pauseButton.show();
  if (pauseButton.click) mode = PAUSE;
  strokeWeight(6);
  if (mouseX > 1120 && mouseX < 1180 && mouseY > 20 && mouseY < 80) {
    stroke(white);
  } else {
    stroke(black);
  }
  line(1140, 35, 1140, 65);
  line(1160, 35, 1160, 65);

  //game over ========================================================================================================================
  if (myHero.hp > 0 && PIECES <= 0) {
    win = true;
    endGame(1);
  } else if (myHero.hp <= 0) {
    win = false;
    endGame(2);
    explode(myHero.loc.x, myHero.loc.y, white, 10, 100);
  }
}

void drawObjects() { //game objects ========================================
  int i = 0;
  while (i < myObjects.size()) {
    GameObject Obj = myObjects.get(i);
    if (with(Obj)) {
      Obj.show();
      Obj.act();
    }
    if (Obj.hp <= 0) {
      myObjects.remove(i);
    } else {
      i = i + 1;
    }
  }
}
boolean with(GameObject obj) { //in same room
  return myHero.roomX == obj.roomX && myHero.roomY == obj.roomY && myHero.roomZ == obj.roomZ;
}

void drawDarkness() { //darkness screen ========================================
  noStroke();
  rectMode(CORNER);
  int i = 0;
  while (i < darkness.size()) {
    darkness.get(i).show();
    i++;
  }
  rectMode(CENTER);
}

void drawMessages() { //add floating text ========================================
  int i = 0;
  while (i < myTexts.size()) {
    Message Msg = myTexts.get(i);
    if (with(Msg)) {
      Msg.show();
      Msg.act();
    }
    if (Msg.hp <= 0) {
      myTexts.remove(i);
    } else {
      i = i + 1;
    }
  }
}
boolean with(Message msg) { //in same room
  return myHero.roomX == msg.roomX && myHero.roomY == msg.roomY && myHero.roomZ == msg.roomZ;
}

void drawMap() { //mini map on screen ========================================
  noStroke();
  rectMode(CORNER);
  int y = 0;
  while (y < map.height) {
    int x = 0;
    while (x < map.width) {
      color m = map.get(x, y);
      fill(m);
      square(x*12+25, y*12+25, 15);
      x = x + 1;
    }
    y = y + 1;
  }
  strokeWeight(3);
  stroke(lightGrey);
  noFill();
  square(myHero.roomX*12+25, myHero.roomY*12+25, 12);
  rectMode(CENTER);
}


void pause() { //pause mode ========================================================================================================================
  //stopAudio();

  fill(50, 50);
  strokeWeight(4);
  stroke(240);
  rect(width/2, height/2, 800, 600, 100);

  textAlign(CORNER, CENTER);
  textFont(revamped);
  fill(255);
  textSize(50);
  text("YOU  HAVE:  "+myHero.xp/10+"  XP", width/4, 200);
  textSize(40);
  text("HP:  "+myHero.hpMax/10, width/3, 320);
  text("SPEED:  "+myHero.speed+"  KN", width/3, 396);
  text("DAMAGE:  "+myHero.damage, width/3, 476);
  textAlign(CENTER, CENTER);

  //upgrade buttons ========================================
  if (myHero.xp >= 100 && myHero.hpMax < myHero.hpMaxMax) {
    increaseHP.show();
  }
  if (myHero.xp >= 150 && myHero.speed < myHero.speedMax) {
    increaseSpeed.show();
  }
  if (myHero.xp >= 200 && myHero.damage < myHero.damageMax) {
    increaseDamage.show();
  }
  if (increaseHP.click && myHero.xp >= 100) {
    myHero.hpMax = myHero.hpMax + 50;
    myHero.hp = myHero.hp + 50;
    myHero.xp = myHero.xp - 100;
  } else if (increaseSpeed.click && myHero.xp >= 150) {
    myHero.speed = myHero.speed + 1;
    myHero.xp = myHero.xp - 150;
  } else if (increaseDamage.click && myHero.xp >= 200) {
    myHero.damage = myHero.damage + 1;
    myHero.xp = myHero.xp - 200;
  } else if (myHero.xp < 100) { //cannot upgrade further ========================================
    increaseHP.click = increaseSpeed.click = increaseDamage.click = false;
    fill(white);
    rect(width/2, 560, 560, 50);
    fill(black);
    textFont(monochrome);
    textSize(30);
    text("NOT ENOUGH XP TO UPGRADE", width/2, 560);
  }
  if (myHero.hpMax >= myHero.hpMaxMax) { //reach max hp level ========================================
    increaseHP.click = false;
    fill(white);
    rect(width/4+30, 320, 100, 50);
    fill(black);
    textFont(monochrome);
    textSize(30);
    text("MAX", width/4+30, 320);
  }
  if (myHero.speed >= myHero.speedMax) { //reach max speed level ========================================
    increaseSpeed.click = false;
    fill(white);
    rect(width/4+30, 396, 100, 50);
    fill(black);
    textFont(monochrome);
    textSize(30);
    text("MAX", width/4+30, 396);
  }
  if (myHero.damage >= myHero.damageMax) { //reach max damage level ========================================
    increaseDamage.click = false;
    fill(white);
    rect(width/4+30, 480, 100, 50);
    fill(black);
    textFont(monochrome);
    textSize(30);
    text("MAX", width/4+30, 480);
  }

  //return to game ========================================
  playButton.show();
  if (playButton.click) {
    if (bossMode == false) {
      mode = GAME;
    } else if (bossMode == true) {
      mode = BOSS;
    }
  }
  strokeWeight(1);
  if (mouseX > 1120 && mouseX < 1180 && mouseY > 20 && mouseY < 80) {
    stroke(white);
    fill(white);
  } else {
    stroke(black);
    fill(black);
  }
  triangle(1138, 38, 1138, 62, 1162, 50);

  textFont(enchanted);
  textSize(60);
  fill(red);
  text("PAUSE", width/2, 630);
}

void endGame(int a) { //ways to end game ========================================

  // 1 = win main game: go to boss level
  // 2 = lose game: go to gameover screen
  // 3 = win boss level: go to gameover screen

  textTimer = timeOut*2;
  if (textTimer > 80) textTimer = 80;
  textFont(revamped);
  textSize(textTimer+1);
  fill(255);
  if (a == 1) {
    text("BOSS  LEVEL", width/2, height/4-10);
    text("UNLOCKED", width/2, height/3);
    image(cube2, width/2, height/2, 211*2/3, 200*2/3);
  } else if (a == 2) {
    text("GAME  OVER", width/2, height/4);
    image(cube2, width/2, height/2, 211*2/3, 200*2/3);
  } else if (a == 3) {
    text("CONGRATULATIONS", width/2, height/4);
    image(cube1, width/2, height/2, 211*2/3, 200*2/3);
  }
  timeOut = timeOut + 1;
  if (timeOut > 120) {
    if (a == 1) {
      myObjects.add(myBoss);
      myHero.roomX = 1;
      myHero.roomY = 1;
      myHero.roomZ = 5;
      myHero.loc = new PVector(width/4, height/2);
      mode = BOSS;
    } else if (a == 2) {
      mode = GAMEOVER;
    } else if (a == 3) {
      mode = GAMEOVER;
    }
    textTimer = 0;
    timeOut = 0;
  }
}
