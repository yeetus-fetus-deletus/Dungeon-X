class Enemy extends GameObject {

  int enemyTimer;
  color enemyC;

  Enemy(int _hp, int rx, int ry, int rz, float _s, int _xp) {
    loc = new PVector(random(160, width-160), random(160, height-160));
    vel = new PVector(0, 0);
    dir = new PVector(0, 0);
    enemyTimer = 0;
    hp = _hp;
    xp = _xp;
    s = _s;
    roomX = rx;
    roomY = ry;
    roomZ = rz;
  }

  //behaviour
  void show() {
  }
  void act() {
    //kilroy was here
    super.act();

    int i = 0;
    while (i < myObjects.size()) {
      GameObject Obj = myObjects.get(i);
      if (Obj instanceof Bullet && hits(Obj, s/2, Obj.s/2)) { //weapon hits ========================================
        if (Obj.c == blue || Obj.c == lightGrey) { //auto and pistol
          Obj.hp = 0;
          hp = hp - (2700+myHero.damage*20);
          explode(Obj.loc.x, Obj.loc.y, Obj.c, 60, 50);
        } else if (Obj.c == red) { // shotgun
          Obj.hp = 0;
          hp = hp - (600+myHero.damage*20);
          explode(Obj.loc.x, Obj.loc.y, Obj.c, 60, 50);
        }
        if (hp <= 0) {
          float chance = random(0, 1);
          if (chance < 0.3) {
            myObjects.add(new DroppedItem(loc.x, loc.y, roomX, roomY, roomZ));
          }
          myHero.xp = myHero.xp + xp;
          myTexts.add(new Text(loc.x, loc.y, "+"+xp/10, gold1, 40, 0.7, 3));
        }
      }
      if (Obj instanceof Bolt && hits(Obj, s/2, Obj.s/2)) { //triangle darts
        Obj.hp = 0;
        hp = hp - (3000+myHero.damage*30);
        explode(Obj.loc.x, Obj.loc.y, Obj.c, 40, 50);
        if (hp <= 0) {
          float chance = random(0, 1);
          if (chance < 0.3) {
            myObjects.add(new DroppedItem(Obj.loc.x, Obj.loc.y, roomX, roomY, roomZ));
          }
          myHero.xp = myHero.xp + xp;
          myTexts.add(new Text(loc.x, loc.y, "+"+xp/10, gold1, 40, 0.7, 3));
        }
      }

      if (Obj instanceof Beam && hits(Obj, s/2, 8)) { //laser beams
        hp = hp - (200+myHero.damage*2);
        Obj.hp = 0;
        explode(Obj.loc.x, Obj.loc.y, white, 60, 40);
        if (hp <= 0) {
          float chance = random(0, 1);
          if (chance < 0.3) {
            myObjects.add(new DroppedItem(loc.x, loc.y, roomX, roomY, roomZ));
          }
          myHero.xp = myHero.xp + xp;
          myTexts.add(new Text(loc.x, loc.y, "+"+xp/10, gold1, 40, 0.7, 3));
        }
      }
      if (Obj instanceof Fire && hits(Obj, s/2, Obj.s/2)) { //flamethrower
        hp = hp - (5+myHero.damage);
        Obj.hp = 0;
        if (hp <= 0) {
          float chance = random(0, 1);
          if (chance < 0.3) {
            myObjects.add(new DroppedItem(loc.x, loc.y, roomX, roomY, roomZ));
          }
          myHero.xp = myHero.xp + xp;
          myTexts.add(new Text(loc.x, loc.y, "+"+xp/10, gold1, 40, 0.7, 3));
        }
      }
      if (Obj instanceof Fireball || Obj instanceof Spikeball) { //limited weapons: fireball and spikeball
        if (hits(Obj, s/2, Obj.s/2)) {
          hp = 0;
          if (Obj instanceof Spikeball) ((Spikeball) Obj).redirect();
          if (hp <= 0) {
            float chance = random(0, 1);
            if (chance < 0.3) {
              myObjects.add(new DroppedItem(loc.x, loc.y, roomX, roomY, roomZ));
            }
            myHero.xp = myHero.xp + xp*2;
            myTexts.add(new Text(loc.x, loc.y, "+"+xp/5, gold1, 40, 0.7, 3));
          }
        }
      }
      if (Obj instanceof Splash) { // limited weapons: toxic field
        if (hits(Obj, s/2, Obj.s/2)) {
          hp = hp - (4000+myHero.damage*10);
          Obj.hp = 0;
          explode(Obj.loc.x, Obj.loc.y, black, 60, 50);
          if (hp <= 0) {
            float chance = random(0, 1);
            if (chance < 0.3) {
              myObjects.add(new DroppedItem(loc.x, loc.y, roomX, roomY, roomZ));
            }
            myHero.xp = myHero.xp + xp*2;
            myTexts.add(new Text(loc.x, loc.y, "+"+xp/5, gold1, 40, 0.7, 3));
          }
        }
      }
      i = i + 1;
    }
  }
}


void explode(float x, float y, color c, float s, float n) { //explosions ========================================
  int u = 0;
  while (u < n) {
    myObjects.add(new Particle(x, y, c, s));
    u = u + 1;
  }
}


class Stopper extends Enemy { //random bouncing enemy ========================================

  Stopper(int hp, int rx, int ry, int rz, float s) {
    super(hp, rx, ry, rz, s, 70);
    loc = new PVector(width/2, height/2);
    vel = new PVector(random(-width, width), random(-height, height));
    vel.setMag(7);
  }
  Stopper(int rx, int ry, int rz, float x, float y, float s) {
    super(6000, rx, ry, rz, s, 70);
    loc = new PVector(x, y);
    vel = new PVector(random(-width, width), random(-height, height));
    vel.setMag(7);
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    dir = new PVector(myHero.loc.x-loc.x, myHero.loc.y-loc.y);
    rotate(dir.heading());
    if (roomX <= map.height/2-1 && roomY <= map.height/2-1) {
      enemyC = red;
    } else if (roomX >= map.height/2 && roomY <= map.height/2-1) {
      enemyC = blue;
    } else if (roomX <= map.height/2-1 && roomY >= map.height/2) {
      enemyC = green;
    } else if (roomX >= map.height/2 && roomY >= map.height/2) {
      enemyC = yellow;
    }
    if (roomZ == 5) {
      enemyC = gold2;
    }
    strokeWeight(1);
    stroke(0);
    fill(enemyC);
    square(0, 0, s);
    popMatrix();
    fill(white);
    textFont(revamped);
    textSize(s*2/5);
    text(hp/200, loc.x, loc.y);
  }
  void act() {
    super.act();
    if (loc.x >= width-100-s/2 || loc.x <= 100+s/2) vel.x = -vel.x;
    if (loc.y >= height-100-s/2 || loc.y <= 100+s/2) vel.y = -vel.y;
  }
}

class Stalker extends Enemy { //following enemy ========================================

  Stalker(int hp, int rx, int ry, int rz) {
    super(hp, rx, ry, rz, 30, 50);
    loc = new PVector(random(150, width-150), random(150, height-150));
  }
  Stalker(int hp, float x, float y, int rx, int ry, int rz, float s) {
    super(hp, rx, ry, rz, s, 30);
    loc = new PVector(x, y);
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    dir = new PVector(myHero.loc.x-loc.x, myHero.loc.y-loc.y);
    rotate(dir.heading());
    if (roomX <= map.height/2-1 && roomY <= map.height/2-1) {
      enemyC = red;
    } else if (roomX >= map.height/2 && roomY <= map.height/2-1) {
      enemyC = blue;
    } else if (roomX <= map.height/2-1 && roomY >= map.height/2) {
      enemyC = green;
    } else if (roomX >= map.height/2 && roomY >= map.height/2) {
      enemyC = yellow;
    }
    if (roomZ == 5) {
      enemyC = orange;
    }
    strokeWeight(1);
    stroke(black);
    fill(enemyC);
    square(0, 0, s);
    popMatrix();
    fill(white);
    textFont(revamped);
    textSize(s/2);
    text(hp/200, loc.x, loc.y);
  }
  void act() {
    super.act();
    vel = new PVector(myHero.loc.x-loc.x, myHero.loc.y-loc.y);
    vel.setMag(2);
  }
}


class Spawner extends Enemy { //spawning enemy followers ========================================

  int shot;

  Spawner(int hp, int rx, int ry, int rz, float s, int _shot) {
    super(hp, rx, ry, rz, s, 100);
    loc = new PVector(random(100+s, width-100-s), height-100-s/2);
    dir = new PVector(0, 0);
    shot = _shot;
    enemyTimer = _shot;
  }

  void show() {
    if (roomX <= map.height/2-1 && roomY <= map.height/2-1) {
      enemyC = red;
    } else if (roomX >= map.height/2 && roomY <= map.height/2-1) {
      enemyC = blue;
    } else if (roomX <= map.height/2-1 && roomY >= map.height/2) {
      enemyC = green;
    } else if (roomX >= map.height/2 && roomY >= map.height/2) {
      enemyC = yellow;
    }
    strokeWeight(1);
    stroke(white);
    fill(black);
    rect(loc.x, loc.y-20, s/2.5, s);
    stroke(black);
    fill(enemyC);
    rect(loc.x, loc.y, s*2, s);
    fill(white);
    textFont(revamped);
    textSize(60);
    text(hp/200, loc.x, loc.y-5);
  }
  void act() {
    super.act();
    if (enemyTimer <= 0) {
      myObjects.add(new Stalker(8000, loc.x, loc.y-80, roomX, roomY, roomZ, s/3));
      enemyTimer = shot;
    }
    enemyTimer = enemyTimer - 1;
  }
}


class Shooter extends Enemy { //turret enemy ========================================

  int shot;

  Shooter(int hp, int rx, int ry, int rz, float s, int _shot) {
    super(hp, rx, ry, rz, s, 60);
    loc = new PVector(width/2, height/2);
    shot = _shot;
    enemyTimer = _shot;
  }
  Shooter(int hp, int rx, int ry, int rz, float x, float y, float s, int _shot) {
    super(hp, rx, ry, rz, s, 60);
    loc = new PVector(x, y);
    shot = _shot;
    enemyTimer = _shot;
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    dir = new PVector(myHero.loc.x-loc.x, myHero.loc.y-loc.y);
    rotate((dir.heading()));
    if (roomX <= map.height/2-1 && roomY <= map.height/2-1) {
      enemyC = red;
    } else if (roomX >= map.height/2 && roomY <= map.height/2-1) {
      enemyC = blue;
    } else if (roomX <= map.height/2-1 && roomY >= map.height/2) {
      enemyC = green;
    } else if (roomX >= map.height/2 && roomY >= map.height/2) {
      enemyC = yellow;
    }
    noStroke();
    strokeWeight(1);
    fill(enemyC);
    square(0, 0, s);
    rotate(QUARTER_PI);
    square(0, 0, s);
    popMatrix();
    fill(white);
    textFont(revamped);
    textSize(30);
    text(hp/200, loc.x, loc.y);
  }
  void act() {
    super.act();
    if (enemyTimer <= 0) {
      myObjects.add(new EnemyBullet(loc.x, loc.y, (myHero.loc.x-loc.x), (myHero.loc.y-loc.y)));
      enemyTimer = shot;
    }
    enemyTimer = enemyTimer - 1;
  }
}


class Chest extends GameObject { //chest with key pieces ========================================

  Chest(int _hp, int rx, int ry, int rz, float _s) {
    loc = new PVector(random(160, width-160), random(160, height-160));
    vel = new PVector(0, 0);
    dir = new PVector(myHero.loc.x-loc.x, myHero.loc.y-loc.y);
    hp = _hp;
    s = _s;
    roomX = rx;
    roomY = ry;
    roomZ = rz;
    xp = 200;
  }

  void show() {
    strokeWeight(3);
    stroke(gold1);
    fill(brown);
    rect(loc.x, loc.y, s*1.5, s);
    fill(white);
    textFont(revamped);
    textSize(40);
    text(hp/200, loc.x, loc.y);
  }
  void act() {
    super.act();

    int i = 0;
    while (i < myObjects.size()) {
      GameObject Obj = myObjects.get(i);
      if (Obj instanceof Bullet && hits(Obj, s/2, Obj.s/2)) {
        if (Obj.c == blue || Obj.c == lightGrey) {
          Obj.hp = 0;
          hp = hp - 2700;
          explode(Obj.loc.x, Obj.loc.y, Obj.c, 60, 50);
        } else if (Obj.c == red) {
          Obj.hp = 0;
          hp = hp - 600;
          explode(Obj.loc.x, Obj.loc.y, Obj.c, 60, 50);
        }
        if (hp <= 0) {
          myObjects.add(new Piece(loc.x, loc.y, roomX, roomY, roomZ));
        }
      }

      if (Obj instanceof Beam && hits(Obj, s/2, 8)) {
        hp = hp - 200;
        Obj.hp = 0;
        explode(Obj.loc.x, Obj.loc.y, white, 50, 50);
        if (hp <= 0) {
          myObjects.add(new Piece(loc.x, loc.y, roomX, roomY, roomZ));
        }
      }
      if (Obj instanceof Fire && hits(Obj, s/2, Obj.s/2)) {
        hp = hp - 5;
        Obj.hp = 0;
        if (hp <= 0) {
          myObjects.add(new Piece(loc.x, loc.y, roomX, roomY, roomZ));
        }
      }
      if (Obj instanceof Fireball || Obj instanceof Spikeball) {
        if (hits(Obj, s/2, Obj.s/2)) {
          hp = 0;
          if (hp <= 0) {
            myObjects.add(new Piece(loc.x, loc.y, roomX, roomY, roomZ));
          }
        }
      }
      if (Obj instanceof Splash) {
        if (hits(Obj, s/2, Obj.s/2)) {
          hp = hp - 4000;
          Obj.hp = 0;
          explode(Obj.loc.x, Obj.loc.y, black, 60, 50);
        }
      }
      i = i + 1;
    }
  }
}


class Boss extends GameObject { //boss enemy ================================================================================

  int followTimer;
  int bulletTimer;
  int flameTimer;
  int laserTimer;
  int blockTimer;
  float shoot;

  Boss(int _hp, int rx, int ry, int rz, float _s) {
    loc = new PVector(width*4/5, height/2);
    vel = new PVector(0, 0);
    s = _s;
    hp = _hp;
    hpMax = _hp;
    xp = 5000;
    roomX = rx;
    roomY = ry;
    roomZ = rz;
    followTimer = bulletTimer = flameTimer = laserTimer = blockTimer = 120;
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(PI+HALF_PI);

    strokeWeight(5);
    stroke(blue);
    fill(darkGrey);
    arc(-50, -50, 100, 200, radians(300), radians(510), CHORD);
    arc(50, -50, 100, 200, radians(30), radians(240), CHORD);
    fill(black);
    arc(-100, -60, 80, 160, radians(330), radians(570), CHORD);
    arc(100, -60, 80, 160, radians(330), radians(570), CHORD);
    arc(-80, 200, 80, 120, radians(180), radians(360), CHORD);
    arc(80, 200, 80, 120, radians(180), radians(360), CHORD);
    arc(0, 210, 80, 120, radians(180), radians(360), CHORD);

    arc(-230, -10, 80, 160, radians(330), radians(570), CHORD);
    arc(230, -10, 80, 160, radians(330), radians(570), CHORD);

    fill(darkGrey);
    rect(-311, 12, 20, 260);
    rect(311, 12, 20, 260);
    quad(-320, 144, 320, 144, 200, -60, -200, -60);
    fill(black);
    arc(-290, -120, 60, 60, radians(0), radians(270), PIE);
    arc(290, -120, 60, 60, radians(270), radians(540), PIE);
    triangle(-350, 100, -220, -40, 0, 144);
    triangle(350, 100, 220, -40, 0, 144);

    fill(darkGrey);
    rect(0, 180, 120, 20);
    rect(0, 150, 150, 40);
    rect(0, 100, 180, 100);
    fill(lightGrey);
    triangle(-260, 190, 0, 120, 0, -80);
    triangle(260, 190, 0, 120, 0, -80);
    fill(white);
    circle(0, 0, 100);
    circle(-100, 0, 100);
    circle(100, 0, 100);
    circle(-50, 88, 100);
    circle(50, 88, 100);

    pushMatrix();
    translate(-220, 60);
    PVector boss1Dir = new PVector(myHero.loc.x-loc.x, myHero.loc.y-loc.y);
    rotate(boss1Dir.heading());
    noStroke();
    strokeWeight(1);
    fill(lightGrey);
    square(0, 0, 60);
    rotate(QUARTER_PI);
    square(0, 0, 60);
    popMatrix();

    pushMatrix();
    translate(220, 60);
    PVector boss2Dir = new PVector(myHero.loc.x-loc.x, myHero.loc.y-loc.y);
    rotate(boss2Dir.heading());
    noStroke();
    strokeWeight(1);
    fill(lightGrey);
    square(0, 0, 60);
    rotate(QUARTER_PI);
    square(0, 0, 60);
    popMatrix();

    popMatrix();
  }

  void act() {
    super.act();

    int i = 0;
    while (i < myObjects.size()) {
      GameObject Obj = myObjects.get(i);
      if (Obj instanceof Bullet && hits(Obj, s/2, Obj.s/2)) {
        if (Obj.c == blue || Obj.c == lightGrey) {
          Obj.hp = 0;
          hp = hp - (2700+myHero.damage*20);
          explode(Obj.loc.x, Obj.loc.y, Obj.c, 60, 50);
        } else if (Obj.c == red) {
          Obj.hp = 0;
          hp = hp - (600+myHero.damage*20);
          explode(Obj.loc.x, Obj.loc.y, Obj.c, 60, 50);
        }
        if (hp <= 0) {
          myHero.xp = myHero.xp + xp;
          myTexts.add(new Text(loc.x, loc.y, "+"+xp/10, gold1, 40, 0.7, 3));
        }
      }
      if (Obj instanceof Bolt && hits(Obj, s/2, Obj.s/2)) {
        Obj.hp = 0;
        hp = hp - (3000+myHero.damage*20);
        explode(Obj.loc.x, Obj.loc.y, Obj.c, 40, 50);
      }

      if (Obj instanceof Beam && hits(Obj, s/2, 8)) {
        hp = hp - (200+myHero.damage*2);
        Obj.hp = 0;
        explode(Obj.loc.x, Obj.loc.y, white, 40, 50);
        if (hp <= 0) {
          myHero.xp = myHero.xp + xp;
          myTexts.add(new Text(loc.x, loc.y, "+"+xp/10, gold1, 40, 0.7, 3));
        }
      }
      if (Obj instanceof Fire && hits(Obj, s/2, Obj.s/2)) {
        hp = hp - (5+myHero.damage);
        Obj.hp = 0;
        if (hp <= 0) {
          myHero.xp = myHero.xp + xp;
          myTexts.add(new Text(loc.x, loc.y, "+"+xp/10, gold1, 40, 0.7, 3));
        }
      }
      if (Obj instanceof Fireball || Obj instanceof Spikeball) {
        if (hits(Obj, s/2, Obj.s/2)) {
          hp = hp - (2000+myHero.damage*2);
          if (Obj instanceof Spikeball) ((Spikeball) Obj).redirect();
          if (hp <= 0) {
            myHero.xp = myHero.xp + xp;
            myTexts.add(new Text(loc.x, loc.y, "+"+xp/10, gold1, 40, 0.7, 3));
          }
        }
      }
      if (Obj instanceof Splash) {
        if (hits(Obj, s/2, Obj.s/2)) {
          hp = hp - (4000+myHero.damage*10);
          Obj.hp = 0;
          explode(Obj.loc.x, Obj.loc.y, black, 60, 50);
          if (hp <= 0) {
            myHero.xp = myHero.xp + xp;
            myTexts.add(new Text(loc.x, loc.y, "+"+xp/10, gold1, 40, 0.7, 3));
          }
        }
      }
      i = i + 1;
    }

    followTimer = followTimer - 1;
    if (followTimer <= 0) {
      myObjects.add(new Stalker(10000, loc.x-100, loc.y-100, roomX, roomY, roomZ, 30));
      myObjects.add(new Stalker(10000, loc.x-100, loc.y+100, roomX, roomY, roomZ, 30));
      followTimer = 70;
    }

    bulletTimer = bulletTimer - 1;
    if (bulletTimer <= 0) {
      myObjects.add(new EnemyBullet(loc.x+60, loc.y-220, myHero.loc.x-loc.x, myHero.loc.y-loc.y));
      myObjects.add(new EnemyBullet(loc.x+60, loc.y+220, myHero.loc.x-loc.x, myHero.loc.y-loc.y));
      bulletTimer = 40;
    }

    if (myHero.loc.x > width/2) {
      int u = 0;
      while (u < 30) {
        myObjects.add(new Ice(loc.x-120, loc.y-290, -width/4, height/2));
        myObjects.add(new Ice(loc.x-120, loc.y+290, -width/4, -height/2));
        u++;
      }
    }

    laserTimer = laserTimer + 1;
    if (laserTimer == 300) {
      shoot = int(random(0, 3));
    }
    if (laserTimer > 320) {
      if (shoot == 0) {
        myObjects.add(new EnemyBeam(loc.x-56, loc.y-230, -width, 0));
      } else if (shoot == 1) {
        myObjects.add(new EnemyBeam(loc.x-56, loc.y+230, -width, 0));
      } else if (shoot == 2) {
        myObjects.add(new EnemyBeam(loc.x-86, loc.y, -width, 0));
      }
    }
    if (laserTimer >= 700) {
      laserTimer = 0;
    }

    blockTimer = blockTimer - 1;
    if (blockTimer <= 0) {
      myObjects.add(new Stopper(roomX, roomY, roomZ, loc.x-46, loc.y-230, 60));
      myObjects.add(new Stopper(roomX, roomY, roomZ, loc.x-46, loc.y+230, 60));
      blockTimer = 500;
    }
  }
}
