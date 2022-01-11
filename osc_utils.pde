void sendMessage(int n){
  OscMessage noteMessage = new OscMessage("/note");
  noteMessage.add(n);
  oscP5.send(noteMessage, myRemoteLocation); 
}
