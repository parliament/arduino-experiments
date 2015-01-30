char val;
int ledPin = 13;
int sensorPin = 0;

void setup()
{
  pinMode(ledPin, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  
  // get data from hardware, send to processing
  int sensorValue = analogRead(sensorPin);
  Serial.println(sensorValue);
  
  // get value from processing, send to LED
  if (Serial.available()) {
    val = Serial.read();
  }
  
  if (val == '1') {
    digitalWrite(ledPin, HIGH);
  } else {
    digitalWrite(ledPin, LOW);
  }
  
  delay(10);
}
