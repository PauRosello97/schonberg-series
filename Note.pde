class Note{
  int n; 
  float t;
  PVector p;
  float r;
  boolean pressed = false;
  float ballSize;
  
  Note(int _n){
    n = _n;
    t = 0;
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
  }
  
  void draw(){
    update();
    float r = width*.04*(n+1);
    noFill();
    ellipse(0, 0, 2*r, 2*r);
    fill(0);
    ballSize = pressed ? 20 : 10;
    ellipse(p.x, p.y, ballSize, ballSize);
  }
  
  void mousePressed(PVector mouse){
    if(mouse.dist(p)<ballSize) pressed = true;
  }
  
  void mouseReleased(){
    pressed = false;  
  }
}
