class Firestorm extends Hero {

  Firestorm() {
    super(1000, 8);
  }

  void show() {
    heroI(loc.x, loc.y, dir.x, dir.y, 1);
  }
  void act() {
    super.act();
    //exhaust ========================================
    if (wkey || skey || akey || dkey) {
      int g = 0;
      while (g < 5) {
        myObjects.add(new Exhaust(-32, 30));
        myObjects.add(new Exhaust(32, 30));
        g = g + 1;
      }
    }
  }
}


class Stallion extends Hero {

  Stallion() {
    super(1100, 10);
  }

  void show() {
    heroII(loc.x, loc.y, dir.x, dir.y, 1);
  }
  void act() {
    super.act();
    if (wkey || skey || akey || dkey) {
      int g = 0;
      while (g < 5) {
        myObjects.add(new Exhaust(-54, 32));
        myObjects.add(new Exhaust(54, 32));
        g = g + 1;
      }
    }
  }
}


class Hypershock extends Hero {

  Hypershock() {
    super(900, 14);
  }

  void show() {
    heroIII(loc.x, loc.y, dir.x, dir.y, 1);
  }
  void act() {
    super.act();
    if (wkey || skey || akey || dkey) {
      int g = 0;
      while (g < 5) {
        myObjects.add(new Exhaust(-16, 58));
        myObjects.add(new Exhaust(16, 58));
        g = g + 1;
      }
    }
  }
}


class Blackstar extends Hero {

  Blackstar() {
    super(1200, 11);
  }

  void show() {
    heroIV(loc.x, loc.y, dir.x, dir.y, 1);
  }
  void act() {
    super.act();
    if (wkey || skey || akey || dkey) {
      int g = 0;
      while (g < 5) {
        myObjects.add(new Exhaust(-18, 68));
        myObjects.add(new Exhaust(18, 68));
        g = g + 1;
      }
    }
  }
}


class Deadlock extends Hero {

  Deadlock() {
    super(1400, 9);
  }

  void show() {
    heroV(loc.x, loc.y, dir.x, dir.y, 1);
  }
  void act() {
    super.act();
    if (wkey || skey || akey || dkey) {
      int g = 0;
      while (g < 5) {
        myObjects.add(new Exhaust(-37, 72));
        myObjects.add(new Exhaust(37, 72));
        g = g + 1;
      }
    }
  }
}


class Revolution extends Hero {

  Revolution() {
    super(1500, 12);
  }

  void show() {
    heroVI(loc.x, loc.y, dir.x, dir.y, 1);
  }
  void act() {
    super.act();
    //exhaust ========================================
    if (wkey || skey || akey || dkey) {
      int g = 0;
      while (g < 5) {
        myObjects.add(new Exhaust(-27, 58));
        myObjects.add(new Exhaust(27, 58));
        myObjects.add(new Exhaust(0, 92));
        g = g + 1;
      }
    }
  }
}



class Barracks extends GameObject {

  Barracks(float x, float y) {
    hp = 1;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    loc = new PVector(x, y);
    dir = new PVector(width*2, 0);
    sentryTimer = 0;
    c = blue;
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(dir.heading()+HALF_PI);
    strokeWeight(2);
    stroke(white);
    fill(blue);
    arc(0, -30, 80, 160, 0, PI, CHORD);
    fill(black);
    triangle(0, 45, -20, 20, 20, 20);
    triangle(0, 29, -25, 5, 25, 5);
    triangle(0, 13, -30, -10, 30, -10);
    triangle(0, -7, -35, -25, 35, -25);
    popMatrix();
  }
  void act() {
    sentryTimer = sentryTimer - 1;
    if (sentryTimer <= 0) {
      myObjects.add(new Sentry(loc.x+50, loc.y, 40));
      sentryTimer = 100;
    }
    if (sentryOff) {
      hp = 0;
      explode(loc.x, loc.y, brown, 20, 60);
      sentryOff = false;
    }
  }
}

class Sentry extends GameObject {

  Sentry(float x, float y, float _s) {
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    hp = 12000;
    s = _s;
    c = lightBlue;
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    dir = vel.copy();
    rotate(dir.heading());
    strokeWeight(1);
    stroke(black);
    fill(c);
    square(0, 0, s);
    popMatrix();
    fill(white);
    textFont(revamped);
    textSize(s/2);
    text(hp/200, loc.x, loc.y);
  }
  void act() {
    super.act();
    int i = 0;
    while (i < myObjects.size()) {
      GameObject Obj = myObjects.get(i);
      if (Obj instanceof Stalker || Obj instanceof Stopper || Obj == myBoss) {
        vel = new PVector(Obj.loc.x-loc.x, Obj.loc.y-loc.y);
        vel.setMag(3);
        if (hits(Obj, s/2, Obj.s/2)) {
          Obj.hp = Obj.hp - (200+myHero.damage*10);
          hp = hp - 100;
        }
        if (Obj.hp <= 0) {
          float chance = random(0, 1);
          if (chance < 0.3) {
            myObjects.add(new DroppedItem(Obj.loc.x, Obj.loc.y, roomX, roomY, roomZ));
          }
          myHero.xp = myHero.xp + Obj.xp;
          myTexts.add(new Text(Obj.loc.x, Obj.loc.y, "+"+Obj.xp/10, gold1, 40, 0.7, 3));
          vel = new PVector(Obj.loc.x-loc.x, Obj.loc.y-loc.y);
          vel.setMag(3);
        }
      }
      i++;
    }
  }
}



class Turret extends GameObject {

  PVector aimVector;

  Turret(float x, float y) {
    hp = 1;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    loc = new PVector(x, y);
    aimVector = new PVector(width*2, 0);
  }

  void show() {
    boltTimer = boltTimer - 1;
    if (boltTimer <= 0) {
      int i = 0;
      while (i < myObjects.size()) {
        GameObject Obj = myObjects.get(i);
        if (Obj instanceof Stalker || Obj instanceof Stopper || Obj == myBoss) {
          if (with(Obj)) {
            aimVector = new PVector(Obj.loc.x-loc.x, Obj.loc.y-loc.y);
            aimVector.setMag(15);
            myObjects.add(new Bolt(aimVector, loc.x, loc.y, black, 20));
            boltTimer = 20;
          }
        }
        i++;
      }
    }
    if (turretOff) {
      hp = 0;
      explode(loc.x, loc.y, brown, 20, 60);
      turretOff = false;
    }

    pushMatrix();
    translate(loc.x, loc.y);
    rotate(aimVector.heading()+HALF_PI);
    strokeWeight(2);
    stroke(white);
    fill(red);
    quad(-50, -40, 50, -40, 24, 52, -24, 52);
    fill(0);
    triangle(0, -10, -25, -35, 25, -35);
    triangle(0, 5, -18, -20, 18, -20);
    triangle(0, 24, -24, -5, 24, -5);
    triangle(0, 50, -30, 10, 30, 10);
    rect(0, -20, 28, 90);
    popMatrix();
  }
  void act() {
  }
}



class Inferno extends GameObject {
  
  PVector aimVector;

  Inferno(float x, float y) {
    hp = 1;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    loc = new PVector(x, y);
    aimVector = new PVector(myBoss.loc.x-loc.x, myBoss.loc.y-loc.y);
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(aimVector.heading()+HALF_PI);
    strokeWeight(2);
    stroke(white);
    fill(150);
    circle(0, 0, 80);
    fill(yellow);
    triangle(0, -60, -35, 40, 35, 40);
    fill(0);
    triangle(-24, 10, 24, 10, 0, 40);
    triangle(-18, -4, 18, -4, 0, 20);
    triangle(-12, -18, 12, -18, 0, 0);
    arc(0, -65, 40, 100, 0, PI, CHORD);
    popMatrix();
  }
  void act() {
    myObjects.add(new InfernoBeam(loc.x, loc.y, aimVector.x, aimVector.y));
    if (infernoOff) {
      hp = 0;
      explode(loc.x, loc.y, brown, 20, 60);
      infernoOff = false;
    }
  }
}
