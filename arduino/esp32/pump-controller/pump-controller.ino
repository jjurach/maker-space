
/*
  Irrigation Controller

  Monitors high-level, low-level, and kill sensors to switch relays to drive pumps.
*/

// pins
int led = 2;
int sensor_low1 = 15;
int sensor_high1 = 16;
int sensor_kill1 = 17;
int sensor_low2 = 18;
int sensor_high2 = 19;
int sensor_kill2 = 21;
int relay_ctrl1 = 22;
int relay_ctrl2 = 23;

// internal state
int led_state = 0;
int last_high1 = 0;
int last_low1 = 0;
int last_kill1 = 0;
int last_high2 = 0;
int last_low2 = 0;
int last_kill2 = 0;
int pump_state1 = 0;
int pump_state2 = 0;

int read_pin(int pin, int last_val, const char *desc)
{
  int val = !digitalRead(pin);
  if (val != last_val)
  {
    Serial.print(desc);
    Serial.print(" change detected: ");
    Serial.println(val);
    return val;
  }
  return last_val;
}

// Blink
//
int blink_interval = 5000;
int blink_step = 0;
time_t blink_t = 0;
void handle_blink()
{
  time_t t = millis();
  if (t - blink_t > blink_interval)
  {
    blink_t = t;
    blink_step = 0;
    digitalWrite(led, HIGH); // turn the LED on (HIGH is the voltage level)
  }
  else if (blink_step == 0 && t - blink_t > blink_interval / 10)
  {
    blink_step = 1;
    digitalWrite(led, LOW);
  }
  else if (blink_step == 1 && t - blink_t > blink_interval / 5)
  {
    blink_step = 2;
    digitalWrite(led, led_state);
  }
}

// Serial display
//
int display_t = 0;
void handle_display()
{
  int t = millis();
  if (t - display_t > 4000)
  {
    display_t = t;
    Serial.print("1:[");
    Serial.print(last_low1);
    Serial.print(last_high1);
    Serial.print(last_kill1);
    Serial.print("]->");
    Serial.print(pump_state1);
    Serial.print("  2:[");
    Serial.print(last_low2);
    Serial.print(last_high2);
    Serial.print(last_kill2);
    Serial.print("]->");
    Serial.println(pump_state2);
  }
}

// Read sensors
//
void read_sensors()
{
  last_low1 = read_pin(sensor_low1, last_low1, "low1");
  last_high1 = read_pin(sensor_high1, last_high1, "high1");
  last_kill1 = read_pin(sensor_kill1, last_kill1, "kill1");
  last_low2 = read_pin(sensor_low2, last_low2, "low2");
  last_high2 = read_pin(sensor_high2, last_high2, "high2");
  last_kill2 = read_pin(sensor_kill2, last_kill2, "kill2");

  if (last_kill1)
  {
    pump_state1 = 0;
  }
  else if (!last_high1 && !last_low1)
  {
    pump_state1 = 1;
  }
  else if (pump_state1 == 1 && last_high1)
  {
    pump_state1 = 0;
  }

  if (last_kill2)
  {
    pump_state2 = 0;
  }
  else if (!last_high2 && !last_low2)
  {
    pump_state2 = 1;
  }
  else if (pump_state2 && last_high2)
  {
    pump_state2 = 0;
  }

  led_state = pump_state1 && pump_state2;

  digitalWrite(relay_ctrl1, pump_state1);
  digitalWrite(relay_ctrl2, pump_state2);
}

// the setup function runs once when you press reset or power the board
void setup()
{
  Serial.begin(9600); // open the serial port at 9600 bps:

  if (led)
    pinMode(led, OUTPUT);
  pinMode(sensor_low1, INPUT_PULLUP);
  pinMode(sensor_high1, INPUT_PULLUP);
  pinMode(sensor_kill1, INPUT_PULLUP);
  pinMode(sensor_low2, INPUT_PULLUP);
  pinMode(sensor_high2, INPUT_PULLUP);
  pinMode(sensor_kill2, INPUT_PULLUP);
  pinMode(relay_ctrl1, OUTPUT);
  pinMode(relay_ctrl2, OUTPUT);
}

// the loop function runs over and over again forever
void loop()
{
  read_sensors();
  handle_blink();
  handle_display();
}
