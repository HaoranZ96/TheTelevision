import org.openkinect.freenect.*;
import org.openkinect.processing.*;
ArrayList<Kinect> multiKinect;

int numDevices = 0;
int deviceIndex = 0;

void setup() {
  
  size(1024, 848);

  numDevices = Kinect.countDevices();
  multiKinect = new ArrayList<Kinect>();
  println(numDevices);
  for (int i  = numDevices; i >= 0; i--) {
    Kinect tmpKinect = new Kinect(this);
    tmpKinect.activateDevice(i);
    tmpKinect.initDepth();
    tmpKinect.initVideo();
    multiKinect.add(tmpKinect);
  }
}

void draw() {
  
  background(225);
  //println (multiKinect.size());

  Kinect tmpKinect = (Kinect)multiKinect.get(1);
  Kinect tmpKinectx = (Kinect)multiKinect.get(2);
  
  PImage imgVideo = tmpKinect.getVideoImage();
  PImage img = tmpKinect.getDepthImage();

  float skip = 5;
    
  for (int x = 0; x < img.width; x+=skip){
    for (int y= 0; y < img.height; y+=skip){ 
      int index = x + y * img.width;
      float b = brightness(img.pixels[index]);
      color c = imgVideo.pixels[index];
      //b range 145 - 170      
      float radiusCorrection = (b - 150)/5;
      //println(radiusCorrection);
      float radius = skip + radiusCorrection;
        
      if ((b<180)&&(b>150)) {
      fill(215, 160, 130);
      stroke(215, 160, 130);
      rect(1.8 * x, 1.8 * y, radius*2/3, radius*2/3);
      } else if ((b<=150)&&(b>100)) {
      fill(c);
      stroke(c);
      ellipse(1.8*x,1.8*y,radius,radius); 
      } else if (b>=180){
      fill(c);
      stroke(c);
      ellipse(1.8*x,1.8*y,radius/2,radius/2);
      } 
    }
  }

  PImage imgx = tmpKinectx.getDepthImage();
    
  for (int q = 0; q < imgx.width; q+=skip){
    for (int w= 0; w < imgx.height; w+=skip){ 
      int index = q + w * imgx.width;
      float b = brightness(imgx.pixels[index]);
      //color c = imgVideox.pixels[index];
      //b range 145 - 170      
      float radiusCorrection = (b - 150)/5;
      //println(radiusCorrection);
      float radius = skip + radiusCorrection;
        
      if ((b<180)&&(b>150)) {
      fill(150, 220, 220);
      stroke(150, 220, 220);
      rect(1.8 * q, 1.8 * w, radius*2/3, radius*2/3);
      }  
    }
  } 
}
