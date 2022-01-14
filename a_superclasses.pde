class GameObject {

  //instance variables
  PVector loc;
  PVector vel;
  PVector dir;
  PVector nudgeX;
  PVector nudgeY;
  int hp, xp;
  color c;
  float s;
  int roomX, roomY, roomZ;
  int timer, fireTimer, spikeTimer, fieldTimer, visionTimer;
  int barracksTimer, sentryTimer, turretTimer, boltTimer, infernoTimer;
  int damage, damageMax;
  float speed, speedMax;
  int hpMax, hpMaxMax;

  //constructor
  GameObject() {
    loc = new PVector(width/2, height/2);
    vel = new PVector(0, 0);
    hp = 1;
    timer = fireTimer = spikeTimer = fieldTimer = visionTimer = 0;
    barracksTimer = sentryTimer = turretTimer = boltTimer = infernoTimer = 0;
  }

  //behaviour
  void show() {
  }
  void act() {
    loc.add(vel);

    //wall collisions
    if (loc.x < 120) loc.x = 120;
    if (loc.x > width-120) loc.x = width-120;
    if (loc.y < 120) loc.y = 120;
    if (loc.y > height-120) loc.y = height-120;
  }

  boolean with(GameObject obj) { //in same room ========================================
    return roomX == obj.roomX && roomY == obj.roomY && roomZ == obj.roomZ;
  }
  boolean hits(GameObject obj, float sizeA, float sizeB) { //collisions ========================================
    float d = dist(obj.loc.x, obj.loc.y, loc.x, loc.y);
    return with(obj) && d <= sizeA + sizeB && hp > 0;
  }
  boolean pickUp(GameObject obj) { // pickup items ========================================
    float d = dist(obj.loc.x, obj.loc.y, loc.x, loc.y);
    return with(obj) && d <= 50 && hp > 0;
  }
}


class Weapon {

  //instance variables
  int shotTimer;
  int threshold;
  int bulletSpeed;

  //constructor
  Weapon() {
    shotTimer = 0;
    threshold = 30;
    bulletSpeed = 10;
  }
  Weapon(int thr, int bs) {
    shotTimer = 0;
    threshold = thr;
    bulletSpeed = bs;
  }

  //behaviour
  void update() {
    shotTimer++;
  }
  void shoot() {
  }
}

class Message {

  int hp, xp;
  color c;
  float s;
  int roomX, roomY, roomZ;

  Message() {
  }

  void show() {
  }
  void act() {
  }
}
