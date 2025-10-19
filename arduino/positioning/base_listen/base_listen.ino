const int BUFFER_SIZE = 256;
uint8_t buffer[BUFFER_SIZE];
int bufferIndex = 0;
unsigned long lastByteTime = 0;
const unsigned long messageTimeout = 10; // milliseconds timeout between messages

void setup() {
  Serial.begin(115200);
  Serial1.begin(115200);
}

void loop() {
  // If bytes are available on UART:
  while (Serial1.available()) {
    uint8_t incomingByte = Serial1.read();
    if (bufferIndex < BUFFER_SIZE) {
      buffer[bufferIndex++] = incomingByte;
    }
    lastByteTime = millis(); // Reset timeout whenever we get a byte
  }

  // Check for timeout between messages
  if (bufferIndex > 0 && (millis() - lastByteTime > messageTimeout)) {
    // timeout occurred, assume message ended, print message:
    for (int i = 0; i < bufferIndex; i++) {
      Serial.print("0x");
      if (buffer[i] < 16) Serial.print("0");
      Serial.print(buffer[i], HEX);
      Serial.print(" ");
    }
    Serial.println(); // new line for next message
    bufferIndex = 0; // clear buffer
  }
}
