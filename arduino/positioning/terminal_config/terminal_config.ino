
#define RXD2 16
#define TXD2 17

#define UWB_SERIAL Serial1

int led = 4;

void setup() {
  pinMode(led, OUTPUT);

  // blink four times
  for (int i=0; i<4; i++) {
    digitalWrite(led, HIGH);
    delay(100);
    digitalWrite(led, LOW);
    delay(100);
  }
 
  // Initialize USB Serial for debugging
  Serial.begin(115200);
  while (!Serial) {
    ; // Wait for USB serial port to connect
  }
  Serial.println("Starting board configuration...");

  // blink three times
  for (int i=0; i<3; i++) {
    digitalWrite(led, HIGH);
    delay(150);
    digitalWrite(led, LOW);
    delay(150);
  }

  // Initialize Serial2 with baud rate, data format, and pin assignments
  UWB_SERIAL.begin(115200, SERIAL_8N1, RXD2, TXD2); 
  // 9600 is the baud rate, SERIAL_8N1 is the data format (8 data bits, no parity, 1 stop bit)
  // RXD2 and TXD2 are the defined GPIO pins for RX and TX respectively

  char *COMMANDS[] = {
    "AT+SETCFG=0,0,1,1\r\n",
    "AT+SAVE\r\n",
    "AT+GETCFG\r\n",
    "AT+TESTLED=1\r\n",
    "AT+TESTLED=0\r\n",    
    NULL
  };

  delay(2000); // Give some time for everything to get ready

  char **cmd = COMMANDS;
  while (*cmd) {

      // Send configuration command
      Serial.print("Sending ");
      Serial.print(*cmd);
      Serial.println(" command...");
      UWB_SERIAL.print(*cmd);
      delay(1000);
      
      // Check for response
      if (UWB_SERIAL.available()) {
        String response = UWB_SERIAL.readString();
        Serial.println(response);
      }
      
      delay(3000);

      cmd++;
  }

  
  // blink four times
  for (int i=0; i<4; i++) {
    digitalWrite(led, HIGH);
    delay(150);
    digitalWrite(led, LOW);
    delay(150);
  }
}

void loop() {
  // Check for response
  if (UWB_SERIAL.available()) {
    String response = UWB_SERIAL.readString();
    Serial.println(response);
  }
}
