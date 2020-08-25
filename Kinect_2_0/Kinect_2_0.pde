import org.openkinect.processing.*;

Kinect kinect;

void setup() {

  size(1024, 848);
  kinect = new Kinect(this);
  kinect.initDepth();
  kinect.initVideo();

}

void draw() {

  background(255);
  PImage img = kinect.getDepthImage();
  
//skip is the radius of the ellipses

  float skip = 5;
  for (int x = 0; x < img.width; x+=skip){
    for (int y= 0; y < img.height; y+=skip){ 
      int index = x + y * img.width;
      float b = brightness(img.pixels[index]);
//      println(b);
//b range 145 - 170      
//radiusCorrection is used to       
      float radiusCorrection = (b - 150)/5;
      println(radiusCorrection);
      float radius = skip + radiusCorrection;
      
      if ((b<200)&&(b>150)) {
        fill(150, 220, 220);
        stroke(150, 220, 220);
        ellipse(1.8*x,1.8*y,radius/3,radius/3);
      } else if ((b<=150)&&(b>100)) {
        fill(215, 160, 130);
        stroke(215, 160, 130);
        ellipse(1.8*x,1.8*y,radius,radius); 
      } else if (b>=200){
        fill(215, 160, 130);
        stroke(215, 160, 130);
        ellipse(1.8*x,1.8*y,radius/3,radius/3);
      }
    }
  }
}
