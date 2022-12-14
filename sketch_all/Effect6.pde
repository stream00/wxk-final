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
