String command = ""; // Stores the incoming command from the serial monitor

int blink_led_pin = 2;
int last_blink_t = 0;
int blink_interval = 2000;

void setup() {
  Serial.begin(9600); // Initialize serial communication at 9600 baud rate
  Serial.println("Arduino Terminal Ready.");
  init_blink();
  printPrompt();
}

void loop() {
  if (Serial.available()) { // Check if data is available to read from serial
    char incomingChar = Serial.read(); // Read the incoming character

    if (incomingChar == '\n' || incomingChar == '\r') { // If Enter key is pressed
      processCommand(command); // Process the received command
      command = ""; // Clear the command string for the next input
      printPrompt();
    } else {
      command += incomingChar; // Append the character to the command string
    }
  }
  
  handle_blink();
}

void init_blink() {
  pinMode(blink_led_pin, OUTPUT);
  last_blink_t = millis();
}

void handle_blink() {
  int now = millis();

  int want_toggle = 0;
 
  if (last_blink_t + blink_interval < now) {
    last_blink_t = now;
    want_toggle = 1;
  }

  if (want_toggle) {
    int blink_state = digitalRead(blink_led_pin);
    digitalWrite(blink_led_pin,!blink_state);
  }
}

void printPrompt() {
  Serial.print("> "); // Print the command prompt
}

void processCommand(String cmd) {
  cmd.trim(); // Remove leading/trailing whitespace

  if (cmd == "help") {
    Serial.println("Available commands:");
    Serial.println("  help - Display this help message");
    Serial.println("  hello - Greet the user");
    Serial.println("  status - Show a simple status message");
  } else if (cmd == "hello") {
    Serial.println("Hello there!");
  } else if (cmd == "status") {
    Serial.println("System operational.");
  } else if (cmd.length() > 0) { // If a non-empty, unrecognized command is entered
    Serial.print("Unknown command: ");
    Serial.println(cmd);
  }
}
