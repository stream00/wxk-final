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
