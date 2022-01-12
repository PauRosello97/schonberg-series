void sendMessage(int n){
  OscMessage noteMessage = new OscMessage("/note");
  noteMessage.add(intervals[n]);
  oscP5.send(noteMessage, myRemoteLocation); 
}
