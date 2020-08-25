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
  
  PImage imgVideo = kinect.getVideoImage();
  PImage img = kinect.getDepthImage();

//  image(img, 0, 0);
//  image(imgVideo, 0, 0);
  
//skip is the radius of the ellipses

  float skip = 5;
  
  
  for (int x = 0; x < img.width; x+=skip){
    for (int y= 0; y < img.height; y+=skip){ 
      int index = x + y * img.width;
      float b = brightness(img.pixels[index]);
      color c = imgVideo.pixels[index];
//      map(c, 0, 255, 100, 150);
//      println(b);
//b range 145 - 170      
//radiusCorrection is used to       
      float radiusCorrection = (b - 150)/5;
//      println(radiusCorrection);
      float radius = skip + radiusCorrection;
      
      if ((b<180)&&(b>140)) {
        fill(c);
        stroke(c);
        ellipse(1.8 * x, 1.8 * y, radius/2, radius/2);
      } else if ((b<=150)&&(b>100)) {
        fill(150, 220, 220);
        stroke(150, 220, 220);
        ellipse(1.8*x,1.8*y,radius,radius); 
      } else if (b>=180){
        fill(215, 160, 130);
        stroke(215, 160, 130);
        ellipse(1.8*x,1.8*y,radius/3,radius/3);
      } 
    }
  }
}
