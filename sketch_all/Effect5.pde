float radd, gadd, badd, bnadd;
float k5;
class Effect5 {

  PImage img;
  xq[] xqs=new xq[640000];
  Effect5() {  
    img=loadImage("5.jpg");
    img.resize(width, height);
    for (int i=0; i<xqs.length; i+=5) {
      float r, g, b, bn;
      color c=img.pixels[i];
      r=red(c);
      g=green(c);
      b=blue(c);
      bn=map(brightness(c), 0, 255, -1, 1);
      xqs[i]=new xq(new PVector (i%800, i/800), random(0.1, 10), r, g, b, bn);
    }
  }
  void run() {    
    noStroke();
    fill(0, 50);
    rect(0, 0, width, height);
    for (int i=0; i<xqs.length; i+=20) {
      xqs[i].update();
      xqs[i].display();
      xqs[i].check();
    }  
    bar5.draw();
  }
}
void UI5() {
  int canvasLeftCornerX = 30;
  int canvasLeftCornerY = 60;

  bar5 = new ControlP5(this, createFont("微软雅黑", 14));
  int barSize = 100;
  int barHeight = 10;
  int barInterval = barHeight + 10;


  bar5.addSlider("radd", -0.05, 0.05, 0, canvasLeftCornerX, canvasLeftCornerY, barSize, barHeight).setLabel("R的变化");
  bar5.addSlider("gadd", -0.05, 0.05, 0, canvasLeftCornerX, canvasLeftCornerY+barInterval, barSize, barHeight).setLabel("G的变化");
  bar5.addSlider("badd", -0.05, 0.05, 0, canvasLeftCornerX, canvasLeftCornerY+barInterval*3, barSize, barHeight).setLabel("B的变化");
  bar5.addSlider("k5", 0, 2, 0, canvasLeftCornerX, canvasLeftCornerY+barInterval*4, barSize, barHeight).setLabel("半径");

  bar5.setAutoDraw(false);
}

class xq {
  float a=0;
  PVector loc;
  int c;
  float vx=0, vy=0, r;
  float B1, G1, R1, bn1;

  xq(PVector location, float r, float R, float G, float B, float bn) {
    loc=location;
    this.r=r;
    R1=R;
    G1=G;
    B1=B;
    bn1=bn;
  }

  void update() {
    bn1+=0.02*noise(0.001*(loc.x+R1*radd+B1*badd-G1*gadd), 0.005*(loc.y+R1*radd+B1*badd-G1*gadd))  ;
    vx=2*sin(bn1)+radd+B1*badd+G1*gadd;
    vy=2*cos(bn1)+radd+B1*badd+G1*gadd;
    loc.x+=vx;
    loc.y+=vy;
  }

  void display() {
    noStroke();
    //blendMode(MULTIPLY);
    //colorMode(HSB,360,100,100);
    fill(R1, G1, B1);
    ellipse(loc.x, loc.y, r*k5, r*k5);
  }

  void check() {
    if (loc.x<0) {
      loc.x=width;
    }
    if (loc.x>width) {
      loc.x=0;
    }
    if (loc.y<0) {
      loc.y=height;
    }
    if (loc.y>height) {
      loc.y=0;
    }
  }
}
