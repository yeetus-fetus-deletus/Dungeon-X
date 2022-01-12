class DroppedItem extends GameObject {

  int type;
  Weapon w;

  DroppedItem(float x, float y, int rx, int ry, int rz) {
    roomX = rx;
    roomY = ry;
    roomZ = rz;
    if (roomZ < 5) {
      type = int(random(0, 5));
    } else if (roomZ >= 5) {
      type = int(random(1, 8));
    }
    
    //type = int(random(5, 8));

    hp = 1;
    s = 30;
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    dir = new PVector(random(0, width), random(0, height));
    if (type == HEALTH) {
      c = lightGrey;
    } else if (type == POISON) {
      w = arsenal[7];
      c = darkBrown;
    } else if (type == SPIKE) {
      w = arsenal[6];
      c = white;
    } else if (type == FIREBALL) {
      w = arsenal[5];
      c = black;
    } else if (type == VISION) {
      c = green;
    } else if (type == SENTRY) {
      c = lightBlue;
    } else if (type == TURRET) {
      c = red;
    } else if (type == INFERNO) {
      c = yellow;
    }
    vel.rotate(random(0, TAU));
    vel.setMag(5);
  }

  void show() {
    if (type == HEALTH) {
      image(gear1, loc.x-10, loc.y-5, 52.4, 47.6);
      image(gear2, loc.x+10, loc.y+5, 66.2, 37.7);
    } else if (type == POISON) {
      image(toxic, loc.x, loc.y, 43.25, 71);
    } else if (type == SPIKE) {
      strokeWeight(2);
      stroke(white);
      fill(c);
      square(loc.x, loc.y, s);
    } else if (type == FIREBALL) {
      strokeWeight(2);
      stroke(white);
      fill(c);
      square(loc.x, loc.y, s);
    } else if (type == VISION) {
      pushMatrix();
      translate(loc.x, loc.y);
      strokeWeight(2);
      stroke(black);
      fill(c);
      quad(-12, -10, 12, -10, 20, 10, -20, 10);
      popMatrix();
    } else if (type == SENTRY) {
      strokeWeight(2);
      stroke(black);
      fill(c);
      square(loc.x, loc.y, s);
    } else if (type == TURRET) {
      strokeWeight(2);
      stroke(black);
      fill(c);
      square(loc.x, loc.y, s);
    } else if (type == INFERNO) {
      strokeWeight(2);
      stroke(black);
      fill(c);
      square(loc.x, loc.y, s);
    }
    loc.add(vel);
    vel.setMag(vel.mag()*0.9);
  }
  void act() {
  }
}

class Piece extends GameObject {

  Piece(float x, float y, int rx, int ry, int rz) {
    hp = 1;
    s = 30;
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    dir = new PVector(random(0, width), random(0, height));
    roomX = rx;
    roomY = ry;
    roomZ = rz;
    timeOut = 0;
    textTimer = 0;
    vel.rotate(random(0, TAU));
    vel.setMag(3);
  }

  void show() {
    if (PIECES == 4) {
      image(piece1, loc.x, loc.y, 32.25, 38.25);
    } else if (PIECES == 3) {
      image(piece2, loc.x, loc.y, 32.25, 38.25);
    } else if (PIECES == 2) {
      image(piece3, loc.x, loc.y, 32.25, 38.25);
    } else if (PIECES == 1) {
      image(piece4, loc.x, loc.y, 32.25, 38.25);
    }
    loc.add(vel);
    vel.setMag(vel.mag()*0.9);
  }
  void act() {
  }
}

class Portal extends GameObject {

  int type, hx, hy;

  Portal(float x, float y, int rx, int ry, int rz, int _hx, int _hy, int _type) {
    type = _type;
    hp = 1;
    s = 30;
    loc = new PVector(x, y);
    vel = new PVector(0, 0);
    dir = new PVector(random(0, width), random(0, height));
    roomX = rx;
    roomY = ry;
    roomZ = rz;
    hx = _hx;
    hy = _hy;
  }

  void show() {
    pushMatrix();
    translate(loc.x, loc.y);
    strokeWeight(5);
    if (type == FLOOR_UP) {
      stroke(ice);
      fill(lightBlue);
      circle(0, 0, 90);
      noStroke();
      fill(ice);
      circle(0, 0, 75);
      fill(lightBlue);
      circle(0, 0, 60);
      fill(blue);
      circle(0, 0, 50);
      fill(lightBlue);
      circle(0, 0, 40);
      fill(blue);
      circle(0, 0, 30);
    } else if (type == FLOOR_DOWN) {
      stroke(#FFCCFF);
      fill(#FF88FF);
      circle(0, 0, 90);
      noStroke();
      fill(#FFCCFF);
      circle(0, 0, 75);
      fill(#FF88FF);
      circle(0, 0, 60);
      fill(red);
      circle(0, 0, 50);
      fill(#FF88FF);
      circle(0, 0, 40);
      fill(red);
      circle(0, 0, 30);
    }
    popMatrix();
  }
  void act() {
  }
}
