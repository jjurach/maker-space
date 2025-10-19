
void setup() {
  Serial.begin(112500);
  
  // Wait for Serial port to connect. Needed for native USB port boards only.
  while (!Serial) {
    ; // do nothing
  }

  Serial.println("Serial port is ready!");
}

void loop() {
  // Your main program logic goes here
  if (Serial.available() > 0) {
    char incomingChar = Serial.read();
    Serial.print("Received: ");
    Serial.println(incomingChar);
  }
}
