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
