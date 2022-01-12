import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
PVector c;
float smallArc = PI/6;
float bigArc = PI/3;
float bigRadius, smallRadius, innerRadius;

void setup(){
  size(900, 900);
  oscP5 = new OscP5(this, 57121); // Processing works with 9999. No bigger!
  myRemoteLocation = new NetAddress("127.0.0.1", 9999);
  
  c = new PVector(width/2, height/2);  
  
  bigRadius = width*.4;
  smallRadius = width*.3;
  innerRadius = smallRadius/2;
    
  background(255);
  for(int i=12; i>0; i--){
    fill(colors[i+5][0], colors[i+5][1], colors[i+5][2]);
    arc(c.x, c.y, bigRadius*2, bigRadius*2, PI+smallArc*(i+1.5), PI+smallArc*(i+2.5));
  }
  
  for(int i=6; i>0; i--){
    fill(colors[i-1][0], colors[i-1][1], colors[i-1][2]);
    arc(c.x, c.y, smallRadius*2, smallRadius*2, PI+bigArc*(i), PI+bigArc*(i+1));
  }
  
  fill(255);
  ellipse(c.x, c.y, smallRadius, smallRadius);
  
}

void draw(){ }

void mousePressed(){
  PVector mouse = new PVector(mouseX, mouseY);
  float angle = PI-atan2(mouseX-c.x, mouseY-c.y);
  float dist = mouse.dist(c);
  if(dist<smallRadius && dist>innerRadius){
    int n = 1+int((.5+(6*(angle)/TWO_PI))%6);
    println("small: " + intervals[n]);  
    sendMessage(n);
  }else if(dist<bigRadius && dist>innerRadius){
    int n = 7+int((.5+(12*(angle)/TWO_PI))%12);
    sendMessage(n);
    println("big: " + intervals[n]);  
  }else{
    sendMessage(0);
  }
}

void sendMessage(int n){
  OscMessage noteMessage = new OscMessage("/note");
  noteMessage.add(intervals[n]);
  oscP5.send(noteMessage, myRemoteLocation); 
}
