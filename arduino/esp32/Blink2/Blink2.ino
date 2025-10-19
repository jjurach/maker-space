
/*
  Blink

  Turns an LED on for one second, then off for one second, repeatedly.

  Most Arduinos have an on-board LED you can control. On the UNO, MEGA and ZERO
  it is attached to digital pin 13, on MKR1000 on pin 6. LED_BUILTIN is set to
  the correct LED pin independent of which board is used.
  If you want to know what pin the on-board LED is connected to on your Arduino
  model, check the Technical Specs of your board at:
  https://www.arduino.cc/en/Main/Products

  modified 8 May 2014
  by Scott Fitzgerald
  modified 2 Sep 2016
  by Arturo Guadalupi
  modified 8 Sep 2016
  by Colby Newman

  This example code is in the public domain.

  http://www.arduino.cc/en/Tutorial/Blink
*/

// pins
int led = 2;
int sensor_high1 = 15;
int sensor_low1 = 16;
int sensor_kill1 = 17;
int sensor_high2 = 18;
int sensor_low2 = 19;
int sensor_kill2 = 21;
int relay_ctrl1 = 22;
int relay_ctrl2 = 23;

// internal state
int last_led = HIGH;
int last_high1 = 0;
int last_low1 = 0;
int last_kill1 = 0;
int last_high2 = 0;
int last_low2 = 0;
int last_kill2 = 0;

// Blink
//
int blink_interval = 5000;
int blink_step = 0;
time_t blink_t = 0;
void handle_blink() {
  time_t t = millis();
  if ( t-blink_t > blink_interval ) {
    blink_t = t;
    blink_step = 0;
    digitalWrite(led, HIGH); // turn the LED on (HIGH is the voltage level)
  }
  else if (blink_step == 0 && t-blink_t > blink_interval/10) {
    blink_step = 1;
    digitalWrite(led, LOW);  
  }
  else if (blink_step == 1 && t-blink_t > blink_interval/5) {
    blink_step = 1;
    digitalWrite(led, last_led);
  }
}

// Serial display
//
int display_t = 0;
void handle_display() {
  int t = millis();
  if (t-display_t > 4000) {
    display_t = t;
    Serial.print("4 seconds have elapsed: ");
    Serial.print(t);
    Serial.println();
  }
}

// the setup function runs once when you press reset or power the board
void setup()
{
  Serial.begin(9600); // open the serial port at 9600 bps:

  pinMode(led, OUTPUT);
  pinMode(sensor_high1, INPUT);
  pinMode(sensor_low1, INPUT);
  pinMode(sensor_kill1, INPUT);
  pinMode(sensor_high2, INPUT);
  pinMode(sensor_low2, INPUT);
  pinMode(sensor_kill2, INPUT);  
}


// the loop function runs over and over again forever
void loop()
{
  handle_blink();
  handle_display();
}
