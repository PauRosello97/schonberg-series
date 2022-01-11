import oscP5.*;
import netP5.*;

OscP5 oscP5;
NetAddress myRemoteLocation;
ArrayList<Note> notes;
PVector mouse;
float previousHand;
float hand = 0;

void setup(){
  size(900, 900);
  oscP5 = new OscP5(this, 57121); // Processing works with 9999. No bigger!
  myRemoteLocation = new NetAddress("127.0.0.1", 9999);
  
  notes = new ArrayList<Note>();
  for(int i=0; i<12; i++){
    notes.add(new Note(i));  
  }
}

void update(){
  hand = (millis()/5000.)%1.;
  
  mouse = new PVector(mouseX-width/2, mouseY-height/2);
  for(Note note : notes){
    if(hand<previousHand) note.played = false;
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
  
  for(Note note : notes) note.draw();
}

void mousePressed(){
  for(Note note: notes) note.mousePressed(mouse);  
}

void mouseReleased(){
  for(Note note: notes) note.mouseReleased();  
}
