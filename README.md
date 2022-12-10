# wxk-final
全代码在sketch——all中
```java


按钮

import controlP5.*;
ControlP5 bar1;
ControlP5 bar4;
ControlP5 bar5;
ControlP5 bar6;
ControlP5 bar7;
Effect1 e1;
Effect2 e2;
Effect3 e3;
Effect4 e4;
Effect5 e5;
Effect6 e6;
Effect7 e7;
int effect=0;
String effText[]={"像素处理", "浮现(鼠标)", "水波", "流动粒子", "粒子化", "涌现", "分形"};  
Button buttons[]=new Button[7];

boolean clearState=false;
class SecondApplet extends PApplet {
  PFont font;  
  public void settings() {
    size(200, 800);
  }
  void setup() {  
    for (int i=0; i<7; i++) {
      buttons[i]=new Button(100, map(i, -1, 7, 0, height));
    }
    font =createFont("微软雅黑", 30);
  }
  void draw() {
    background(255);
    for (int i=0; i<7; i++) {
      push();
      rectMode(CENTER);
      textAlign(CENTER, CENTER);
      textFont(font);
      if (effect==i) {
        fill(buttons[i].c2);
      } else {
        fill(buttons[i].c1);
      }
      noStroke();
      rect(buttons[i].x, buttons[i].y, buttons[i].w, buttons[i].h, 10);   
      if (mouseX>buttons[i].x-buttons[i].w/2&&mouseX<buttons[i].x+buttons[i].w/2&&mouseY>buttons[i].y-buttons[i].h/2&&mouseY<buttons[i].y+buttons[i].h/2) {
        fill(255, 80);
        rect(buttons[i].x, buttons[i].y, buttons[i].w, buttons[i].h, 10);
      }     
      fill(0);
      text(effText[i], buttons[i].x, buttons[i].y-5);
      pop();
    }
  }
  void mousePressed() {
    for (int i=0; i<7; i++) {
      if (mouseX>buttons[i].x-buttons[i].w/2&&mouseX<buttons[i].x+buttons[i].w/2&&mouseY>buttons[i].y-buttons[i].h/2&&mouseY<buttons[i].y+buttons[i].h/2) {
        effect=i; 
        clearBackground();
        clearState=true;
      }
    }
  }
}
void settings() {
  size(800, 800);
}
void setup() {
  String[] args = {"second"};
  SecondApplet sa = new SecondApplet();
  PApplet.runSketch(args, sa);

  bar1 = new ControlP5(this, createFont("微软雅黑", 14));
  bar4 = new ControlP5(this, createFont("微软雅黑", 14));
  e1=new Effect1();
  e2=new Effect2();
  e3=new Effect3(); 
  e4=new Effect4();
  e5=new Effect5();
  e6=new Effect6();
  e7=new Effect7();
  UI4();
  UI5();
  UI6();
  UI7();
}

void draw() {
  if (clearState) {  
    background(random(255), random(255), random(255));
    clearState=false;
  }

  if (effect==0) {
    e1.run();
  } else if (effect==1) {
    e2.run();
  } else if (effect==2) {
    e3.run();
  } else if (effect==3) {
    e4.run();
  } else if (effect==4) {
    e5.run();
  } else if (effect==5) {
    e6.run();
  } else if (effect==6) {
    e7.run();
  }
}
void clearBackground() {
  clear();  
  background(0);
}



class Button {
  color c1, c2;
  float w=160, h=50;
  float x, y;
  Button(float x, float y) {
    this.x=x;
    this.y=y;
    c1=color(135, 154, 193);
    c2=color(70, 124, 232);
  }

}


//效果1（像素处理）

int jj=10;
int  ry=25;
float rb, gb, bb, bbn, k1;
int x, y;
class Effect1 {

  PImage img;

  float r[]=new float [640000];
  float g[]=new float [640000];
  float b[]=new float [640000];
  float bn[]=new float [640000];  
  int canvasLeftCornerX = 30;
  int canvasLeftCornerY = 60;
  Effect1() {  
    img=loadImage("1.jpg");
    img.resize(width, height);
    img.loadPixels();
    for (int i=0; i<640000; i+=10) {
      color c=img.pixels[i];
      r[i]=red(c);
      g[i]=green(c);
      b[i]=blue(c);
      bn[i]=brightness(c);
    }
    UI() ;
  }
  void run() {  
    rect(0, 0, width, height);
    for (int i=0; i<800; i+=jj) {
      for (int y=0; y<800; y+=jj) {
        r[i*800+y]+=rb;
        g[i*800+y]+=gb;
        b[i*800+y]+=bb;
        bn[i*800+y]+=bbn;
        fill(r[i*800+y], g[i*800+y], b[i*800+y], bn[i*800+y]);
        noStroke();
        if (k1>0) { 
          rect(y, i, ry, ry);
        } else {
          ellipse(y, i, ry, ry);
        }
      }
    } 
    bar1.draw();
  }
  void UI() {
    int barSize = 100;
    int barHeight = 10;
    int barInterval = barHeight + 10;
    bar1.addSlider("jj", 1, 10, 10, canvasLeftCornerX, canvasLeftCornerY, barSize, barHeight).setLabel("间距");
    bar1.addSlider("ry", 1, 50, 25, canvasLeftCornerX, canvasLeftCornerY+barInterval, barSize, barHeight).setLabel("半径");
    bar1.addSlider("rb", -1, 1, 0, canvasLeftCornerX, canvasLeftCornerY+barInterval*3, barSize, barHeight).setLabel("颜色R");
    bar1.addSlider("gb", -1, 1, 0, canvasLeftCornerX, canvasLeftCornerY+barInterval*4, barSize, barHeight).setLabel("颜色G");
    bar1.addSlider("bb", -1, +1, 0, canvasLeftCornerX, canvasLeftCornerY+barInterval*5, barSize, barHeight).setLabel("颜色B");
    bar1.addSlider("bbn", -10, 10, 0, canvasLeftCornerX, canvasLeftCornerY+barInterval*6, barSize, barHeight).setLabel("明度");
    bar1.addSlider("k1", -1, 1, 0, canvasLeftCornerX, canvasLeftCornerY+barInterval*7, barSize, barHeight).setLabel("像素形状");
    bar1.setAutoDraw(false);
  }
}

//效果2——浮现（鼠标）
class Effect2 {
  PImage img;
  Effect2() {  
    img=loadImage("2.jpg");
    img.resize(width, height);
  }
  void run() { 
    noStroke();
    fill(255);
    rect(0, 0, width, height);
    float startX=mouseX;
    int step=4;
    for (int i=0; i<width; i+=step) {
      for (int j=0; j<height; j+=step) {
        int n=i+j*width;
        color c=img.pixels[n];
        float xoff=0;
        float yoff=0;
        if (i>startX) {
          float scl=map(i, startX, startX+width, 0, 10000);
          xoff=abs(randomGaussian())*scl;
          yoff=random(-scl*0.5, scl*0.5);
        }
        float r=random(0, 10);
        noStroke();
        fill(c);
        ellipse(i+xoff, j+yoff, r, r);
      }
    }
  }
}

//效果3——水波
class Effect3 {
  PImage base;
  float[][] pt1;
  float[][] pt2;
  float refraction = 0.9; //减缓系数
  Effect3() {  
    base = loadImage("3.jpg");
    base.resize(width, height);
    base.loadPixels();
    pt1 = new float[width][height];
    pt2 = new float[width][height];
    for (int y=0; y<height; y++) {
      for (int x=0; x<width; x++) {
        pt1[x][y] = 0;
        pt2[x][y] = 0;
      }
    }
  }
  void run() {  
    if (mousePressed) {
      pt2[mouseX][mouseY] += 800;
    }
    if (frameCount%10==0) {
      pt2[int(random(width))][int(random(height))] += int(random(400, 18000));
    }
    for (int y=1; y<height-1; y++) {
      for (int x=1; x<width-1; x++) {
        float avg = (pt1[x-1][y] + pt1[x+1][y] + pt1[x][y-1] + pt1[x][y+1] ) / 4;
        pt1[x][y] = avg * 2 - pt1[x][y];
        pt1[x][y] *= 0.98;
      }
    }


    loadPixels();
    float xoffset, yoffset;
    for (int y=1; y<height-1; y++) {
      for (int x=1; x<width-1; x++) {
        xoffset = (pt1[x-1][y] + pt1[x+1][y]) * refraction;
        yoffset = (pt1[x][y-1] + pt1[x][y+1]) * refraction;

        if (x+xoffset<0) xoffset = -x; 
        if (x+xoffset>width-1) xoffset = width-1-x;
        if (y+yoffset<0) yoffset = -y;
        if (y+yoffset>height-1) yoffset = height-1-y;

        pixels[y*(width) + x] = base.pixels[int(x+xoffset)+int(y+yoffset)*width];
      }
    }

    updatePixels();

    float[][] temp = pt1;
    pt1 = pt2;
    pt2 = temp;
  }
}

//效果4——粒子画图
void UI4() {
  int canvasLeftCornerX = 30;
  int canvasLeftCornerY = 60;
  bar4 = new ControlP5(this, createFont("微软雅黑", 14));
  int barSize = 100;
  int barHeight = 10;
  int barInterval = barHeight + 10;
  bar4.addSlider("ls", 0.2, 10, 1, canvasLeftCornerX, canvasLeftCornerY, barSize, barHeight).setLabel("寿命");
  bar4.addSlider("n", 0, 2000, 1000, canvasLeftCornerX, canvasLeftCornerY+barInterval, barSize, barHeight).setLabel("下一次圆圈数量");
  bar4.addSlider("bhl", 0, 5, 0.1, canvasLeftCornerX, canvasLeftCornerY+barInterval*3, barSize, barHeight).setLabel("半径变化");
  bar4.addSlider("noisePower", 0, 1, 0.01, canvasLeftCornerX, canvasLeftCornerY+barInterval*4, barSize, barHeight).setLabel("变化曲度");
  bar4.setAutoDraw(false);
}

class Effect4 {
  int hd=20;

  float bhl=0.1;
  ArrayList<Particle> particles;
  ArrayList<PImage> img;
  int n=1000, s=30, maxR;
  int indexImg = 0;

  Effect4() {  
    background(#B4F4F7);
    maxR = height/2 - height/hd;
    particles = new ArrayList<Particle>();
    img = new ArrayList<PImage>();
    img.add(loadImage("2.jpg"));
  }
  void run() {    
    push();

    translate(width/2, height/2);
    noStroke();

    if (s > 1) {
      if (particles.size() != 0) {
        for (int i = 0; i < particles.size(); i++) {
          Particle p = particles.get(i);
          p.show();
          p.move();

          if (p.isDead()) particles.remove(i);
        }
      } else {
        s -=bhl;
        initParticles();
      }
    }
    pop();    
    bar4.draw();
  }
  void initParticles() {
    for (int i = 0; i < n; i++) {
      particles.add(new Particle(maxR, s));

      Particle p = particles.get(i);
      int x = int(map(p.pos.x, -maxR, maxR, 0, img.get(indexImg).width));
      int y = int(map(p.pos.y, -maxR, maxR, 0, img.get(indexImg).height));
      p.c = img.get(indexImg).get(x, y);
    }
  }
}





class Particle {
  PVector pos;
  PVector vel;
  int maxR;
  int s;
  int life;
  color c;
  float noisePower = 0.01;
  float ls=2;
  Particle(int maxR_, int s_) {
    s = s_;
    maxR = maxR_;
    life = 100;
    init();
  }

  void init() {
    pos = PVector.random2D();
    pos.normalize();
    pos.mult(random(2, maxR));
    vel = new PVector();
  }

  void show() {
    fill(c);
    ellipse(pos.x, pos.y, s, s);
    life -=ls;
  }

  void move() {
    float angle = noise(pos.x * noisePower, pos.y * noisePower) * TAU;
    vel.set(cos(angle), sin(angle));
    vel.mult(0.3);
    pos.add(vel);
  }

  boolean isDead() {
    float d = dist(pos.x, pos.y, 0, 0);
    if (d > maxR || life < 0) return true;
    else return false;
  }
}


//效果5——粒子化
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

//效果6——涌现
float R[]=new float [64000000];
float g[]=new float [64000000];
float b[]=new float [64000000];
float bn[]=new float [6400000];
FlowField flowfield;
ArrayList<Vehicle> vehicles;
int fn=10, in=800;
float bs=1, bh=1, jl=10, sd=1, rw=1, max=1;
class Effect6 {
  PImage img;
  Effect6() {  
    flowfield = new FlowField(fn);
    vehicles = new ArrayList<Vehicle>();  
    for (int i = 0; i < in; i++) {
      vehicles.add(new Vehicle(new PVector(width/2, height/2), random(0.5, 5), random(0.1, 0.5), random(255), random(4)));
    }  
    img=loadImage("6.jpg");
    img.resize(width, height);
    img.loadPixels();
    for (int i=0; i<640000; i+=1) {

      color c=img.pixels[i];
      R[i]=red(c);
      g[i]=green(c);
      b[i]=blue(c);
      bn[i]=brightness(c);
    }
  }
  void run() { 
    flowfield.update();

    for (Vehicle v : vehicles) {
      v.follow(flowfield);
      v.separate(vehicles);
      v.run();
    }
    bar6.draw();
  }
}

void UI6() {
  bar6 = new ControlP5(this, createFont("微软雅黑", 14));
  int canvasLeftCornerX = 30;
  int canvasLeftCornerY = 60;
  int bar6Size = 200;
  int bar6Height = 20;
  int bar6Interval = bar6Height + 10;
  bar6.addSlider("max", 1, 20, 1, canvasLeftCornerX, canvasLeftCornerY, bar6Size, bar6Height).setLabel("速度");
  bar6.addSlider("sd", 1, 10, 1, canvasLeftCornerX, canvasLeftCornerY+bar6Interval, bar6Size, bar6Height).setLabel("凝固度");
  bar6.addSlider("jl", 1, 150, 10, canvasLeftCornerX, canvasLeftCornerY+bar6Interval*2, bar6Size, bar6Height).setLabel("粒子距离");
  bar6.addSlider("rw", 1, 10, 1, canvasLeftCornerX, canvasLeftCornerY+bar6Interval*3, bar6Size, bar6Height).setLabel("半径");
  bar6.addSlider("fn", 0, 50, 10, canvasLeftCornerX, canvasLeftCornerY+bar6Interval*4, bar6Size, bar6Height).setLabel("场域变化");
  bar6.addSlider("bs", 0, 10, 1, canvasLeftCornerX, canvasLeftCornerY+bar6Interval*5, bar6Size, bar6Height).setLabel("混乱度");
  bar6.addSlider("bh", 0, 200, 1, canvasLeftCornerX, canvasLeftCornerY+bar6Interval*6, bar6Size, bar6Height).setLabel("位置变化");
  bar6.setAutoDraw(false);
}
class FlowField {

  PVector[][] field;
  int cols, rows; 
  int resolution; 
  float zoff = 0.0; 

  FlowField(int r) {
    resolution = r;
    cols = 720/resolution;
    rows = 720/resolution;
    field = new PVector[cols][rows];
    update();
  }

  void update() {
    float xoff = 0;
    for (int i = 0; i < cols; i++) {
      float yoff = 0;
      for (int j = 0; j < rows; j++) {
        float x = bh*(i*resolution-width/2);
        float y = bh*(j*resolution-height/2);
        float r = sqrt((x*x)+ (y*y))*bs;
        PVector v = new PVector(sin(r-zoff), cos(r-zoff));
        v.normalize();
        field[i][j] = v; 
        yoff += 0.1*sd;
      }
      xoff += 0.1*sd;
    }
    zoff += 0.1*sd;
  }

  PVector lookup(PVector lookup) {
    int column = int(constrain(lookup.x/resolution, 0, cols-1));
    int row = int(constrain(lookup.y/resolution, 0, rows-1));
    return field[column][row].get();
  }
}
class Vehicle {

  PVector location, velocity, acceleration;
  float maxforce, maxspeed;
  float r, c;

  Vehicle(PVector l, float ms, float mf, float c_, float r_) {
    location = l.get();
    acceleration = new PVector(0, 0);
    velocity = new PVector(0, 0);    
    maxforce = mf;
    maxspeed = ms;
    r = r_;    
    c = c_;
  }

  void run() {
    update();
    display();
  }

  void follow(FlowField flow) {
    PVector desired = flow.lookup(location);
    desired.mult(maxspeed*max);
    PVector steer = PVector.sub(desired, velocity);
    steer.limit(maxforce);  
    applyForce(steer);
  }

  void applyForce(PVector force) {
    acceleration.add(force);
  }

  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    location.add(velocity);
    acceleration.mult(0);
  }

  void separate (ArrayList<Vehicle> vehicles) {
    float desiredseparation = r*2;
    PVector sum = new PVector();
    int count = 0;
    for (Vehicle other : vehicles) {
      float d = PVector.dist(location, other.location);  
      if (d < jl) { 
        stroke(255, jl-d);
        int x=abs((int)location.x);
        int y=abs((int)location.y);
        stroke(R[y*800+x], g[y*800+x], b[y*800+x]);

        line(location.x, location.y, other.location.x, other.location.y);
      }
      if ((d > 0) && (d < desiredseparation)) {
        PVector diff = PVector.sub(location, other.location);
        diff.normalize();
        diff.div(d);        
        sum.add(diff);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }

  void display() {
    fill(0);
    noStroke();
    pushMatrix();
    translate(location.x, location.y);
    int x=abs((int)location.x);
    int y=abs((int)location.y);
    fill(R[y*800+x], g[y*800+x], b[y*800+x]);
    ellipse(0, 0, r*rw, r*rw);
    popMatrix();
  }
}


//效果7-分形
int sz7=2, bh7=2, bj7=3, ds7=5, R7=255, G7=255, B7=255;
ArrayList<KochLine> lines;
float r = 180;
float r7[]=new float [64000000];
float g7[]=new float [64000000];
float b7[]=new float [64000000];
void generate() {
  ArrayList next = new ArrayList<KochLine>();
  for (KochLine l : lines) {
    PVector a = l.kochA();
    PVector b = l.kochB();
    PVector c = l.kochC();
    PVector d = l.kochD();
    PVector e = l.kochE();

    next.add(new KochLine(a, b, r));
    next.add(new KochLine(b, c, r));
    next.add(new KochLine(c, d, r));
    next.add(new KochLine(d, e, r));
  }
  lines = next;
}

class Effect7 {
  PImage img;
  Effect7() {  
    img=loadImage("7.jpg");
    img.resize(width, height);
    img.loadPixels();
    for (int i=0; i<width*height; i+=1) {
      color c=img.pixels[i];
      r7[i]=red(c);
      g7[i]=green(c);
      b7[i]=blue(c);
    }
  }
  void run() { 
    lines = new ArrayList<KochLine>();
    PVector a = new PVector(100, 160);
    PVector b = new PVector(width-100, 160);
    PVector c = new PVector(width/2, width*cos(radians(30)));

    lines.add(new KochLine(a, b, r));
    lines.add(new KochLine(b, c, r));
    lines.add(new KochLine(c, a, r));

    for (int i = 0; i <ds7; i++) {    
      generate();
    }  
    for (KochLine l : lines) {
      l.display();
    }
    r++;
    bar7.draw();
  }
}
class KochLine {
  PVector start, end;
  float r;

  KochLine(PVector a, PVector b, float r_) {
    start = a.get();
    end = b.get();
    r = r_;
  }

  void display() {
    stroke(r7[abs((int)start.y*width+(int)start.x)], g7[abs((int)start.y*width+(int)start.x)], b7[abs((int)start.y*width+(int)start.x)]);
    line(start.x, start.y, end.x, end.y);
  }

  PVector kochA() {
    return start.get();
  }

  PVector kochB() {
    PVector v = PVector.sub(end, start);
    v.div(bj7);
    v.add(start);
    return v;
  }

  PVector kochC() {
    PVector a = start.get();

    PVector v = PVector.sub(end, start);
    v.div(bh7);
    a.add(v);

    v.rotate(-radians(r));
    a.add(v);

    return a;
  }

  PVector kochD() {
    PVector v = PVector.sub(end, start);
    v.mult(sz7/3.0);
    v.add(start);
    return v;
  }

  PVector kochE() {
    return end.get();
  }
}
void UI7() {
  int canvasLeftCornerX = 30;
  int canvasLeftCornerY = 60;

  bar7 = new ControlP5(this, createFont("微软雅黑", 14));
  int barSize = 100;
  int barHeight = 10;
  int barInterval = barHeight + 10;
  bar7.addSlider("ds7", 1, 7, 5, canvasLeftCornerX, canvasLeftCornerY, barSize, barHeight).setLabel("代数");
  bar7.addSlider("bj7", 1, 50, 3, canvasLeftCornerX, canvasLeftCornerY+barInterval, barSize, barHeight).setLabel("间隔边距");
  bar7.addSlider("bh7", 1, 10, 2, canvasLeftCornerX, canvasLeftCornerY+barInterval*2, barSize, barHeight).setLabel("变化程度");
  bar7.addSlider("sz7", 1, 7, 2, canvasLeftCornerX, canvasLeftCornerY+barInterval*3, barSize, barHeight).setLabel("线的数量");
  bar7.setAutoDraw(false);
}




```
