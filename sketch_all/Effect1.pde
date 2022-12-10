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
