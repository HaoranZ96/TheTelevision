import processing.video.*;
import org.openkinect.processing.*;

Kinect kinect;

Movie video1;
Movie video2;
Movie video3;
Movie video4;

int v1 = (int) random(0,15);
int v2 = (int) random(0,15);
int v3 = (int) random(0,15);
int v4 = (int) random(0,15);

int l1 = 2000;
int l2 = 2000;
int l3 = 2000;
int l4 = 2000;

int g1 = 0;
int g2 = 0;
int g3 = 0;
int g4 = 0;

int p1 = 0;
int p2 = 0;
int p3 = 0;
int p4 = 0;

void setup() {
  size(1280,512);
  video1 = new Movie(this, v1 + ".mov");
  video2 = new Movie(this, v2 + ".mov");
  video3 = new Movie(this, v3 + ".mov");
  video4 = new Movie(this, v4 + ".mov");
  video1.loop();
  video2.loop();
  video3.loop();
  video4.loop();
  
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.initVideo();
}

void movieEvent(Movie video) {
  video.read();
}

void draw() {
  image(video1,0,0,384,256);
  image(video2,384,0,384,256);
  image(video3,0,256,384,256);
  image(video4,384,256,384,256);
  
  float t1 = video1.time();
  float t2 = video2.time();
  float t3 = video3.time();
  float t4 = video4.time();
  float d1 = video1.duration();
  float d2 = video2.duration();
  float d3 = video3.duration();
  float d4 = video4.duration();
  
  if (l1 > p1) {
    p1 = l1;
  }
  if (l2 > p2) {
    p2 = l2;
  }
  if (l3 > p3) {
    p3 = l3;
  }
  if (l4 > p4) {
    p4 = l4;
  }
  
  if ((t1 >= d1)&&(p1 <= 50000)) {
    video1.stop();
    v1 = (int) random(0,15);
    video1 = new Movie(this, v1 + ".mov");
    video1.loop();
  } else if (p1 > 50000) {
    video1.stop();
  }
  if ((t2 >= d2)&&(p2 <= 50000)) {
    video2.stop();
    v2 = (int) random(0,15);
    video2 = new Movie(this, v2 + ".mov");
    video2.loop();
  } else if (p2 > 50000) {
    video2.stop();
  }
  if ((t3 >= d3)&&(p3 <= 50000)) {
    video3.stop();
    v3 = (int) random(0,15);
    video3 = new Movie(this, v3 + ".mov");
    video3.loop();
  } else if (p3 > 50000) {
    video3.stop();
  }
  if ((t4 >= d4)&&(p4 <= 50000)) {
    video4.stop();
    v4 = (int) random(0,15);
    video4 = new Movie(this, v4 + ".mov");
    video4.loop();
  } else if (p4 > 50000) {
    video4.stop();
  }
  
  if ((mouseX<=1024)&&(mouseY<=256)) {
    g1++;
    g2 = 0;
    g3 = 0;
    g4 = 0;
  } else if ((mouseX>1024)&&(mouseY<=256)) {
    g2++;
    g1 = 0;
    g3 = 0;
    g4 = 0;
  } else if ((mouseX<=1024)&&(mouseY>256)) {
    g3++;
    g2 = 0;
    g1 = 0;
    g4 = 0;
  } else if ((mouseX>1024)&&(mouseY>256)) {
    g4++;
    g2 = 0;
    g3 = 0;
    g1 = 0;
  }
  
  if (g1 >= 50) {
    l1 = 2000;
  } if (g2 >= 50) {
    l2 = 2000;
  } if (g3 >= 50) {
    l3 = 2000;
  } if (g4 >= 50) {
    l4 = 2000;
  }
  
  if ((mouseX<=1024)&&(mouseY<=256)) {
    flicker(384,0,768,256,l2,p2);
    flicker(0,256,384,512,l3,p3);
    flicker(384,256,768,512,l4,p4);
    l2 = l2 + 100;
    l3 = l3 + 100;
    l4 = l4 + 100;
  }else if ((mouseX>1024)&&(mouseY<=256)) {
    flicker(0,0,384,256,l1,p1);
    flicker(0,256,384,512,l3,p3);
    flicker(384,256,768,512,l4,p4);
    l1 = l1 + 100;
    l3 = l3 + 100;
    l4 = l4 + 100;
  }else if ((mouseX<=1024)&&(mouseY>256)) {
    flicker(0,0,384,256,l1,p1);
    flicker(384,0,768,256,l2,p2);
    flicker(384,256,768,512,l4,p4);
    l2 = l2 + 100;
    l1 = l1 + 100;
    l4 = l4 + 100;
  }else if ((mouseX>1024)&&(mouseY>256)) {
    flicker(0,0,384,256,l1,p1);
    flicker(384,0,768,256,l2,p2);
    flicker(0,256,384,512,l3,p3);
    l2 = l2 + 100; 
    l3 = l3 + 100;
    l1 = l1 + 100;
  }
  
  PImage img = kinect.getDepthImage();
  float skip = 5;
  
  for (int x = 0; x < img.width; x+=skip){
    for (int y= 0; y < img.height; y+=skip){ 
      int index = x + y * img.width;
      float b = brightness(img.pixels[index]);
     
      float radiusCorrection = (b - 150)/5;
      float radius = skip + radiusCorrection;
      
      if (b>=180){
        fill(l1/200, l2/200, l3/200);
        stroke(l1/200, l2/200, l3/200);
        ellipse(x*1.5-128,y*1.5,radius/4,radius/4);
      } 
    }
  }
//  println (l1,l2,l3,l4);
//  saveFrame("output/film#####");
//  println(frameRate);
}


void flicker(int i, int j, int n, int m, int l, int p) {
  if (p <= 50000) {
    float s = random(0,0.2);
    for(int a = 0; a < l; a++) {
      float x = random(i,n);
      float y = random(j,m);
      float c = random (0,200);
      fill(c);
      stroke(c);
      rect(x,y,s,s);
    }
  }else {
    fill(0);
    stroke(0);
    rect(i,j,n-i,m-j);
  } 
}
