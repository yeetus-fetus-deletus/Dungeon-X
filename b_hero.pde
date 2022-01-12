class Hero extends GameObject {

  //instance variables
  int damage, damageMax;
  float speed, speedMax;
  int hpMax, hpMaxMax;
  int health;
  Weapon myWeapon;

  //constructor
  Hero() {
    super();
    hp = 1000;
    hpMax = hp;
    hpMaxMax = hpMax + 2000;
    health = 120;
    speed = 8;
    speedMax = speed + 30;
    damage = 0;
    damageMax = damage + 19;
    roomX = 1;
    roomY = 1;
    roomZ = 1;
    xp = 0;
    dir = new PVector(mouseX-loc.x, mouseY-loc.y);
    myWeapon = arsenal[1];
    gameMap(roomZ);
  }
  Hero(int _hp, float _speed) {
    super();
    hp = _hp;
    hpMax = _hp;
    hpMaxMax = hpMax + 2000;
    health = 120;
    speed = _speed;
    speedMax = speed + 30;
    damage = 0;
    damageMax = damage + 20;
    roomX = 1;
    roomY = 1;
    roomZ = 1;
    xp = 0;
    dir = new PVector(mouseX-loc.x, mouseY-loc.y);
    myWeapon = arsenal[1];
    gameMap(roomZ);
  }

  //behaviour 
  void show() {
    //grayson was here
  }

  void act() {
    super.act();
    dir = new PVector(mouseX-loc.x, mouseY-loc.y);
    if (!fireball && !spike && !potion2) {
      if (jkey) {
        myWeapon = arsenal[0];
        choose = 0;
      } else if (ukey) {
        myWeapon = arsenal[1];
        choose = 1;
      } else if (ikey) {
        myWeapon = arsenal[2];
        choose = 2;
      } else if (okey) {
        myWeapon = arsenal[3];
        choose = 3;
      } else if (pkey) {
        myWeapon = arsenal[4];
        choose = 4;
      }
    }

    //movement ========================================
    //key functions
    if (wkey) vel.y = -speed;
    if (skey) vel.y = speed;
    if (akey) vel.x = -speed;
    if (dkey) vel.x = speed;

    //slow down
    if (!wkey && !skey) vel.y = vel.y*0.8;
    if (!akey && !dkey) vel.x = vel.x*0.8;
    //speed limit
    if (vel.mag() > speed) vel.setMag(speed);

    //check exits ========================================
    if (roomZ < 5) {
      if (north != #FFFFFF && loc.y <= 120 && loc.x >= width/2-30 && loc.x <= width/2+30) {
        roomY--;
        loc = new PVector(width/2, height-120);
        cleanUp();
      } else if (east != #FFFFFF && loc.x >= width-120 && loc.y >= height/2-30 && loc.y <= height/2+30) {
        roomX++;
        loc = new PVector(120, height/2);
        cleanUp();
      } else if (south != #FFFFFF && loc.y >= height-120 && loc.x >= width/2-30 && loc.x <= width/2+30) {
        roomY++;
        loc = new PVector(width/2, 120);
        cleanUp();
      } else if (west != #FFFFFF && loc.x <= 120 && loc.y >= height/2-30 && loc.y <= height/2+30) {
        roomX--;
        loc = new PVector(width-120, height/2);
        cleanUp();
      }
    }

    myWeapon.update();
    myWeapon.shoot();

    int i = 0;
    while (i < myObjects.size()) {
      GameObject Obj = myObjects.get(i);
      if (immuneTimer <= 0) {
        if (Obj instanceof Spawner || Obj instanceof Stalker || Obj instanceof Shooter || Obj instanceof Stopper) {
          if (hits(Obj, 30, Obj.s/2)) {
            Obj.hp = Obj.hp - 200;
            hp = hp - 1;
          }
        }
        if (Obj instanceof EnemyBullet) {
          if (hits(Obj, 30, Obj.s/2)) {
            Obj.hp = Obj.hp - 1;
            hp = hp - 80;
            immuneTimer = 120;
            explode(Obj.loc.x, Obj.loc.y, Obj.c, 75, 50);
          }
        }
        if (Obj instanceof EnemyBeam) {
          if (hits(Obj, 30, 8)) {
            Obj.hp = 0;
            hp = hp - 2;
            explode(Obj.loc.x, Obj.loc.y, green, 30, 50);
          }
        }
        if (Obj instanceof Ice) {
          if (hits(Obj, 30, Obj.s/2)) {
            Obj.hp = 0;
            hp = hp - 1;
          }
        }
      }
      if (Obj instanceof DroppedItem) {
        if (pickUp(Obj)) {
          DroppedItem item = (DroppedItem) Obj;
          item.hp = 0;
          if (item.type == HEALTH) {
            textFont(revamped);
            myHero.hp = myHero.hp + myHero.health;
            if (myHero.hp >= myHero.hpMax) myHero.hp = myHero.hpMax;
            myTexts.add(new Text(450, height*0.95, "+ "+myHero.health/10+" HP", green, 20, 0.5, 5));
          } else if (item.type == POISON) {
            fieldTimer = 600;
            potion2 = true;
            fireball = spike = false;
            myWeapon = item.w;
          } else if (item.type == SPIKE) {
            spikeTimer = 600;
            spike = true;
            fireball = potion2 = false;
            myWeapon = item.w;
          } else if (item.type == FIREBALL) {
            fireTimer = 600;
            fireball = true;
            spike = potion2 = false;
            myWeapon = item.w;
          } else if (item.type == VISION) {
            visionTimer = 900;
            vision = true;
          } else if (item.type == SENTRY) {
            int u = 0;
            while (u < myObjects.size()) {
              GameObject objA = myObjects.get(u);
              if (objA == myBarracksA || objA == myBarracksB) {
                explode(objA.loc.x, objA.loc.y, brown, 20, 60);
                myObjects.remove(u);
                u--;
              }
              u++;
            }
            barracksTimer = 900;
            sentry = true;
            myBarracksA = new Barracks(250, 150);
            myBarracksB = new Barracks(250, height-150);
            myObjects.add(myBarracksA);
            myObjects.add(myBarracksB);
          } else if (item.type == TURRET) {
            int o = 0;
            while (o < myObjects.size()) {
              GameObject objB = myObjects.get(o);
              if (objB == myTurretA || objB == myTurretB) {
                explode(objB.loc.x, objB.loc.y, brown, 20, 60);
                myObjects.remove(o);
                o--;
              }
              o++;
            }
            turretTimer = 900;
            turret = true;
            myTurretA = new Turret(150, 300);
            myTurretB = new Turret(150, height-300);
            myObjects.add(myTurretA);
            myObjects.add(myTurretB);
          } else if (item.type == INFERNO) {
            int p = 0;
            while (p < myObjects.size()) {
              GameObject objC = myObjects.get(p);
              if (objC == myInferno) {
                explode(objC.loc.x, objC.loc.y, brown, 20, 60);
                myObjects.remove(p);
                p--;
              }
              p++;
            }
            infernoTimer = 900;
            inferno = true;
            myInferno = new Inferno(400, random(150, height-150));
            myObjects.add(myInferno);
          }
        }
      }
      if (Obj instanceof Piece) {
        if (pickUp(Obj)) {
          Piece item = (Piece) Obj;
          item.hp = 0;
          PIECES--;
        }
      }

      if (Obj instanceof Portal) {
        if (hits(Obj, 30, Obj.s/2)) {
          Portal trip = (Portal) Obj;
          if (trip.type == FLOOR_UP) {
            explode(loc.x, loc.y, ice, 20, 80);
            roomZ++;
            gameMap(roomZ);
            noStroke();
            fill(blue);
            rect(map.width/2+25, map.height/2+25, map.width, map.height);
            roomX = trip.hx;
            roomY = trip.hy;
            explode(loc.x, loc.y, lightBlue, 30, 50);
          } else if (trip.type == FLOOR_DOWN) {
            explode(loc.x, loc.y, #FFCCFF, 20, 80);
            roomZ--;
            gameMap(roomZ);
            noStroke();
            fill(red);
            rect(map.width/2+25, map.height/2+25, map.width, map.height);
            roomX = trip.hx;
            roomY = trip.hy;
            explode(loc.x, loc.y, #FF88FF, 20, 80);
          }
        }
      }
      i = i + 1;
    }
  }

  void cleanUp() {
    int i = 0;
    while (i < myObjects.size()) {
      GameObject Obj = myObjects.get(i);
      if (Obj instanceof Bullet || Obj instanceof EnemyBullet || Obj instanceof Exhaust || Obj instanceof Particle) {
        if (!with(Obj)) {
          myObjects.remove(i);
          i--;
        }
      } else if (Obj instanceof Fireball || Obj instanceof Tail || Obj instanceof Spikeball || Obj instanceof Splash || Obj instanceof Field) {
        if (!with(Obj)) {
          myObjects.remove(i);
          i--;
        }
      } else if (Obj instanceof Fire || Obj instanceof Ice || Obj instanceof Beam || Obj instanceof EnemyBeam) {
        if (!with(Obj)) {
          myObjects.remove(i);
          i--;
        }
      }
      i++;
    }
    //i = 0;
    //while (i < myTexts.size()) {
    //  Message Msg = myTexts.get(i);
    //  if (Msg instanceof Text) {
    //    if (!with(Msg)) {
    //      myTexts.remove(i);
    //      i--;
    //    }
    //  }
    //  i++;
    //}
  }
}





void heroI(float x, float y, float vx, float vy, int size) { //firestorm ========================================
  pushMatrix();
  translate(x, y);
  PVector dir = new PVector(vx, vy);
  rotate(dir.heading()+HALF_PI);
  scale(size);
  //immunity appearance ========================================
  if (immuneTimer > 0) {
    immuneTimer = immuneTimer - 1;
    //temp shield
    fill(150, 100);
    strokeWeight(8);
    stroke(0, 0, 255);
    ellipse(0, 5, 150, 100);
  }
  strokeWeight(3);
  stroke(blue);
  fill(darkGrey);
  arc(-32, -4, 18, 36, radians(320), radians(580), CHORD);
  arc(32, -4, 18, 36, radians(320), radians(580), CHORD);
  strokeWeight(2);
  triangle(0, -34, -15, -10, 15, -10);
  quad(-10, 32, 10, 32, 16, 0, -16, 0);
  triangle(0, 10, -18, 38, 18, 38);
  fill(lightGrey);
  noStroke();
  rect(-30, 0, 30, 20);
  rect(30, 0, 30, 20);
  stroke(blue);
  triangle(-45, -10, -18, 10, -65, 20);
  triangle(45, -10, 18, 10, 65, 20);
  line(-45, -10, -45, 15);
  line(45, -10, 45, 15);
  line(-45, -11, -15, -10);
  line(45, -11, 15, -10);

  circle(0, 0, 38);
  fill(black);
  noStroke();
  triangle(0, -16, -16, 0, 16, 0);
  triangle(0, -16, -8, 16, 8, 16);

  if (fireball) {
    strokeWeight(5);
    stroke(white);
    fill(black);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  } else if (spike) {
    strokeWeight(5);
    stroke(black);
    fill(white);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  } else if (potion2) {
    strokeWeight(5);
    stroke(white);
    fill(brown);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  }
  popMatrix();
}


void heroII(float x, float y, float vx, float vy, int size) { //stallion ========================================
  pushMatrix();
  translate(x, y);
  PVector dir = new PVector(vx, vy);
  rotate(dir.heading()+HALF_PI);
  scale(size);
  //immunity appearance ========================================
  if (immuneTimer > 0) {
    immuneTimer = immuneTimer - 1;
    //temp shield
    fill(150, 100);
    strokeWeight(8);
    stroke(0, 0, 255);
    ellipse(0, 10, 140, 110);
  }
  strokeWeight(2);
  stroke(blue);
  fill(darkGrey);
  ellipse(0, 6, 16, 80);
  line(0, -33, 0, 45);
  fill(lightGrey);
  triangle(0, 38, -16, 50, 16, 50);
  ellipse(-14, 46, 6, 12);
  ellipse(14, 46, 6, 12);
  fill(darkGrey);
  ellipse(-54, 2, 6, 20);
  ellipse(54, 2, 6, 20);
  ellipse(-32, 0, 8, 28);
  ellipse(32, 0, 8, 28);
  noStroke();
  fill(lightGrey);
  triangle(0, -16, -60, 6, 60, 6);
  rect(0, 10, 120, 8);
  line(-60, 14, 60, 14);
  line(-60, 0, -60, 24);
  line(60, 0, 60, 24);
  line(0, -14, -60, 6);
  line(0, -14, 60, 6);
  line(0, -14, -60, 14);
  line(0, -14, 60, 14);
  line(0, -14, -40, 14);
  line(0, -14, 40, 14);
  line(0, -14, -22, 14);
  line(0, -14, 22, 14);

  stroke(blue);
  circle(0, 0, 38);
  fill(black);
  noStroke();
  triangle(0, -16, -16, 0, 16, 0);
  triangle(0, -16, -8, 16, 8, 16);

  if (fireball) {
    strokeWeight(5);
    stroke(white);
    fill(black);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  } else if (spike) {
    strokeWeight(5);
    stroke(black);
    fill(white);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  } else if (potion2) {
    strokeWeight(5);
    stroke(white);
    fill(brown);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  }
  popMatrix();
}


void heroIII(float x, float y, float vx, float vy, int size) { //hypershock ========================================
  pushMatrix();
  translate(x, y);
  PVector dir = new PVector(vx, vy);
  rotate(dir.heading()+HALF_PI);
  scale(size);
  //immunity appearance ========================================
  if (immuneTimer > 0) {
    immuneTimer = immuneTimer - 1;
    //temp shield
    fill(150, 100);
    strokeWeight(8);
    stroke(0, 0, 255);
    ellipse(0, 0, 120, 120);
  }
  strokeWeight(2);
  stroke(blue);
  fill(darkGrey);
  rect(-18, -10, 4, 50);
  rect(18, -10, 4, 50);
  rect(-30, 0, 4, 50);
  rect(30, 0, 4, 50);
  circle(0, 5, 60);
  square(-16, 28, 20);
  square(16, 28, 20);
  fill(lightGrey);
  noStroke();
  rect(0, 20, 90, 8, 100);
  triangle(0, -30, -45, 18, 45, 18);
  line(0, -30, -45, 18);
  line(0, -30, 45, 18);
  line(-42, 24, 42, 24);
  stroke(blue);
  noFill();
  arc(-41, 20, 8, 8, radians(90), radians(225));
  arc(41, 20, 8, 8, radians(315), radians(450));
  fill(lightGrey);
  quad(0, -50, -30, 25, 0, 32, 30, 25);
  line(0, -50, 0, 32);

  circle(0, 0, 38);
  fill(black);
  noStroke();
  triangle(0, -16, -16, 0, 16, 0);
  triangle(0, -16, -8, 16, 8, 16);

  if (fireball) {
    strokeWeight(5);
    stroke(white);
    fill(black);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  } else if (spike) {
    strokeWeight(5);
    stroke(black);
    fill(white);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  } else if (potion2) {
    strokeWeight(5);
    stroke(white);
    fill(brown);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  }
  popMatrix();
}


void heroIV(float x, float y, float vx, float vy, int size) { //blackstar ========================================
  pushMatrix();
  translate(x, y);
  PVector dir = new PVector(vx, vy);
  rotate(dir.heading()+HALF_PI);
  scale(size);
  //immunity appearance ========================================
  if (immuneTimer > 0) {
    immuneTimer = immuneTimer - 1;
    //temp shield
    fill(150, 100);
    strokeWeight(8);
    stroke(0, 0, 255);
    ellipse(0, 8, 140, 120);
  }
  strokeWeight(2);
  stroke(blue);
  fill(darkGrey);
  triangle(0, -32, -28, -4, 28, -4);
  rect(-18, 25, 16, 50);
  rect(18, 25, 16, 50);
  triangle(-60, -2, -50, -2, -50, -16);
  triangle(-40, -16, -40, -2, -30, -2);
  rect(-45, 3, 10, 28);
  triangle(60, -2, 50, -2, 50, -16);
  triangle(40, -16, 40, -2, 30, -2);
  rect(45, 3, 10, 28);
  noStroke();
  fill(lightGrey);
  triangle(0, 20, -60, 12, 60, 12);
  triangle(0, -16, -60, -4, 60, -4);
  rect(0, 4, 120, 16);
  line(0, -16, -60, -4);
  line(0, -16, 60, -4);
  line(0, 20, -60, 12);
  line(0, 20, 60, 12);
  line(-60, -4, -60, 12);
  line(60, -4, 60, 12);

  fill(black);
  triangle(-60, -4, 0, 0, -16, 18);
  triangle(60, -4, 0, 0, 16, 18);
  line(-60, -4, 0, 0);
  line(60, -4, 0, 0);
  line(-60, -4, -16, 18);
  line(60, -4, 16, 18);
  stroke(blue);
  quad(0, -40, -30, 50, 0, 20, 30, 50);
  fill(lightGrey);
  circle(0, 0, 38);
  fill(black);
  noStroke();
  triangle(0, -16, -16, 0, 16, 0);
  triangle(0, -16, -8, 16, 8, 16);

  if (fireball) {
    strokeWeight(5);
    stroke(white);
    fill(black);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  } else if (spike) {
    strokeWeight(5);
    stroke(black);
    fill(white);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  } else if (potion2) {
    strokeWeight(5);
    stroke(white);
    fill(brown);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  }
  popMatrix();
}


void heroV(float x, float y, float vx, float vy, int size) { //deadlock ========================================
  pushMatrix();
  translate(x, y);
  PVector dir = new PVector(vx, vy);
  rotate(dir.heading()+HALF_PI);
  scale(size);
  //immunity appearance ========================================
  if (immuneTimer > 0) {
    immuneTimer = immuneTimer - 1;
    //temp shield
    fill(150, 100);
    strokeWeight(8);
    stroke(0, 0, 255);
    ellipse(0, -10, 170, 170);
  }
  strokeWeight(2);
  stroke(blue);
  fill(black);
  triangle(-41, -46, 0, -36, -59, -20);
  triangle(41, -46, 0, -36, 59, -20);
  fill(darkGrey);
  rect(0, 8, 20, 76);
  arc(0, -30, 20, 50, PI, TAU);
  arc(0, -5, 20, 110, 0, PI);
  rect(-52, -35, 4, 40);
  rect(52, -35, 4, 40);
  rect(-57, -20, 6, 80);
  rect(57, -20, 6, 80);
  rect(-37, 8, 6, 96);
  rect(37, 8, 6, 96);
  rect(-37, -20, 10, 32);
  rect(37, -20, 10, 32);
  fill(black);
  quad(0, -40, -60, -28, -60, -12, 0, 0);
  quad(0, -40, 60, -28, 60, -12, 0, 0);
  quad(0, 40, -60, 28, -60, 12, 0, 0);
  quad(0, 40, 60, 28, 60, 12, 0, 0);
  fill(lightGrey);
  rect(0, -20, 120, 16);
  rect(0, 20, 120, 16);

  stroke(black);
  strokeWeight(1);
  fill(100);
  wheel(-26, -20);
  wheel(26, -20);
  wheel(-26, 19);
  wheel(26, 19);
  wheel(-48, -21);
  wheel(48, -21);
  wheel(-48, 20);
  wheel(48, 20);

  strokeWeight(2);
  stroke(blue);
  fill(lightGrey);
  circle(0, 0, 38);
  fill(black);
  noStroke();
  triangle(0, -16, -16, 0, 16, 0);
  triangle(0, -16, -8, 16, 8, 16);

  if (fireball) {
    strokeWeight(5);
    stroke(white);
    fill(black);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  } else if (spike) {
    strokeWeight(5);
    stroke(black);
    fill(white);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  } else if (potion2) {
    strokeWeight(5);
    stroke(white);
    fill(brown);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  }
  popMatrix();
}
void wheel(int x, int y) {
  circle(x, y, 12);
  line(x, y-6, x, y+6);
  line(x-6, y, x+6, y);
  line(x-4, y-4, x+4, y+4);
  line(x+4, y-4, x-4, y+4);
}


void heroVI(float x, float y, float vx, float vy, int size) {
  pushMatrix();
  translate(x, y);
  PVector dir = new PVector(vx, vy);
  rotate(dir.heading()+HALF_PI);
  scale(size);
  //immunity appearance ========================================
  if (immuneTimer > 0) {
    immuneTimer = immuneTimer - 1;
    //temp shield
    fill(150, 100);
    strokeWeight(8);
    stroke(0, 0, 255);
    ellipse(0, 0, 160, 160);
  }

  strokeWeight(2);
  stroke(blue);
  fill(darkGrey);
  ellipse(-32, 0, 16, 110);
  ellipse(32, 0, 16, 110);
  rect(-43, 0, 6, 100);
  rect(43, 0, 6, 100);
  rect(-49, -43, 6, 50);
  rect(49, -43, 6, 50);
  rect(-49, 43, 6, 50);
  rect(49, 43, 6, 50);

  fill(black);
  triangle(-50, -30, 30, 0, 50, 40);
  triangle(50, -30, -30, 0, -50, 40);
  fill(darkGrey);
  quad(-60, -25, -45, 0, -60, 25, 0, 0);
  quad(60, -25, 45, 0, 60, 25, 0, 0);
  line(-45, 0, 45, 0);
  triangle(-15, -60, -15, -10, -30, -10);
  triangle(15, -60, 15, -10, 30, -10);
  triangle(-15, 60, -15, 10, -30, 10);
  triangle(15, 60, 15, 10, 30, 10);
  fill(black);
  arc(0, 72, 20, 40, PI, TAU, CHORD);
  rect(0, 0, 26, 130);
  arc(-27, 35, 20, 40, PI, TAU, CHORD);
  arc(27, 35, 20, 40, PI, TAU, CHORD);
  arc(-27, -45, 30, 60, 0, PI, CHORD);
  arc(27, -45, 30, 60, 0, PI, CHORD);

  fill(lightGrey);
  rect(0, -25, 60, 12);
  rect(0, -35, 40, 8);
  quad(-60, 20, 0, 20, 60, -20, 0, -20);
  quad(-60, -20, 0, -20, 60, 20, 0, 20);
  fill(black);
  quad(-30, 0, 0, -20, 30, 0, 0, 20);

  fill(lightGrey);
  circle(0, 0, 38);
  fill(black);
  noStroke();
  triangle(0, -16, -16, 0, 16, 0);
  triangle(0, -16, -8, 16, 8, 16);

  if (fireball) {
    strokeWeight(5);
    stroke(white);
    fill(black);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  } else if (spike) {
    strokeWeight(5);
    stroke(black);
    fill(white);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  } else if (potion2) {
    strokeWeight(5);
    stroke(white);
    fill(brown);
    quad(-15, 20, -25, -20, 25, -20, 15, 20);
  }
  popMatrix();
}
