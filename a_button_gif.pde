class Button {

  //instance variables
  float x, y, w, h, t, tS;
  String text;
  color normal, highlight, normalT, highlightT;
  boolean click;

  //constructor
  Button(String _tt, float _x, float _y, float _w, float _h, float _tS) {
    text = _tt;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    tS = _tS;
    t = 0;
    normal = lightGrey;
    highlight = darkGrey;
    normalT = black;
    highlightT = white;
    click = false;
  }
  Button(String _tt, float _x, float _y, float _w, float _h, float _t, color _n, color _hh, color _nT, color _hhT) {
    text = _tt;
    x = _x;
    y = _y;
    w = _w;
    h = _h;
    tS = w/4;
    t = _t;
    normal = _n;
    highlight = _hh;
    normalT = _nT;
    highlightT = _hhT;
    click = false;
  }

  //behaviour
  void show() {
    rectMode(CENTER);
    textAlign(CENTER, CENTER);
    noStroke();
    
    if (mouseReleased && mouseX > x-(w/2) && mouseX < x+(w/2) && mouseY > y-(h/2) && mouseY < y+(h/2)) {
      click = true;
    } else {
      click = false;
    }
    
    if (mouseX > x-(w/2) && mouseX < x+(w/2) && mouseY > y-(h/2) && mouseY < y+(h/2)) {
      fill(highlight);
    } else {
     fill(normal); 
    }
    strokeWeight(2);
    rect(x, y, w, h, t);
    
    if (mouseX > x-(w/2) && mouseX < x+(w/2) && mouseY > y-(h/2) && mouseY < y+(h/2)) {
      fill(highlightT);
    } else {
      fill(normalT);
    }
    textSize(tS);
    text(text, x, y-(h/25));
  }
}


class AnimatedGIF {

  //instance variables
  PImage[] pics;
  int frames;
  int current;
  float x, y, w, h;

  //constructor
  AnimatedGIF(int nf, String pre, String suf) {
    frames = nf;
    pics = new PImage[frames];
    x = width/2;
    y = height/2;
    w = width;
    h = height;

    int i = 0;
    while (i < frames) {
      pics[i] = loadImage(pre+i+suf);
      i = i + 1;
    }
    current = 0;
  }
  AnimatedGIF(int nf, String pre, String suf, float _x, float _y, float _w, float _h) {
    frames = nf;
    pics = new PImage[frames];
    x = _x;
    y = _y;
    w = _w;
    h = _h;

    int i = 0;
    while (i < frames) {
      pics[i] = loadImage(pre+i+suf);
      i = i + 1;
    }
    current = 0;
  }

  //behaviour
  void show() {
    imageMode(CENTER);
    image(pics[current], x, y, w, h);
    current = current + 1;
    if (current == frames) current = 0;
  }
}
