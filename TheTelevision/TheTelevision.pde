import processing.video.*;
import org.openkinect.processing.*;

Kinect kinect;
Movie video;

int v = (int) random(0,15);
int f = 1000;
int count = 0;
int dense = 0;

void setup() {
  fullScreen();
  video = new Movie(this, v + ".mov");
  video.loop();
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.initVideo();
}

void movieEvent(Movie video) {
  video.read();
}

void draw() {
  image(video,0,0,width,height);
  
  float t = video.time();
  float d = video.duration();

  if (t >= d) {
    video.stop();
    v = (int) random(0,15);
    video = new Movie(this, v + ".mov");
    video.loop();
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
        fill(dense/200, dense/200, dense/200);
        stroke(dense/200, dense/200, dense/200);
        ellipse(x*1.5-128,y*1.5,radius/4,radius/4);
        count++;
      } 
    }
  }
  
  boolean audience = audienceDetect(count);
  if (audience) {
    dense+=10;
  } else {
    if(dense>50){
      dense-=10;
    }
  }
  
  flicker(dense);
}

void flicker (int d) {
  float w = random(0,0.2);
  float h = random(0,0.2);
  for(int i = 0; i < d; i++) {
    float x = random(0, width);
    float y = random(0, height);
    float colour = random(0,200);
    fill(colour);
    stroke(colour);
    rect(x,y,w,h);
  }
}

boolean audienceDetect (int c) {
  boolean i = false;
  if (c > 100) {
    i = true;
  }
  count = 0;
  return i; 
}
