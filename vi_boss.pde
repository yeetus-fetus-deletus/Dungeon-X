void boss() {
  bossMode = true;

  drawRoom();
  drawObjects();
  drawMessages();

  rectMode(CORNER);
  textAlign(RIGHT, CORNER);
  textFont(revamped);
  textSize(20);

  if (myHero.hp > 0 && myBoss.hp > 0) {
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

    float heroHitpoints = map(myHero.hpMax, 0, myHero.hpMax, 0, 400);
    float heroDamage    = map(myHero.hp, 0, myHero.hpMax, 0, 400);
    textAlign(LEFT, CORNER);
    strokeWeight(3);
    stroke(0);
    fill(white);
    rect(width/6-80, height*0.9, heroHitpoints, 20);
    fill(red);
    rect(width/6-80, height*0.9, heroDamage, 20);
    fill(white);
    textSize(20);
    text(myHero.hp/10+" HP  /  "+myHero.hpMax/10+"  HP", width/6-80, height*0.96);

    float bossHitpoints = map(myBoss.hpMax, 0, myBoss.hpMax, 0, 400);
    float bossDamage    = map(myBoss.hp, 0, myBoss.hpMax, 0, 400);
    textAlign(RIGHT, CORNER);
    strokeWeight(3);
    stroke(0);
    fill(white);
    rect(width*5/6+80, height*0.9, -bossHitpoints, 20);
    fill(red);
    rect(width*5/6+80, height*0.9, -bossDamage, 20);
    fill(white);
    textSize(20);
    text(myBoss.hp/10+" HP  /  "+myBoss.hpMax/10+"  HP", width*5/6+80, height*0.96);

    textAlign(CORNER, CORNER);

    stroke(black);
    fill(white);
    rect(width/6-80, height*0.02, 300, 20);
    rect(width/6-80, height*0.08, 300, 20);
    rect(width/6-80, height*0.14, 300, 20);
    text("SPAWNERS:  "+myHero.barracksTimer/60+"  SECONDS", width/6-80, height*0.065);
    text("TURRETS:  "+myHero.turretTimer/60+"  SECONDS", width/6-80, height*0.125);
    text("INFERNO:  "+myHero.infernoTimer/60+"  SECONDS", width/6-80, height*0.185);

    drawConsole(80, 1);
  }



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

  if (myBoss.hp <= 0) {
    win = true;
    endGame(3);
    explode(myBoss.loc.x-20, myBoss.loc.y, orange, 10, 100);
    explode(myBoss.loc.x-50, myBoss.loc.y-100, black, 10, 100);
    explode(myBoss.loc.x-50, myBoss.loc.y+100, black, 10, 100);
    explode(myBoss.loc.x+100, myBoss.loc.y-50, orange, 10, 100);
    explode(myBoss.loc.x+100, myBoss.loc.y+50, orange, 10, 100);
    explode(myBoss.loc.x-100, myBoss.loc.y-250, white, 10, 100);
    explode(myBoss.loc.x-100, myBoss.loc.y+250, white, 10, 100);
    explode(myBoss.loc.x+120, myBoss.loc.y-200, darkGrey, 10, 100);
    explode(myBoss.loc.x+120, myBoss.loc.y+200, darkGrey, 10, 100);
    explode(myBoss.loc.x+150, myBoss.loc.y-300, lightGrey, 10, 100);
    explode(myBoss.loc.x+150, myBoss.loc.y+300, lightGrey, 10, 100);
  }
  if (myHero.hp <= 0) {
    win = false;
    endGame(2);
    explode(myHero.loc.x, myHero.loc.y, white, 10, 100);
  }
}

void drawRoom() {
  //walls ========================================
  background(black);
  strokeWeight(2);
  stroke(lightBlue);
  line(0, 0, width/3, height/2);
  line(width, 0, width*2/3, height/2);
  line(width, height, width*2/3, height/2);
  line(0, height, width/3, height/2);

  //decoration ========================================
  strokeWeight(4);
  stroke(#FF33FF);
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

  rect(width/2, height/2, width-200, height-200);
  image(floor, (width/4)+50, (height/4)+50, (width/2)-100, (height/2)-100);
  image(floor, (width/4)+50, (height*3/4)-50, (width/2)-100, (height/2)-100);
  image(floor, (width*3/4)-50, (height/4)+50, (width/2)-100, (height/2)-100);
  image(floor, (width*3/4)-50, (height*3/4)-50, (width/2)-100, (height/2)-100);
}


void drawConsole(int w, int check) {
  strokeWeight(5);
  textSize(20);
  if (fireball) {
    stroke(black);
    fill(white);
    rect(width/6-w, height*0.83, 300, 20);
    fill(blue);
    rect(width/6-w, height*0.83, myHero.fireTimer/2, 20);
    fill(white);
    text("FIREBALL:  "+myHero.fireTimer/60+"  SECONDS", 210-w, height*0.88);
    myHero.fireTimer = myHero.fireTimer - 1;
  }
  if (myHero.fireTimer <= 0) {
    fireball = false;
  }

  if (spike) {
    stroke(black);
    fill(white);
    rect(width/6-w, height*0.83, 300, 20);
    fill(darkGrey);
    rect(width/6-w, height*0.83, myHero.spikeTimer/2, 20);
    fill(white);
    text("SPIKEBALL:  "+myHero.spikeTimer/60+"  SECONDS", 210-w, height*0.88);
    myHero.spikeTimer = myHero.spikeTimer - 1;
  }
  if (myHero.spikeTimer <= 0) {
    spike = false;
  }

  if (potion2) {
    stroke(black);
    fill(white);
    rect(width/6-w, height*0.83, 300, 20);
    fill(brown);
    rect(width/6-w, height*0.83, myHero.fieldTimer/2, 20);
    fill(white);
    text("TOXICITY:  "+myHero.fieldTimer/60+"  SECONDS", 210-w, height*0.88);
    myHero.fieldTimer = myHero.fieldTimer - 1;
  }
  if (myHero.fieldTimer <= 0) {
    potion2 = false;
  }

  if (!fireball && !spike && !potion2) {
    myHero.myWeapon = arsenal[choose];
  }

  float chirp = map(myHero.visionTimer, 0, 900, 0, 250);
  if (vision) {
    stroke(black);
    fill(white);
    rect(700, 640, 250, 20);
    fill(green);
    rect(700, 640, chirp, 20);
    fill(white);
    text("VISION:  "+myHero.visionTimer/60+"  SECONDS", 700, 680);
    myHero.visionTimer = myHero.visionTimer - 1;

    noStroke();
    fill(green, 50);
    rect(0, 0, width, height);
  }
  if (myHero.visionTimer <= 0) {
    vision = false;
  }


  if (check == 1) {
    float caw = map(myHero.barracksTimer, 0, 900, 0, 300);
    if (sentry) {
      fill(ice);
      rect(width/6-80, height*0.02, caw, 20);
      myHero.barracksTimer = myHero.barracksTimer - 1;
    }
    if (myHero.barracksTimer <= 0) {
      sentry = false;
      sentryOff = true;
    }

    float reee = map(myHero.turretTimer, 0, 900, 0, 300);
    if (turret) {
      fill(red);
      rect(width/6-80, height*0.08, reee, 20);
      myHero.turretTimer = myHero.turretTimer - 1;
    }
    if (myHero.turretTimer <= 0) {
      turret = false;
      turretOff = true;
    }

    float quack = map(myHero.infernoTimer, 0, 900, 0, 300);
    if (inferno) {
      fill(yellow);
      rect(width/6-80, height*0.14, quack, 20);
      myHero.infernoTimer = myHero.infernoTimer - 1;
    }
    if (myHero.infernoTimer <= 0) {
      inferno = false;
      infernoOff = true;
    }
  }
}
