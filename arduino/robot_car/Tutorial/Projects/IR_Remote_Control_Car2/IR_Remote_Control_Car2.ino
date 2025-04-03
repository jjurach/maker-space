#include <IRremote.h>

int RECV_PIN = 12;

#define IR_Go 0xB946FF00
#define IR_Back 0xEA15FF00
#define IR_Left 0xBB44FF00
#define IR_Right 0xBC43FF00
#define IR_Stop 0xBF40FF00
#define IR_ESC 0xB54AFF00

#define enA 5
#define in1 2
#define in2 4
#define in3 7
#define in4 8
#define enB 6

int speed = 0;
int maxSpeed = 6;
int turn = 0;
int maxTurn = 2;

typedef struct MotorState
{
  bool forward;
  // pwm ranges from 0 to 255
  unsigned char pwm;
} MotorState;
typedef struct MotorsState
{
  MotorState left;
  MotorState right;
} MotorsState;

void go_forward() // speed_val：0~255
{
  digitalWrite(in1, LOW);
  digitalWrite(in2, HIGH);
  digitalWrite(in3, LOW);
  digitalWrite(in4, HIGH);
}

void go_backward() // speed_val：0~255
{
  digitalWrite(in1, HIGH);
  digitalWrite(in2, LOW);
  digitalWrite(in3, HIGH);
  digitalWrite(in4, LOW);
}

void stop() // stop
{
  digitalWrite(in1, HIGH);
  digitalWrite(in2, HIGH);
  digitalWrite(in3, HIGH);
  digitalWrite(in4, HIGH);
  analogWrite(enA, 0);
  analogWrite(enB, 0);
}

void IR_Control(void)
{
  unsigned long Key;
  if (IrReceiver.decode())
  {
    // IrReceiver.printIRResultShort(&Serial);
    Key = IrReceiver.decodedIRData.decodedRawData;
    Serial.println(Key, HEX);
    switch (Key)
    {
    case IR_Go:
      Serial.println("incrementing speed");
      if (speed < maxSpeed)
      {
        speed++;
      }
      break;
    case IR_Back:
      Serial.println("decrementing speed");
      if (speed > -maxSpeed)
      {
        speed--;
      }
      break;
    case IR_Left:
      if (turn > -maxTurn)
      {
        turn--;
      }
      break;
    case IR_Right:
      if (turn < maxTurn)
      {
        turn++;
      }
      break;
    case IR_Stop:
      speed = 0;
      turn = 0;
      break;
    default:
      break;
    }

    updateSpeeds(speed, turn);
    IrReceiver.resume();
  }
}
void updateSpeeds(int speed, int turn)
{
  struct MotorsState motors;
  updateSpeeds2(&motors, speed, turn);

  Serial.print("speed=");
  Serial.print(speed);
  Serial.print(" turn=");
  Serial.print(turn);
  Serial.print(" -> right(forward=");
  Serial.print(motors.right.forward);
  Serial.print(",pwm=");
  Serial.print(motors.right.pwm);
  Serial.print("), left(forward=");
  Serial.print(motors.left.forward);
  Serial.print(",pwm=");
  Serial.print(motors.left.pwm);
  Serial.println(")");

  if (motors.left.forward)
  {
    digitalWrite(in1, HIGH);
    digitalWrite(in2, LOW);
  }
  else
  {
    digitalWrite(in1, LOW);
    digitalWrite(in2, HIGH);
  }
  if (motors.right.forward)
  {
    digitalWrite(in3, HIGH);
    digitalWrite(in4, LOW);
  }
  else
  {
    digitalWrite(in3, LOW);
    digitalWrite(in4, HIGH);
  }
  analogWrite(enA, motors.left.pwm);
  analogWrite(enB, motors.right.pwm);
}

void updateSpeeds2(struct MotorsState *state, int speed, int turn)
{
  state->left.forward = 1;
  state->left.pwm = 0;
  state->right.forward = 1;
  state->right.pwm = 0;
  if (speed == 0)
    return;

  if (speed > maxSpeed)
    speed = maxSpeed;
  else if (speed < -maxSpeed)
    speed = -maxSpeed;

  const int min_speed = 100;
  unsigned speed_max = (speed != 0 ? min_speed : 0) + int((abs(speed) / (float)maxSpeed) * (255 - min_speed));

  int slower_speed = speed - ((speed > 0) ? abs(turn) : -abs(turn));
  unsigned speed_slower = (slower_speed != 0 ? min_speed : 0) + int((abs(slower_speed) / (float)maxSpeed) * (255 - min_speed));

  if (turn > 0)
  {
    if (speed > 0)
    {
      // right goes slightly slower
      state->left.forward = 1;
      state->left.pwm = speed_max;
      state->right.forward = (slower_speed > 0);
      state->right.pwm = speed_slower;
    }
    else
    {
      // left goes slightly slower
      state->left.forward = 0;
      state->left.pwm = speed_max;
      state->right.forward = (slower_speed > 0);
      state->right.pwm = speed_slower;
    }
  }
  else
  {
    if (speed > 0)
    {
      // left goes slightly slower
      state->left.forward = (slower_speed > 0);
      state->left.pwm = speed_slower;
      state->right.forward = 1;
      state->right.pwm = speed_max;
    }
    else
    {
      // right goes slightly slower
      state->left.forward = (slower_speed > 0);
      state->left.pwm = speed_slower;
      state->right.forward = 0;
      state->right.pwm = speed_max;
    }
  }
}

void setup()
{
  pinMode(in1, OUTPUT); // pin2
  pinMode(in2, OUTPUT); // pin4
  pinMode(in3, OUTPUT); // pin7
  pinMode(in4, OUTPUT); // pin8
  pinMode(enA, OUTPUT); // pin5 (PWM)
  pinMode(enB, OUTPUT); // pin6 (PWM)
  IrReceiver.begin(RECV_PIN, ENABLE_LED_FEEDBACK);
  Serial.begin(9600); // initializing serial port, Bluetooth used as serial port, setting baud ratio at 9600
  stop();
}
void loop()
{
  IR_Control();
}
