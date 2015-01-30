import processing.serial.*;

Serial myPort;
int circleSize;
int lf = 10;  // ASCII linefeed char

void setup() {
  size(200, 200);
  background(255);
  
  // In case you want to see the list of available ports
  println(Serial.list());
  
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil(lf);
}

void draw() {
  
  fill(255, 50);
  rect(0, 0, 200, 200);
  stroke(0);
  noFill();
  ellipse(100, 100, circleSize, circleSize);
  
  if (mousePressed == true) {
    myPort.write('1');
  } else {
    myPort.write("0");
  }
  
  
  
}

void serialEvent(Serial p) {

  String input = p.readString();
  int val = 0;
    
  if (input != null) {
    val = int(input.trim()) / 5;
  }
    
  circleSize = val;
//  println(circleSize);

  
}
