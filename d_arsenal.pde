class Splasher extends Weapon { //toxic field shooter ========================================

  Splasher() {
    super(60, 15);
  }

  void shoot() {
    if (shotTimer >= threshold && spacekey) {
      PVector aimVector = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
      aimVector.setMag(bulletSpeed);
      myObjects.add(new Splash(aimVector));
      shotTimer = 0;
    }
  }
}
class Cannon extends Weapon { //fireball shooter ========================================

  Cannon() {
    super(60, 15);
  }

  void shoot() {
    if (shotTimer >= threshold && spacekey) {
      PVector aimVector = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
      aimVector.setMag(bulletSpeed);
      myObjects.add(new Fireball(aimVector));
      shotTimer = 0;
    }
  }
}
class Launcher extends Weapon { //spikeball shooter ========================================

  Launcher() {
    super(60, 15);
  }

  void shoot() {
    if (shotTimer >= threshold && spacekey) {
      PVector aimVector = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
      aimVector.setMag(bulletSpeed);
      myObjects.add(new Spikeball(aimVector));
      shotTimer = 0;
    }
  }
}


class Auto extends Weapon { //auto shooting pistol ========================================

  //constructor
  Auto() {
    super(30, 12);
  }

  //behaviour
  void shoot() {
    if (shotTimer >= threshold) {
      PVector aimVector = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
      aimVector.setMag(bulletSpeed);
      if (firestorm) {
        myObjects.add(new Bullet(aimVector, blue, 10, 0, 24));
      } else if (stallion) {
        myObjects.add(new Bullet(aimVector, blue, 10, -32, 19));
        myObjects.add(new Bullet(aimVector, blue, 10, 32, 19));
      } else if (hypershock) {
        myObjects.add(new Bullet(aimVector, blue, 10, -18, 40));
        myObjects.add(new Bullet(aimVector, blue, 10, 18, 40));
      } else if (blackstar) {
        myObjects.add(new Bullet(aimVector, blue, 10, -45, 17));
        myObjects.add(new Bullet(aimVector, blue, 10, 45, 17));
      } else if (deadlock) {
        myObjects.add(new Bullet(aimVector, blue, 10, -57, 65));
        myObjects.add(new Bullet(aimVector, blue, 10, 57, 65));
      } else if (revolution) {
        myObjects.add(new Bullet(aimVector, blue, 10, -27, 50));
        myObjects.add(new Bullet(aimVector, blue, 10, 27, 50));
      }
      shotTimer = 0;
    }
  }
}


class Pistol extends Weapon { //manual pistol ========================================

  //constructor
  Pistol() {
    super(30, 12);
  }

  //behaviour
  void shoot() {
    if (shotTimer >= threshold && spacekey) {
      PVector aimVector = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
      aimVector.setMag(bulletSpeed);
      if (firestorm) {
        myObjects.add(new Bullet(aimVector, lightGrey, 10, 0, 24));
      } else if (stallion) {
        myObjects.add(new Bullet(aimVector, lightGrey, 10, -32, 19));
        myObjects.add(new Bullet(aimVector, lightGrey, 10, 32, 19));
      } else if (hypershock) {
        myObjects.add(new Bullet(aimVector, lightGrey, 10, -18, 40));
        myObjects.add(new Bullet(aimVector, lightGrey, 10, 18, 40));
      } else if (blackstar) {
        myObjects.add(new Bullet(aimVector, lightGrey, 10, -45, 17));
        myObjects.add(new Bullet(aimVector, lightGrey, 10, 45, 17));
      } else if (deadlock) {
        myObjects.add(new Bullet(aimVector, lightGrey, 10, -55, 65));
        myObjects.add(new Bullet(aimVector, lightGrey, 10, 55, 65));
      } else if (revolution) {
        myObjects.add(new Bullet(aimVector, lightGrey, 10, -27, 50));
        myObjects.add(new Bullet(aimVector, lightGrey, 10, 27, 50));
      }
      shotTimer = 0;
    }
  }
}


class Shotgun extends Weapon { //shotgun ========================================

  //constructor
  Shotgun() {
    super(50, 8);
  }

  //behaviour
  void shoot() {   
    if (shotTimer >= threshold && spacekey) {
      int o = 0;
      while (o < 12) {
        PVector aimVector = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
        aimVector.setMag(bulletSpeed);
        aimVector.rotate(random(-0.25, 0.25));
        if (firestorm) {
          myObjects.add(new Bullet(aimVector, red, 6, 0, 24));
        } else if (stallion) {
          myObjects.add(new Bullet(aimVector, red, 6, -32, 19));
          myObjects.add(new Bullet(aimVector, red, 6, 32, 19));
        } else if (hypershock) {
          myObjects.add(new Bullet(aimVector, red, 6, -18, 40));
          myObjects.add(new Bullet(aimVector, red, 6, 18, 40));
        } else if (blackstar) {
          myObjects.add(new Bullet(aimVector, red, 6, -45, 17));
          myObjects.add(new Bullet(aimVector, red, 6, 45, 17));
        } else if (deadlock) {
          myObjects.add(new Bullet(aimVector, red, 6, -57, 60));
          myObjects.add(new Bullet(aimVector, red, 6, 57, 60));
        } else if (revolution) {
          myObjects.add(new Bullet(aimVector, red, 6, -27, 50));
          myObjects.add(new Bullet(aimVector, red, 6, 27, 50));
        }
        o++;
      }
      shotTimer = 0;
    }
  }
}


class Flame extends Weapon { //flamethrower ========================================

  //constructor
  Flame() {
    super(0, 10);
  }

  //behaviour
  void shoot() {
    if (shotTimer >= threshold && spacekey) {
      PVector aimVector = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
      aimVector.setMag(bulletSpeed);
      int i = 0;
      while (i < 30) {
        if (firestorm) {
          myObjects.add(new Fire(aimVector, 0, 24));
        } else if (stallion) {
          myObjects.add(new Fire(aimVector, -32, 19));
          myObjects.add(new Fire(aimVector, 32, 19));
        } else if (hypershock) {
          myObjects.add(new Fire(aimVector, -18, 40));
          myObjects.add(new Fire(aimVector, 18, 40));
        } else if (blackstar) {
          myObjects.add(new Fire(aimVector, -45, 15));
          myObjects.add(new Fire(aimVector, 45, 15));
        } else if (deadlock) {
          myObjects.add(new Fire(aimVector, -55, 65));
          myObjects.add(new Fire(aimVector, 55, 65));
        } else if (revolution) {
          myObjects.add(new Fire(aimVector, -27, 50));
          myObjects.add(new Fire(aimVector, 27, 50));
        }
        i++;
      }
      shotTimer = 0;
    }
  }
}


class Laser extends Weapon { //laser shooter ========================================

  //constructor
  Laser() {
    super(0, 10);
  }

  //behaviour
  void shoot() {
    if (shotTimer >= threshold && spacekey) {
      PVector aimVector = new PVector(mouseX-myHero.loc.x, mouseY-myHero.loc.y);
      aimVector.setMag(bulletSpeed);
      if (firestorm) {
        myObjects.add(new Beam(aimVector, 0, 27));
      } else if (stallion) {
        myObjects.add(new Beam(aimVector, -32, 22));
        myObjects.add(new Beam(aimVector, 32, 22));
      } else if (hypershock) {
        myObjects.add(new Beam(aimVector, -18, 43));
        myObjects.add(new Beam(aimVector, 18, 43));
      } else if (blackstar) {
        myObjects.add(new Beam(aimVector, -45, 20));
        myObjects.add(new Beam(aimVector, 45, 20));
      } else if (deadlock) {
        myObjects.add(new Beam(aimVector, -55, 68));
        myObjects.add(new Beam(aimVector, 55, 68));
      } else if (revolution) {
        myObjects.add(new Beam(aimVector, -27, 53));
        myObjects.add(new Beam(aimVector, 27, 53));
      }
      shotTimer = 0;
    }
  }
}
