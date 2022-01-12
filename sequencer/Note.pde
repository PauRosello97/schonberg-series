class Note{
  int n, previousN;
  float t;
  PVector p;
  float r;
  boolean pressed = false;
  boolean played = false;
  float ballSize;
  
  Note(int _n){
    n = _n;
    previousN = n;
    t = random(1);
    t = round(32.*t)/32.;
    r = width*.025*(n+1);
    p = new PVector(r*cos(TWO_PI*t-HALF_PI), r*sin(TWO_PI*t-HALF_PI));
  }
  
  void update(){
    r = width*.025*(n+1);
    p = new PVector(r*cos(TWO_PI*t-HALF_PI), r*sin(TWO_PI*t-HALF_PI));
    if(pressed){
      float a = atan2(mouse.x, mouse.y);
      float d = mouse.dist(center);
      int newN = int((d/(0.025*width))-.5);
      n = newN > 18 ? 18 : newN;
      t = (PI-a)/TWO_PI;
    }
    ballSize = pressed ? 20 : 10;
  }
  
  void draw(){
    update();
    
    // Linia interior
    strokeWeight(positive ? 3 : 1);
    stroke(positive ? 255 : 127);
    line(0, 0, p.x, p.y);
    
    // Linia exterior
    stroke(positive ? 127 : 255);
    strokeWeight(positive ? 1 : 3);
    line(p.x, p.y, width*.475*cos(TWO_PI*t-HALF_PI), width*.475*sin(TWO_PI*t-HALF_PI));
    
    // Boleta
    stroke(255);
    fill(255);
    strokeWeight(3);
    if(played) fill(255, 0, 0);
    ellipse(p.x, p.y, ballSize, ballSize);
    
  }
  
  void mousePressed(PVector mouse){
    if(mouse.dist(p)<ballSize) pressed = true;
  }
  
  void mouseReleased(){
    t = round(32.*t)/32.;
    pressed = false;  
    played = false;
    previousN = n;
  }
  
  void play(float time){
    if(!played && (((clockwise && time>=t) || (!clockwise && (1+time)<=t)))){
      played = true;  
      sendMessage(positive ? n : 18-n);
    }
  }
}
