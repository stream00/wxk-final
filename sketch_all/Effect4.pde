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
