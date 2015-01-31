int incomingByte = 0;
int ledPin = 13;
int sensorPin = 0;
int score;


void setup()
{
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  
  // get data from hardware, send to processing
  int sensorValue = analogRead(sensorPin);
  Serial.println(sensorValue);
  
//  // get value from processing, send to LED
//  if (Serial.available()) {
//    incomingByte = Serial.read();
//  }
//  
//  if (incomingByte == '1') {
//    
//    for (int i = 0; i < score; i++) {
//      digitalWrite(ledPin, HIGH);
//      delay(500);
//    }
//    
//  } else {
//    digitalWrite(ledPin, LOW);
//  }
  
  delay(10);
}
