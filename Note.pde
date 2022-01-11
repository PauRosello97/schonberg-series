class Note{
  int n; 
  float t;
  PVector p;
  float r;
  boolean pressed = false;
  float ballSize;
  boolean played = false;
  
  Note(int _n){
    n = _n;
    t = random(1);
    r = width*.04*(n+1);
    p = new PVector(r*cos(TWO_PI*t-HALF_PI), r*sin(TWO_PI*t-HALF_PI));
  }
  
  void update(){
    r = width*.04*(n+1);
    float a = atan2(mouse.x, mouse.y);
    if(pressed){
      t = (PI-a)/TWO_PI;
      p = new PVector(r*cos(TWO_PI*t-HALF_PI), r*sin(TWO_PI*t-HALF_PI));
    }
    ballSize = pressed ? 20 : 10;
  }
  
  void draw(){
    update();
    float r = width*.04*(n+1);
    
    // Orbita
    noFill();
    strokeWeight(1);
    stroke(127);
    ellipse(0, 0, 2*r, 2*r);
    
    // Linia interior
    strokeWeight(3);
    stroke(255);
    line(0, 0, r*cos(TWO_PI*t-HALF_PI), r*sin(TWO_PI*t-HALF_PI));
    
    // Linia exterior
    stroke(127);
    strokeWeight(1);
    line(r*cos(TWO_PI*t-HALF_PI), r*sin(TWO_PI*t-HALF_PI), width*.48*cos(TWO_PI*t-HALF_PI), width*.48*sin(TWO_PI*t-HALF_PI));
    
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
    pressed = false;  
    played = false;
  }
  
  void play(float time){
    if(!played && time>t){
      played = true;  
      sendMessage(n);
    }
  }
}
