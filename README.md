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













```
