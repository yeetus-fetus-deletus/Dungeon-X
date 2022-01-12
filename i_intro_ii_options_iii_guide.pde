void intro() { //intro mode ================================================================================
  background(0);
  introGIF.show();

  fill(255);
  textFont(monochrome);
  textSize(30);
  fill(120);
  text("DUNGEON CRAWL PRESENTS", width/2-4, height/4-116);
  fill(0);
  text("DUNGEON CRAWL PRESENTS", width/2-2, height/4-118);
  fill(255);
  text("DUNGEON CRAWL PRESENTS", width/2, height/4-120);
  textFont(revamped);
  textSize(140);
  fill(120);
  text("DUNGEON  X", width/2-12, height/4-18);
  fill(0);
  text("DUNGEON  X", width/2-6, height/4-24);
  fill(255);
  text("DUNGEON  X", width/2, height/4-30);

  textFont(monochrome);
  startButton.show();
  if (startButton.click) mode = OPTIONS;
}


void options() {
  //options box ========================================
  background(black);
  fill(white);
  textFont(monochrome);
  textSize(120);
  text("FLEET", width/2, 100);
  strokeWeight(2);
  stroke(white);
  line(0, 200, width, 200);
  line(width/2, 200, width/2, height);


  textFont(revamped);
  heroIButton.show();
  heroIIButton.show();
  heroIIIButton.show();
  heroIVButton.show();
  heroVButton.show();
  heroVIButton.show();
  if (heroIButton.click) {
    firestorm = true;
    stallion = hypershock = blackstar = deadlock = revolution = false;
  } else if (heroIIButton.click) {
    stallion = true;
    firestorm = hypershock = blackstar = deadlock = revolution = false;
  } else if (heroIIIButton.click) {
    hypershock = true;
    firestorm = stallion = blackstar = deadlock = revolution = false;
  } else if (heroIVButton.click) {
    blackstar = true;
    firestorm = stallion = hypershock = deadlock = revolution = false;
  } else if (heroVButton.click) {
    deadlock = true;
    firestorm = stallion = hypershock = blackstar = revolution = false;
  } else if (heroVIButton.click) {
    revolution = true;
    firestorm = stallion = hypershock = blackstar = deadlock = false;
  }

  stroke(black);
  line(0, 300, width/2, 300);
  line(0, 400, width/2, 400);
  line(0, 500, width/2, 500);
  line(0, 600, width/2, 600);
  line(0, 700, width/2, 700);

  strokeWeight(5);
  stroke(white);
  fill(255);
  textSize(40);
  if (!firestorm && !stallion && !hypershock && !blackstar && !deadlock && !revolution) {
    text("SELECT  SHIP", width*3/4, 500);
    line(width*3/4-40, 580, width*3/4+40, 580);
    line(width*3/4-40, 580, width*3/4-20, 560);
    line(width*3/4-40, 580, width*3/4-20, 600);
  }

  //hero buttons ========================================
  //textFont(revamped);
  textSize(60);

  if (firestorm == true) {
    text("FIRESTORM", width*3/4, height*1/3);
    heroI(width*5/6-10, height*2/3, 0, -height, 3);
  } else if (stallion == true) {
    text("STALLION", width*3/4, height*1/3);
    heroII(width*5/6-10, height*2/3, 0, -height, 3);
  } else if (hypershock == true) {
    text("HYPERSHOCK", width*3/4, height*1/3);
    heroIII(width*5/6-10, height*2/3, 0, -height, 3);
  } else if (blackstar == true) {
    text("BLACKSTAR", width*3/4, height*1/3);
    heroIV(width*5/6-10, height*2/3, 0, -height, 3);
  } else if (deadlock == true) {
    text("DEADLOCK", width*3/4, height*1/3);
    heroV(width*5/6-10, height*2/3, 0, -height, 3);
  } else if (revolution == true) {
    text("REVOLUTION", width*3/4, height*1/3);
    heroVI(width*5/6-10, height*2/3, 0, -height, 3);
  }

  textAlign(CORNER, CENTER);
  fill(white);
  stroke(white);
  textSize(20);
  if (firestorm == true) {
    text("HP:           100", 610, 700);
    text("SPEED:  8.0 KN", 610, 730);
    text("CLASS:  1GKFNU", 610, 760);
  } else if (stallion == true) {
    text("HP:           110", 610, 700);
    text("SPEED:  10.0 KN", 610, 730);
    text("CLASS:  2WXZTI", 610, 760);
  } else if (hypershock == true) {
    text("HP:           90", 610, 700);
    text("SPEED:  14.0 KN", 610, 730);
    text("CLASS:  3YQEML", 610, 760);
  } else if (blackstar == true) {
    text("HP:           120", 610, 700);
    text("SPEED:  11.0 KN", 610, 730);
    text("CLASS:  4IACVR", 610, 760);
  } else if (deadlock == true) {
    text("HP:           140", 610, 700);
    text("SPEED:  9.0 KN", 610, 730);
    text("CLASS:  5MKPTO", 610, 760);
  } else if (revolution == true) {
    text("HP:           150", 610, 700);
    text("SPEED:  12.0 KN", 610, 730);
    text("CLASS:  6AXVDB", 610, 760);
  }
  textAlign(CENTER, CENTER);

  //strokeWeight(5);
  //stroke(white);
  if (firestorm || stallion || hypershock || blackstar || deadlock || revolution) {
    text("STATS", 690, 660);
    line(648, 675, 732, 675);
    textFont(monochrome);
    closeButton.show();
  }

  if (closeButton.click) {
    if (firestorm == true) {
      myHero = new Firestorm();
      myObjects.add(myHero);
    } else if (stallion == true) {
      myHero = new Stallion();
      myObjects.add(myHero);
    } else if (hypershock == true) {
      myHero = new Hypershock();
      myObjects.add(myHero);
    } else if (blackstar == true) {
      myHero = new Blackstar();
      myObjects.add(myHero);
    } else if (deadlock == true) {
      myHero = new Deadlock();
      myObjects.add(myHero);
    } else if (revolution == true) {
      myHero = new Revolution();
      myObjects.add(myHero);
    }
    mode = GUIDE;
    guideTimer = 0;
    textTimer = 300;
  }
}


void guide() { //guide mode ================================================================================
  background(50);
  guideGIF.show();
  textAlign(CORNER, CORNER);
  strokeWeight(4);
  stroke(150);
  fill(150);
  textFont(revamped);
  textSize(28);

  guideTimer = guideTimer + 1;
  if (guideTimer > 10) {
    text("INSTRUCTIONS:", 200, 90);
    line(195, 100, 456, 100);
  }
  if (guideTimer > 40) {
    text("W  =  UP", 200, 140);
  }
  if (guideTimer > 50) {
    text("S  =  DOWN", 200, 180);
  }
  if (guideTimer > 60) {
    text("A  =  LEFT", 200, 220);
  }
  if (guideTimer > 70) {
    text("D  =  RIGHT", 200, 260);
  }
  if (guideTimer > 80) {
    text("SPACE  =  SHOOT", 200, 300);
  }

  if (guideTimer > 90) {
    text("J  =  AUTOFIRE", 700, 140);
  }
  if (guideTimer > 100) {
    text("U  =  PISTOL", 700, 180);
  }
  if (guideTimer > 110) {
    text("I  =  SHOTGUN", 700, 220);
  }
  if (guideTimer > 120) {
    text("O  =  FLAMETHROWER", 700, 260);
  }
  if (guideTimer > 130) {
    text("P  =  LASER", 700, 300);
  }

  if (guideTimer > 170) {
    text("OBJECTIVE: ", 200, 400);
    line(195, 410, 400, 410);
  }
  if (guideTimer > 200) {
    text("-  LOCATE THE FOUR GOLDEN CHESTS", 230, 450);
  }
  if (guideTimer > 220) {
    text("-  ONE CHEST ON EACH FLOOR", 230, 490);
  }
  if (guideTimer > 240) {
    text("-  DEFEAT THE FINAL BOSS", 230, 530);
  }

  textAlign(CENTER, CENTER);
  textFont(paladins);
  textSize(40);
  
  textTimer = textTimer - 1;
  if (textTimer == 300 && textTimer >= 240) {
    text("5", width/2, height*4/5);
  } else if (textTimer < 240 && textTimer >= 180) {
    text("4", width/2, height*4/5);
  } else if (textTimer < 180 && textTimer >= 120) {
    text("3", width/2, height*4/5);
  } else if (textTimer < 120 && textTimer >= 60) {
    text("2", width/2, height*4/5);
  } else if (textTimer < 60 && textTimer >= 0) {
    text("1", width/2, height*4/5);
  } else if (textTimer < 0) {
    text("CLICK ANYWHERE TO BEGIN", width/2, height*4/5);
  }
}
void guideClicks() {
  mode = GAME;
}
