class Dark {

  //instance variables
  float opac;
  float x, y;
  float s;
  float d;

  //constructor
  Dark(float _x, float _y, float _s) {
    s = _s;
    x = _x;
    y = _y;
    opac = 255;
  }

  //behaviour
  void show() {
    d = dist(x, y, myHero.loc.x, myHero.loc.y);
    opac = map(d, 0, 400, 0, 255);
    noStroke();
    fill(0, opac);
    square(x, y, s);
  }
}


class Text extends Message {

  String text;
  float x, y, f, q, g;
  color textC;
  int textS;

  Text(float _x, float _y, String t, color c, int s, float _f, float _g) {
    hp = 1;
    x = _x;
    y = _y;
    roomX = myHero.roomX;
    roomY = myHero.roomY;
    roomZ = myHero.roomZ;
    q = 255;
    f = _f;
    g = _g;
    text = t;
    textC = c;
    textS = s;
  }

  void show() {
    textFont(revamped);
    fill(textC, q);
    textSize(textS);
    text(text, x, y);
  }
  void act() {
    y = y - f;
    q = q - g;
    if (q <= 0) hp = 0;
  }
}
