//Oct. 20th, 2021 - Jan. 13th, 2022
//Ian Mo
//Dungeon Crawl: Dungeon X

final int INTRO    = 1;
final int GUIDE    = 2;
final int OPTIONS  = 3;
final int GAME     = 4;
final int PAUSE    = 5;
final int BOSS     = 6;
final int GAMEOVER = 7;
final int EX       = 8;
int mode;
boolean win, bossMode;
int timeOut, textTimer, guideTimer;
int poisonTimer;

final int VISION   = 0;
final int HEALTH   = 1;
final int SPIKE    = 2;
final int FIREBALL = 3;
final int POISON   = 4;
final int SENTRY   = 5;
final int TURRET   = 6;
final int INFERNO  = 7;
PImage cube1;
PImage cube2;
PImage piece1;
PImage piece2;
PImage piece3;
PImage piece4;
int PIECES;
boolean potion1, potion2, spike, fireball, vision, sentry, sentryOff, turret, turretOff, inferno, infernoOff;

final int FLOOR_UP   = 1;
final int FLOOR_DOWN = 2;

//keys ========================================
boolean wkey, skey, akey, dkey, spacekey, jkey, ukey, ikey, okey, pkey, leftkey, rightkey;

//button clicks ========================================
boolean mouseReleased;
boolean wasPressed;

//buttons ========================================
Button startButton;
Button playButton;
Button closeButton;
Button pauseButton;
Button gameButton;
Button homeButton;
Button exitButton;
Button cancelButton;
Button yesButton;
Button heroIButton;
Button heroIIButton;
Button heroIIIButton;
Button heroIVButton;
Button heroVButton;
Button heroVIButton;

Button increaseHP;
Button increaseSpeed;
Button increaseDamage;

boolean firestorm, stallion, hypershock, blackstar, deadlock, revolution;

//colours ========================================
final color gold1     = #FFD700;
final color gold2     = #DAA520;
final color red       = #FF0000;
final color orange    = #FF9000;
final color yellow    = #FFFF00;
final color green     = #00FF00;
final color ice       = #A0C8F7;
final color lightBlue = #39A7FF;
final color blue      = #0000FF;
final color brown     = #6C4E01;
final color darkBrown = #4D3906;
final color black     = #000000;
final color white     = #FFFFFF;
final color lightGrey = #969696;
final color darkGrey  = #646464;
float q = 0;
float h = 0;

//fonts ========================================
PFont enchanted;
PFont longShot;
PFont monochrome;
PFont revamped;
PFont paladins;
PFont bitsumishi;

//backgrounds ========================================
PImage floor;
PImage map;
PImage gear1;
PImage gear2;
PImage toxic;
color north, east, south, west;

//room designs ========================================
int nSX, nGX, nHX, tempXa, tempXb;
int nSY, nGY, nHY, tempYa, tempYb, tempYc, tempYd;
int tXa, tXb, tXc, tXd, tYa, tYb;
int[] xGa, xGb, yGa, yGb, xSb, ySb;
int[] xHa, yHa, xHb, yHb, xHc, yHc, xHd, yHd, xHe, yHe, xHf, yHf;

//gifs ========================================
AnimatedGIF introGIF;
AnimatedGIF guideGIF;
AnimatedGIF gameOverGIF;

//objects ========================================
ArrayList<Message> myTexts;
ArrayList<Dark> darkness;
ArrayList<GameObject> myObjects;
Hero myHero;
Boss myBoss;
Barracks myBarracksA, myBarracksB;
Turret myTurretA, myTurretB;
Inferno myInferno;
int immuneTimer;
Weapon[] arsenal;
int choose;

void setup() {
  size(1200, 800, FX2D);
  imageMode(CENTER);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);

  //backgrounds
  floor = loadImage("images/metal-floor-texture-steel.jpg");

  //miscellaneous images ========================================
  gear1 = loadImage("images/clipart-mechanical-gear.png");
  gear2 = loadImage("images/gear-clip-art.png");
  toxic = loadImage("images/poison.png");

  //pieces ================================================================================
  cube1  = loadImage("images/cubeA.png");
  cube2  = loadImage("images/cubeB.png");
  piece1 = loadImage("images/piece1.png");
  piece2 = loadImage("images/piece2.png");
  piece3 = loadImage("images/piece3.png");
  piece4 = loadImage("images/piece4.png");

  //buttons ========================================
  startButton   = new Button("PLAY", width/2, height*3/4+20, 260, 100, 64);
  closeButton   = new Button("CONTINUE", width-130, 60, 200, 60, 30);
  playButton    = new Button(" ", width-50, 50, 60, 60, 1);
  pauseButton   = new Button(" ", width-50, 50, 60, 60, 1);
  gameButton    = new Button("PLAY AGAIN", width/2, 540, 400, 80, 50);
  homeButton    = new Button("HOME", width/2, 620, 400, 80, 50);
  exitButton    = new Button("EXIT", width/2, 700, 400, 80, 50);
  cancelButton  = new Button("CANCEL", 450, 500, 150, 60, 25);
  yesButton     = new Button("YES", 750, 500, 150, 60, 40);
  heroIButton   = new Button("FIRESTORM", width/4, 250, width/2, 100, 60);
  heroIIButton  = new Button("STALLION", width/4, 350, width/2, 100, 60);
  heroIIIButton = new Button("HYPERSHOCK", width/4, 450, width/2, 100, 60);
  heroIVButton  = new Button("BLACKSTAR", width/4, 550, width/2, 100, 60);
  heroVButton   = new Button("DEADLOCK", width/4, 650, width/2, 100, 60);
  heroVIButton  = new Button("REVOLUTION", width/4, 750, width/2, 100, 60);

  increaseHP     = new Button("10", width/4+50, 320, 50, 50, 25);
  increaseSpeed  = new Button("15", width/4+50, 400, 50, 50, 25);
  increaseDamage = new Button("20", width/4+50, 480, 50, 50, 25);

  firestorm = stallion = hypershock = blackstar = deadlock = revolution = false;

  //fonts ========================================
  enchanted  = createFont("fonts/Enchanted Land.otf", 1);
  longShot   = createFont("fonts/Long_Shot.ttf", 1);
  monochrome = createFont("fonts/Monochrome.ttf", 1);
  revamped   = createFont("fonts/Revamped.otf", 1);
  paladins   = createFont("fonts/paladinslaser.ttf", 1);
  bitsumishi = createFont("fonts/BITSUMIS.TTF", 1);

  introGIF   = new AnimatedGIF(151, "introgif1/frame_", "_delay-0.03s.gif");
  guideGIF   = new AnimatedGIF(41, "guidegif/frame_", "_delay-0.07s-1.gif", width/2, height/2, width+200, height);
  gameOverGIF = new AnimatedGIF(94, "gameovergif/frame_", "_delay-0.07s.gif");


  //available weapons ================================================================================
  arsenal = new Weapon[8];

  arsenal[0] = new Auto();
  arsenal[1] = new Pistol();
  arsenal[2] = new Shotgun();
  arsenal[3] = new Flame();
  arsenal[4] = new Laser();
  arsenal[5] = new Cannon();
  arsenal[6] = new Launcher();
  arsenal[7] = new Splasher();

  choose = 1;

  //rooms ================================================================================
  //gryffindor room design ========================================
  nGX = 19;
  tempXa = 105;
  tempXb = 420;
  xGa = new int[nGX];
  xGb = new int[nGX];
  int iGX = 0;
  while (iGX < nGX) {
    xGa[iGX] = tempXa;
    xGb[iGX] = tempXb;
    tempXa = tempXa + 55;
    tempXb = tempXb + 20;
    if (tempXa >= 1100) {
      tempXa = 105;
      tempXb = 420;
    }
    iGX = iGX + 1;
  }
  nGY = 11;
  tempYa = 100;
  tempYb = 500;
  yGa = new int[nGY];
  yGb = new int[nGY];
  int iGY = 0;
  while (iGY < nGY) {
    yGa[iGY] = tempYa;
    yGb[iGY] = tempYb;
    tempYa = tempYa + 60;
    tempYb = tempYb - 20;
    if (tempYa >= 710) {
      tempYa = 100;
      tempYb = 500;
    }
    iGY = iGY + 1;
  }
  //slytherin room design ========================================
  nSX = 21;
  tempXb = 100;
  xSb = new int[nSX];
  int iSX = 0;
  while (iSX < nSX) {
    xSb[iSX] = tempXb;
    tempXb = tempXb + 50;
    if (tempXb >= 1110) {
      tempXb = 100;
    }
    iSX = iSX + 1;
  }
  nSY = 11;
  tempYb = 100;
  ySb = new int[nSY];
  int iSY = 0;
  while (iSY < nSY) {
    ySb[iSY] = tempYb;
    tempYb = tempYb + 60;
    if (tempYb >= 710) {
      tempYb = 100;
    }
    iSY = iSY + 1;
  }
  //hufflepuff room design ========================================
  nHX = 40;
  tempXa = 100;
  tempYa = 0;
  tempYb = 75;
  xHa = new int[nHX];
  yHa = new int[nHX];
  yHb = new int[nHX];
  int iHXa = 0;
  while (iHXa < nHX) {
    xHa[iHXa] = tempXa;
    yHa[iHXa] = tempYa;
    yHb[iHXa] = tempYb;
    tempXa = tempXa + 25;
    tempYa = tempYa + 25;
    tempYb = tempYb - 25;
    if (tempYa >= 90) {
      tempYa = 0;
    }
    if (tempYb <= -10) {
      tempYb = 75;
    }
    if (tempXa >= 1110) {
      tempXa = 100;
    }
    iHXa = iHXa + 1;
  }
  tempXb = 100;
  tempYc = 700;
  tempYd = 775;
  xHb = new int[nHX];
  yHc = new int[nHX];
  yHd = new int[nHX];
  int iHXb = 0;
  while (iHXb < nHX) {
    xHb[iHXb] = tempXb;
    yHc[iHXb] = tempYc;
    yHd[iHXb] = tempYd;
    tempXb = tempXb + 25;
    tempYc = tempYc + 25;
    tempYd = tempYd - 25;
    if (tempYc >= 790) {
      tempYc = 700;
    }
    if (tempYd <= 690) {
      tempYd = 775;
    }
    if (tempXb >= 1110) {
      tempXb = 100;
    }
    iHXb = iHXb + 1;
  }

  nHY = 24;
  tXa = 0;
  tXb = 75;
  tYa = 100;
  xHc = new int[nHY];
  xHd = new int[nHY];
  yHe = new int[nHY];
  int iHYa = 0;
  while (iHYa < nHY) {
    xHc[iHYa] = tXa;
    xHd[iHYa] = tXb;
    yHe[iHYa] = tYa;
    tXa = tXa + 25;
    tXb = tXb - 25;
    tYa = tYa + 25;
    if (tXa >= 90) {
      tXa = 0;
    }
    if (tXb <= -10) {
      tXb = 75;
    }
    if (tYa >= 810) {
      tYa = 100;
    }
    iHYa = iHYa + 1;
  }
  tXc = 1100;
  tXd = 1175;
  tYb = 100;
  xHe = new int[nHY];
  xHf = new int[nHY];
  yHf = new int[nHY];
  int iHYb = 0;
  while (iHYb < nHY) {
    xHe[iHYb] = tXc;
    xHf[iHYb] = tXd;
    yHf[iHYb] = tYb;
    tXc = tXc + 25;
    tXd = tXd - 25;
    tYb = tYb + 25;
    if (tXc >= 1190) {
      tXc = 1100;
    }
    if (tXd <= 1090) {
      tXd = 1175;
    }
    if (tYb >= 810) {
      tYb = 100;
    }
    iHYb = iHYb + 1;
  }

  //reset game ================================================================================
  reset();


  //starting mode ================================================================================================================================================================
  mode = INTRO;
}

void draw() {
  clicked();
  //println(mouseX, mouseY, myHero.roomX, myHero.roomY, myHero.roomZ, myHero.loc, myHero.vel);
  //println(myHero.roomX, myHero.roomY, myHero.roomZ);

  if (mode == INTRO) {
    intro();
  } else if (mode == GUIDE) {
    guide();
  } else if (mode == OPTIONS) {
    options();
  } else if (mode == GAME) {
    game();
  } else if (mode == PAUSE) {
    pause();
  } else if (mode == BOSS) {
    boss();
  } else if (mode == GAMEOVER) {
    gameOver();
  } else if (mode == EX) {
    ex();
  } else {
    println("Error: Mode = " + mode);
  }
}
void mousePressed() {
  if (mode == GUIDE) {
    guideClicks();
  }
}

void clicked() { //click ================================================================================
  mouseReleased = false;
  if (mousePressed) wasPressed = true;
  if (wasPressed && !mousePressed) {
    mouseReleased = true;
    wasPressed = false;
  }
}

void reset() { //reset game ========================================================================================================================
  myObjects = new ArrayList<GameObject>();
  myHero = new Hero();
  myHero.myWeapon = arsenal[1];
  myBoss = new Boss(4000000, 1, 1, 5, 120);
  myBarracksA = new Barracks(250, 150);
  myBarracksB = new Barracks(250, height-150);
  myTurretA = new Turret(150, 300);
  myTurretB = new Turret(150, height-300);
  myInferno = new Inferno(400, random(150, height-150));

  myTexts = new ArrayList<Message>();
  immuneTimer = 0;
  PIECES = 4;
  potion1 = potion2 = spike = fireball = vision = false;


  myObjects.add(new Chest(40000, 7, 1, 1, 80));
  myObjects.add(new Chest(40000, 4, 2, 2, 80));
  myObjects.add(new Chest(40000, 3, 10, 3, 80));
  myObjects.add(new Chest(40000, 5, 14, 4, 80));
  //floor 1 portals
  myObjects.add(new Portal(150, height-150, 4, 6, 1, 3, 7, FLOOR_UP));
  myObjects.add(new Portal(width-150, height-150, 2, 8, 1, 1, 10, FLOOR_UP));
  myObjects.add(new Portal(width-150, 150, 6, 3, 1, 8, 5, FLOOR_UP));
  //floor 2 portals
  myObjects.add(new Portal(width-150, height-150, 7, 7, 2, 8, 6, FLOOR_UP));
  myObjects.add(new Portal(150, height-150, 1, 5, 2, 2, 5, FLOOR_UP));
  myObjects.add(new Portal(width-150, height-150, 6, 3, 2, 5, 3, FLOOR_DOWN));
  myObjects.add(new Portal(width-150, 150, 3, 9, 2, 2, 8, FLOOR_DOWN));
  //floor 3 portals
  myObjects.add(new Portal(150, height-150, 9, 12, 3, 9, 13, FLOOR_UP));
  myObjects.add(new Portal(width-150, 150, 11, 3, 3, 12, 4, FLOOR_UP));
  myObjects.add(new Portal(width-150, 150, 3, 2, 3, 3, 2, FLOOR_DOWN));
  //floor 4 portals
  myObjects.add(new Portal(width-150, height-150, 2, 1, 4, 3, 1, FLOOR_DOWN));
  myObjects.add(new Portal(150, height-150, 6, 10, 4, 5, 9, FLOOR_DOWN));
  myObjects.add(new Portal(width-150, 150, 12, 12, 4, 10, 11, FLOOR_DOWN));

  darkness = new ArrayList<Dark>();
  int s = 5;
  int x = 0, y = 0;
  while (y < height) {
    darkness.add(new Dark(x, y, s));
    x = x + s;
    if (x >= width) {
      x = 0;
      y = y + s;
    }
  }
}

void gameMap(int z) {
  map = loadImage("images/map"+z+".png");
  int x = 0, y = 0;
  float honk   = map(z, 1, 4, 30, 10);
  float squawk = map(z, 1, 4, 120, 60);
  while (y < map.height) {
    color room = map.get(x, y);
    if (room == #740001) {
      myObjects.add(new Shooter(12000, x, y, z, 50, int(honk)));
    } else if (room == #222F5B) {
      int b = 0;
      while (b < z+2) {
        myObjects.add(new Stopper(20000, x, y, z, 50));
        b = b + 1;
      }
    } else if (room == #2A623D) {
      int g = 0;
      while (g < z+3) {
        myObjects.add(new Stalker(10000, x, y, z));
        g = g + 1;
      }
    } else if (room == #FFDB00) {
      int w = 0;
      while (w < z) {
        myObjects.add(new Spawner(30000, x, y, z, 80, int(squawk)));
        w = w + 1;
      }
    }
    x = x + 1;
    if (x >= map.width) {
      x = 0;
      y = y + 1;
    }
  }
}

//interactions ================================================================================
void keyPressed() {
  if (key == 'w' || key == 'W') wkey = true;
  if (key == 's' || key == 'S') skey = true;
  if (key == 'a' || key == 'A') akey = true;
  if (key == 'd' || key == 'D') dkey = true;
  if (keyCode == ' ') spacekey = true;
  if (key == 'j' || key == 'J') jkey = true;
  if (key == 'u' || key == 'U') ukey = true;
  if (key == 'i' || key == 'I') ikey = true;
  if (key == 'o' || key == 'O') okey = true;
  if (key == 'p' || key == 'P') pkey = true;
  if (keyCode == LEFT) leftkey = true;
  if (keyCode == RIGHT) rightkey = true;
}
void keyReleased() {
  if (key == 'w' || key == 'W') wkey = false;
  if (key == 's' || key == 'S') skey = false;
  if (key == 'a' || key == 'A') akey = false;
  if (key == 'd' || key == 'D') dkey = false;
  if (keyCode == ' ') spacekey = false;
  if (key == 'j' || key == 'J') jkey = false;
  if (key == 'u' || key == 'U') ukey = false;
  if (key == 'i' || key == 'I') ikey = false;
  if (key == 'o' || key == 'O') okey = false;
  if (key == 'p' || key == 'P') pkey = false;
  if (keyCode == LEFT) leftkey = false;
  if (keyCode == RIGHT) rightkey = false;
}
