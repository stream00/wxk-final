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
