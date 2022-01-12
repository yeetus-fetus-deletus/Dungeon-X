class Bullet extends GameObject {

  Bullet() {
    c = white;
    s = 12;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
  }
  Bullet(PVector aimVector, color _c, float _s, float distanceX, float distanceY) {
    loc = new PVector(myHero.loc.x, myHero.loc.y);
    nudgeX = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeY = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeX.setMag(distanceX);
    nudgeY.setMag(distanceY);
    nudgeX.rotate(HALF_PI);
    loc.add(nudgeX);
    loc.add(nudgeY);
    vel = new PVector(aimVector.x, aimVector.y);
    vel.setMag(10);
    vel.add(myHero.vel);
    hp = 1;
    c = _c;
    s = _s;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    PVector bulletDir = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
    rotate(bulletDir.heading()+HALF_PI);
    noStroke();
    fill(c);
    circle(0, 0, s);
    popMatrix();
  }
  void act() {
    loc.add(vel);
    if (loc.x < 100 || loc.x > width-100 || loc.y < 100 || loc.y > height-100) {
      hp = 0;
      explode(loc.x, loc.y, c, 50, 50);
    }
  }
}

class EnemyBullet extends Bullet {

  EnemyBullet(float x, float y, float vx, float vy) {
    super();
    loc = new PVector(x, y);
    vel = new PVector(vx, vy);
    vel.setMag(1);
  }

  void show() {
    noStroke();
    fill(c);
    circle(loc.x, loc.y, s);
  }
  void act() {
    super.act();
    vel.setMag(vel.mag()*1.1);
    if (vel.mag() >= 36) vel.setMag(36);
  }
}

class Bolt extends Bullet {

  Bolt(PVector aimVector, float x, float y, color _c, float _s) {
    loc = new PVector(x, y);
    nudgeY = new PVector(aimVector.x, aimVector.y);
    nudgeY.setMag(75);
    loc.add(nudgeY);
    vel = new PVector(aimVector.x, aimVector.y);
    vel.setMag(15);
    hp = 1;
    c = _c;
    s = _s;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    dir = vel.copy();
    rotate(dir.heading()+HALF_PI);
    strokeWeight(1);
    stroke(white);
    fill(c);
    quad(0, -10, -7, 10, 0, 4, 7, 10);
    popMatrix();
  }
  void act() {
    super.act();
  }
}


class Fireball extends Bullet {

  //constructor
  Fireball(PVector aimVector) {
    super();
    nudgeY = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeY.setMag(50);
    loc = new PVector(myHero.loc.x, myHero.loc.y);
    loc.add(nudgeY);
    vel = new PVector(aimVector.x, aimVector.y);
    vel.setMag(15);
    c = orange;
    s = 60;
    timer = 300;
  }

  //behaviour
  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    strokeWeight(5);
    stroke(white);
    fill(red);
    circle(0, 0, s);
    noStroke();
    fill(c);
    circle(0, 0, s*5/6);
    fill(yellow);
    circle(0, 0, s*3/5);
    popMatrix();
  }
  void act() {
    loc.add(vel);
    if (loc.x < 100 || loc.x > width-100) vel.x = -vel.x;
    if (loc.y < 100 || loc.y > height-100) vel.y = -vel.y;

    timer = timer - 1;
    if (timer <= 0) {
      hp = 0;
      explode(loc.x, loc.y, c, 10, 100);
    }

    int i = 0;
    while (i < 10) {
      myObjects.add(new Tail(loc.x, loc.y, vel.x, vel.y, int(random(160, 220)), 50, 16));
      i = i + 1;
    }
  }
}
class Spikeball extends Bullet {

  Spikeball(PVector aimVector) {
    super();
    nudgeY = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeY.setMag(50);
    loc = new PVector(myHero.loc.x, myHero.loc.y);
    loc.add(nudgeY);
    vel = new PVector(aimVector.x, aimVector.y);
    vel.setMag(15);
    c = white;
    s = 60;
    timer = 300;
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(radians(5));
    noStroke();
    fill(c);
    square(0, 0, s);
    rotate(QUARTER_PI/2);
    square(0, 0, s);
    rotate(QUARTER_PI/2);
    square(0, 0, s);
    rotate(QUARTER_PI/2);
    square(0, 0, s);
    popMatrix();
  }
  void act() {
    loc.add(vel);
    if (loc.x < 100 || loc.x > width-100) vel.x = -vel.x;
    if (loc.y < 100 || loc.y > height-100) vel.y = -vel.y;

    timer = timer - 1;
    if (timer <= 0) {
      hp = 0;
      explode(loc.x, loc.y, c, 15, 100);
    }
  }

  void redirect() {
    float currDist;
    float shortDist = 2000;
    int i = 0;
    while (i < myObjects.size()) {
      GameObject Obj = myObjects.get(i);
      if (Obj instanceof Stalker) {
        if (with(Obj)) {
          currDist = dist(Obj.loc.x, Obj.loc.y, loc.x, loc.y);
          if (currDist > 40 && currDist < shortDist) {
            PVector aimVector = new PVector(Obj.loc.x-loc.x, Obj.loc.y-loc.y);
            aimVector.setMag(15);
            vel = aimVector;
          }
        }
      }
      i = i + 1;
    }
  }
}
class Splash extends Bullet {

  //constructor
  Splash(PVector aimVector) {
    super();
    nudgeY = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeY.setMag(50);
    loc = new PVector(myHero.loc.x, myHero.loc.y);
    loc.add(nudgeY);
    vel = new PVector(aimVector.x, aimVector.y);
    vel.setMag(15);
    c = brown;
    s = 60;
    timer = 30;
  }

  //behaviour
  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(myHero.dir.heading()+HALF_PI);
    image(toxic, 0, 0, 43.25, 71);
    popMatrix();
  }
  void act() {
    loc.add(vel);

    timer = timer - 1;
    if (timer <= 0 || loc.x < 140 || loc.x > width-140 || loc.y < 140 || loc.y > height-140) {
      hp = 0;
    }
    if (hp <= 0) {
      explode(loc.x, loc.y, c, 20, 100);
      myObjects.add(new Field(loc.x, loc.y));
    }
  }
}
class Field extends Bullet {

  Field(float x, float y) {
    super();
    loc = new PVector(x, y);
    vel.setMag(0);
    s = 300;
    c = darkBrown;
    timer = 360;
    poisonTimer = 0;
  }

  void show() {
    strokeWeight(10);
    stroke(c);
    fill(c, 80);
    circle(loc.x, loc.y, s);
  }
  void act() {
    timer = timer - 1;
    if (timer <= 0) {
      hp = 0;
      explode(loc.x, loc.y, c, 10, 100);
    }

    int i = 0;
    while (i < myObjects.size()) {
      GameObject Obj = myObjects.get(i);
      if (Obj instanceof Stopper || Obj instanceof Stalker || Obj instanceof Shooter || Obj instanceof Spawner) {
        if (hits(Obj, s/2, Obj.s/2)) {
          poisonTimer = poisonTimer + 1;
          if (poisonTimer >= 30) {
            Obj.hp = Obj.hp - (2400+myHero.damage*30);
            myTexts.add(new Text(Obj.loc.x, Obj.loc.y, "-"+(2400+myHero.damage*40)/200+" HP", red, 25, 0.7, 3));
            poisonTimer = 0;
          }
          if (Obj.hp <= 0) {
            float chance = random(0, 1);
            if (chance < 0.5) {
              myObjects.add(new DroppedItem(Obj.loc.x, Obj.loc.y, roomX, roomY, roomZ));
            }
            myHero.xp = myHero.xp + Obj.xp*2;
            myTexts.add(new Text(Obj.loc.x, Obj.loc.y, "+"+Obj.xp/5, gold1, 40, 0.7, 3));
          }
        }
      }
      if (Obj instanceof Chest) {
        if (hits(Obj, s/2, Obj.s/2)) {
          poisonTimer = poisonTimer + 1;
          if (poisonTimer >= 30) {
            Obj.hp = Obj.hp - (2400+myHero.damage*30);
            myTexts.add(new Text(Obj.loc.x, Obj.loc.y, "-"+(2400+myHero.damage*40)/200+" HP", red, 25, 0.7, 3));
            poisonTimer = 0;
          }
          if (Obj.hp <= 0) {
            myObjects.add(new Piece(Obj.loc.x, Obj.loc.y, roomX, roomY, roomZ));
            myHero.xp = myHero.xp + Obj.xp*2;
            myTexts.add(new Text(Obj.loc.x, Obj.loc.y, "+"+Obj.xp/5, gold1, 40, 0.7, 3));
          }
        }
      }
      if (Obj == myBoss) {
        if (hits(Obj, s/2, Obj.s/2)) {
          poisonTimer = poisonTimer + 1;
          if (poisonTimer >= 30) {
            Obj.hp = Obj.hp - (2400+myHero.damage*30);
            myTexts.add(new Text(Obj.loc.x, Obj.loc.y, "-"+(2400+myHero.damage*40)/200+" HP", red, 25, 0.7, 3));
            poisonTimer = 0;
          }
        }
      }
      i = i + 1;
    }
  }
}


class Beam extends GameObject {

  //constructor
  Beam(PVector aimVector, float distanceX, float distanceY) {
    hp = 1;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    loc = new PVector(myHero.loc.x, myHero.loc.y);
    nudgeX = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeY = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeX.rotate(HALF_PI);
    nudgeX.setMag(distanceX);
    nudgeY.setMag(distanceY);
    loc.add(nudgeX);
    loc.add(nudgeY);
    vel = new PVector(aimVector.x, aimVector.y);
    vel.setMag(12);
  }

  //behaviour
  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    PVector laserDir = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
    rotate(laserDir.heading()+HALF_PI);
    noStroke();
    fill(red);
    rect(0, 0, 16, 12);
    fill(white);
    rect(0, 0, 12, 16);
    popMatrix();
  }
  void act() {
    loc.add(vel);
    if (loc.x < 110 || loc.x > width-110 || loc.y < 110 || loc.y > height-110) {
      hp = 0;
      int u = 0;
      while (u < 50) {
        myObjects.add(new Particle(loc.x, loc.y, white, 30));
        u++;
      }
    }
  }
}
class InfernoBeam extends GameObject {

  InfernoBeam(float x, float y, float vx, float vy) {
    hp = 1;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    loc = new PVector(x, y);
    nudgeY = new PVector(vx, vy);
    nudgeY.setMag(70);
    loc.add(nudgeY);
    vel = new PVector(vx, vy);
    vel.setMag(10);
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    PVector blastDir = new PVector(vel.x, vel.y);
    rotate(blastDir.heading()+HALF_PI);
    noStroke();
    fill(darkGrey);
    rect(0, 0, 14, 12);
    fill(black);
    rect(0, 0, 12, 14);
    fill(yellow);
    rect(0, 0, 10, 16);
    popMatrix();
  }
  void act() {
    loc.add(vel);
    if (loc.x < 110 || loc.x > width-110 || loc.y < 110 || loc.y > height-110) {
      hp = 0;
      int u = 0;
      while (u < 50) {
        myObjects.add(new Particle(loc.x, loc.y, white, 30));
        u++;
      }
    }
    int i = 0;
    while (i < myObjects.size()) {
      GameObject Obj = myObjects.get(i);
      if (Obj == myBoss && hits(Obj, 6, Obj.s/2)) {
        Obj.hp = Obj.hp - (150+myHero.damage*2);
        hp = 0;
        explode(loc.x, loc.y, yellow, 30, 50);
      }
      i++;
    }
  }
}
class EnemyBeam extends GameObject {

  //constructor
  EnemyBeam(float x, float y, float vx, float vy) {
    hp = 1;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    loc = new PVector(x, y);
    vel = new PVector(vx, vy);
    vel.setMag(10);
  }

  //behaviour
  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    PVector blastDir = new PVector(vel.x, vel.y);
    rotate(blastDir.heading()+HALF_PI);
    noStroke();
    fill(white);
    rect(0, 0, 20, 12);
    fill(black);
    rect(0, 0, 16, 14);
    fill(green);
    rect(0, 0, 12, 16);
    popMatrix();
  }
  void act() {
    loc.add(vel);
    if (loc.x < 110 || loc.x > width-110 || loc.y < 110 || loc.y > height-110) {
      hp = 0;
      int u = 0;
      while (u < 50) {
        myObjects.add(new Particle(loc.x, loc.y, green, 30));
        u++;
      }
    }
    int i = 0;
    while (i < myObjects.size()) {
      GameObject Obj = myObjects.get(i);
      if (Obj instanceof Beam && hits(Obj, 6, 6)) {
        Obj.hp = 0;
        hp = 0;
        explode(Obj.loc.x, Obj.loc.y, white, 20, 80);
        explode(loc.x, loc.y, green, 20, 80);
      }
      if (Obj instanceof InfernoBeam && hits(Obj, 6, 6)) {
        Obj.hp = 0;
        hp = 0;
        explode(Obj.loc.x, Obj.loc.y, yellow, 20, 80);
        explode(loc.x, loc.y, green, 20, 80);
      }
      if (Obj instanceof Fireball || Obj instanceof Spikeball || Obj instanceof Splash) {
        if (hits(Obj, 6, Obj.s/2)) {
          hp = 0;
          explode(loc.x, loc.y, white, 20, 80);
          explode(loc.x, loc.y, green, 20, 80);
        }
      }
      i++;
    }
  }
}


class Fire extends GameObject { //fire particles ========================================

  float t;

  Fire(PVector aimVector, float distanceX, float distanceY) {
    hp = 1;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    s = int(random(6, 12));
    t = 255;
    loc = myHero.loc.copy();
    nudgeX = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeY = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeX.rotate(HALF_PI);
    nudgeX.setMag(distanceX);
    nudgeY.setMag(distanceY);
    loc.add(nudgeX);
    loc.add(nudgeY);
    vel = new PVector(aimVector.x, aimVector.y);
    vel.rotate(random(-0.25, 0.25));
    vel.setMag(myHero.vel.mag()/2+random(5, 8));
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    PVector flameDir = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
    rotate(flameDir.heading()+HALF_PI);
    colorMode(HSB);
    noStroke();
    fill(random(5, 25), 255, 255, t);
    circle(0, 0, s);
    colorMode(RGB);
    popMatrix();
  }
  void act() {
    super.act();
    t = t - 8;
    if (t <= 0) hp = 0;
  }
}
class Ice extends GameObject { //fire particles ========================================

  float t;

  Ice(float x, float y, float vx, float vy) {
    hp = 1;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    s = int(random(6, 12));
    t = 255;
    loc = new PVector(x, y);
    vel = new PVector(vx, vy);
    vel.rotate(random(-0.3, 0.3));
    vel.setMag(random(5, 8));
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(vel.heading());
    colorMode(HSB);
    noStroke();
    fill(220, random(40, 80), 255, t);
    circle(0, 0, s);
    colorMode(RGB);
    popMatrix();
  }
  void act() {
    super.act();
    t = t - 6;
    if (t <= 0) hp = 0;
  }
}


class Particle extends GameObject { //explosion particles ========================================

  float t;
  float f;

  Particle(float x, float y, color _c, float _f) {
    hp = 1;
    s = int(random(8, 12));
    t = 255;
    c = _c;
    f = _f;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    loc = new PVector(x, y);
    vel = new PVector(0, 5);
    vel.rotate(random(0, TAU));
  }

  void show() {
    noStroke();
    fill(c, t);
    circle(loc.x, loc.y, s);
  }
  void act() {
    loc.add(vel);
    t = t - f;
    if (t <= 0) hp = 0;
  }
}


class Exhaust extends GameObject {

  float t;

  Exhaust(float distanceX, float distanceY) {
    hp = 1;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    c = white;
    s = 10;
    t = 255;
    loc = myHero.loc.copy();
    nudgeX = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeY = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeX.rotate(HALF_PI);
    nudgeX.setMag(distanceX);
    nudgeY.rotate(PI);
    nudgeY.setMag(distanceY);
    loc.add(nudgeX);
    loc.add(nudgeY);
    vel = myHero.vel.copy();
    vel.rotate(PI);
    vel.setMag(-1);
  }
  Exhaust(float distanceX, float distanceY, color _c, float _s) {
    hp = 1;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    c = _c;
    s = _s;
    t = 255;
    loc = myHero.loc.copy();
    nudgeX = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeY = new PVector(myHero.dir.x, myHero.dir.y);
    nudgeX.rotate(HALF_PI);
    nudgeX.setMag(distanceX);
    nudgeY.rotate(PI);
    nudgeY.setMag(distanceY);
    loc.add(nudgeX);
    loc.add(nudgeY);
    vel = myHero.vel.copy();
    vel.rotate(PI);
    vel.setMag(-1);
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(HALF_PI+PI);
    noStroke();
    fill(c, t);
    square(0, 0, s);
    popMatrix();
  }
  void act() {
    super.act();
    t = t - 15;
    if (t <= 0) hp = 0;
  }
}


class Tail extends GameObject {

  float t;
  float f;

  Tail(float x, float y, float vx, float vy, color _c, float _s, float _f) {
    hp = 1;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    c = _c;
    s = _s;
    t = 255;
    f = _f;
    loc = new PVector(x, y);
    nudgeY = new PVector(vx, vy);
    nudgeY.rotate(PI);
    nudgeY.setMag(50);
    loc.add(nudgeY);
    vel = new PVector(vx, vy);
    vel.rotate(PI);
    vel.setMag(-1);
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(HALF_PI+PI);
    noStroke();
    fill(c, t);
    circle(0, 0, s);
    s = s - random(0.5, 2);
    popMatrix();
  }
  void act() {
    super.act();
    t = t - f;
    if (t <= 0) hp = 0;
  }
}
