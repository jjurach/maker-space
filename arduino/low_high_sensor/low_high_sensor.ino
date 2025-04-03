
int low_sensor = 12;
int high_sensor = 13;
int led = 4;

void setup() {
  Serial.begin(9600);

  pinMode(low_sensor,INPUT_PULLUP);
  pinMode(high_sensor,INPUT_PULLUP);
  pinMode(led, OUTPUT);
}

char buf[255] = "";
int pumping = -1;

void loop() {
  int low_signal = digitalRead(low_sensor) == LOW;
  int high_signal = digitalRead(high_sensor) == LOW;

  if (pumping == -1) {
    Serial.println(low_signal ? "low is signaling" : "low is not signalling");
    Serial.println(high_signal ? "high is signaling" : "high is not signalling");
    pumping = 0;
  }
  else if (pumping == 0 && (!low_signal && !high_signal)) {
    pumping = 1;
  }
  else if (pumping == 1 && (low_signal && high_signal)) {
    pumping = 0;
  }

  buf[0] = '\0';
  strcat(buf+strlen(buf), pumping ? "pumping " : "------- ");
  strcat(buf+strlen(buf), !low_signal ? "low-v " : "LOW-^ ");
  strcat(buf+strlen(buf), !high_signal ? "high-v " : "HIGH-^ ");
  Serial.println(buf);

  if (pumping) {
    digitalWrite(led, HIGH);
  }
  else {
    digitalWrite(led, LOW);
  }
  delay(500);
}
