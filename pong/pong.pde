import processing.serial.*;

Serial myPort;
int paddleX, paddleWidth, halfPaddleWidth, paddleHeight, paddlePadding, stageWidth, stageHeight, count, contactCount; 
float ballX, ballY, ballVelocityX, ballVelocityY, ballSize, halfBallSize;
boolean contact;
int lf = 10;  // ASCII linefeed char

void setup() {
  stageWidth = 400;
  stageHeight = 400;
  
  paddleHeight = 10;
  paddleWidth = 50;
  paddlePadding = 2;
  halfPaddleWidth = paddleWidth / 2;
  
  reset();
  halfBallSize = ballSize / 2;
  
  size(stageWidth, stageHeight);
  background(255);
  
  // In case you want to see the list of available ports
//  println(Serial.list());
  
  String portName = Serial.list()[3];
  myPort = new Serial(this, portName, 9600);
  myPort.bufferUntil(lf);
}

void draw() {
  
  myPort.write("0"); 
  
  // draw a transparent rectangle to create fade effect.
  noStroke();
  fill(255, 50);
  rect(0, 0, stageWidth, stageHeight);
  

   
  // keep paddle in bounds of stage
  int px = paddleX - halfPaddleWidth, py, paddleLeft, paddleRight;
  px = max(halfPaddleWidth, px);
  px = min(px, stageWidth - halfPaddleWidth);
  py = stageHeight - paddleHeight - paddlePadding; // 2 pixels for padding at the bottom
  paddleLeft = px - halfPaddleWidth;
  paddleRight = paddleLeft + paddleWidth;
  
  // update ball position
  ballX += ballVelocityX;
  ballY += ballVelocityY;
  
  // ensure ball stays in bounds horizontally
  if (ballX > stageWidth - halfBallSize) {
    
    ballX -= ballVelocityX;
    ballVelocityX *= -1;
        
  } else if (ballX < halfBallSize) {
    
    ballX -= ballVelocityX;
    ballVelocityX *= -1;  
  }
  
  // ensure ball stays in bounds vertically...
  if (ballY >= stageHeight - halfBallSize - paddleHeight - paddlePadding) {
    
    // contact!
    if (ballX > paddleLeft && ballX < paddleRight) {
      // and when its at the bottom make it go faster
      
      contact = true;
      contactCount = 0;
      
      float diffX = (halfPaddleWidth - (paddleX - ballX));
      ballVelocityX += diffX / 15;
      println(diffX);
    
      ballY -= ballVelocityY;
      ballVelocityY *= -1.12;
      count++;
      
    } else {
      
      if (ballY > stageHeight) {
        reset();
//        myPort.write("1");
//        myPort.write("1,count;"); 
        println("You scored " + count + "!");
      }

    }
    
  } else if (ballY < halfBallSize) {
    
    ballY -= ballVelocityY;
    ballVelocityY *= -1;
    
  }
   
  // draw the ball
  stroke(0);
  fill(0);
  ellipse(ballX, ballY, ballSize, ballSize);
 
  // draw the paddle
  if (contact) {
    contactCount++;
    int r = min(255, 255 - contactCount * 10);
    stroke(r, 0, 0);
    fill(r, 0, 0);
    if (contactCount > 20) {
      contact = false;
    }
  } else {
    fill(0);
  } 
  rect(paddleLeft, py, paddleWidth, paddleHeight);

  
//  if (mousePressed == true) {
//    myPort.write('1');
//  } else {
//    myPort.write("0");
//  }
  
  
  
}

void reset() {
  ballX = int(random(stageWidth));
  ballY = 25;
  ballVelocityX = 1;
  ballVelocityY = 1.5;
  ballSize = 20;
  
  contact = false;
  contactCount = 0;
}

void serialEvent(Serial p) {

  String input = p.readString();
  float val = 0;
  
  // input is from 0 - 1023
  if (input != null) {
    val = map(int(input.trim()), 1023, 0, 0, stageWidth);
  }
    
  paddleX = int(val * 10) / 10;

  
}
