class Note{
  int n, previousN;
  float t;
  PVector p;
  float r;
  boolean pressed = false;
  float ballSize;
  boolean played = false;
  
  Note(int _n){
    n = _n;
    previousN = n;
    t = n/19.;
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
      n = newN;
      t = (PI-a)/TWO_PI;
    }
    ballSize = pressed ? 20 : 10;
  }
  
  void draw(){
    update();
    
    // Linia interior
    strokeWeight(3);
    stroke(255);
    line(0, 0, p.x, p.y);
    
    // Linia exterior
    stroke(127);
    strokeWeight(1);
    line(p.x, p.y, width*.475*cos(TWO_PI*t-HALF_PI), width*.475*sin(TWO_PI*t-HALF_PI));
    
    // Boleta
    stroke(255);
    fill(255);
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
    if(!played && time>=t){
      played = true;  
      sendMessage(n);
    }
  }
}
