import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
ArrayList<Note> notes;
PVector mouse;
float previousHand;
float hand = 0;
PVector center = new PVector(0,0);

void setup(){
  size(900, 900);
  oscP5 = new OscP5(this, 57121); // Processing works with 9999. No bigger!
  myRemoteLocation = new NetAddress("127.0.0.1", 9999);
  
  notes = new ArrayList<Note>();
  for(int i=0; i<19; i++){
    notes.add(new Note(i));  
  }
}

void update(){
  hand = (millis()/5000.)%1.;
  
  mouse = new PVector(mouseX-width/2, mouseY-height/2);
  for(Note note : notes){
    if(hand<=previousHand) note.played = false;
    note.play(hand);
  }
  
  previousHand = hand;
}

void draw(){
  update();
  background(0);
  translate(width/2, height/2);
  
  strokeWeight(3);
  stroke(116, 23, 150);
  line(0, 0, width*cos(TWO_PI*hand-HALF_PI), width*sin(TWO_PI*hand-HALF_PI));
  
  for(int i=0; i<19; i++){
    // Orbita
    noFill();
    strokeWeight(1);
    stroke(127);
    float r = width*.025*(i+1);
    ellipse(0, 0, 2*r, 2*r);
  }
  
  for(Note note : notes) note.draw();
}

void mousePressed(){
  for(Note note: notes) note.mousePressed(mouse);  
}

void mouseReleased(){
  for(int i=0; i<notes.size(); i++){
    Note note = notes.get(i);
    if(note.pressed){
      for(int j=0; j<notes.size(); j++){
        Note otherNote = notes.get(j);
        if(otherNote.n == note.n){
          otherNote.n = note.previousN;
          otherNote.update();
        }
      }
    }
    note.mouseReleased();  
  }
}
