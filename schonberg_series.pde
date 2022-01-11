ArrayList<Note> notes;
PVector mouse;

void setup(){
  size(900, 900);
  
  notes = new ArrayList<Note>();
  for(int i=0; i<12; i++){
    notes.add(new Note(i));  
  }
}

void update(){
  mouse = new PVector(mouseX-width/2, mouseY-height/2);
}

void draw(){
  update();
  background(255);
  translate(width/2, height/2);
  
  for(Note note : notes) note.draw();
}

void mousePressed(){
  for(Note note: notes) note.mousePressed(mouse);  
}

void mouseReleased(){
  for(Note note: notes) note.mouseReleased();  
}
