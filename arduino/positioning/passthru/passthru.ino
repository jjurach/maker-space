
#define RXD2 16
#define TXD2 17

#define UWB_SERIAL Serial1

void setup() {

  // Initialize USB Serial for debugging
  Serial.begin(115200);
  while (!Serial) {
    ; // Wait for USB serial port to connect
  }

  // Initialize Serial2 with baud rate, data format, and pin assignments
  UWB_SERIAL.begin(115200, SERIAL_8N1, RXD2, TXD2); 
  // 9600 is the baud rate, SERIAL_8N1 is the data format (8 data bits, no parity, 1 stop bit)
  // RXD2 and TXD2 are the defined GPIO pins for RX and TX respectively

  delay(500); // Give some time for everything to get ready

  Serial.println("OK>\r\n");
}

void loop() {

  if (Serial.available()) {

    String cmd = Serial.readString();
    Serial.println(cmd);
    Serial.print("Sending to device: ");
    Serial.print(cmd);
    Serial.println("OK>\r\n");

    UWB_SERIAL.print(cmd);
  }

  // Check for response
  if (UWB_SERIAL.available()) {
    String response = UWB_SERIAL.readString();
    Serial.print("Received from device: ");
    Serial.println(response);
    Serial.println("OK>\r\n");
  }

  delay(500);
}
