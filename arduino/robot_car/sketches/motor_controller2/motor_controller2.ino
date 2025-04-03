int motor1pin1 = 2;
int motor1pin2 = 4;
int motor2pin1 = 7;
int motor2pin2 = 8;
int enA = 5;
int enB = 2;

void setup()
{
  // put your setup code here, to run once:
  pinMode(motor1pin1, OUTPUT);
  pinMode(motor1pin2, OUTPUT);
  pinMode(motor2pin1, OUTPUT);
  pinMode(motor2pin2, OUTPUT);

  //(Optional)
  pinMode(enA, OUTPUT);
  pinMode(enB, OUTPUT);
  //(Optional)
}

void loop()
{
  // put your main code here, to run repeatedly:

  // Controlling speed (0  = off and 255 = max speed):
  //(Optional)
  analogWrite(enA, 0);   // ENA  pin
  analogWrite(enB, 150); // ENB pin
  //(Optional)

  digitalWrite(motor1pin1, HIGH);
  digitalWrite(motor1pin2, LOW);

  digitalWrite(motor2pin1, HIGH);
  digitalWrite(motor2pin2, LOW);
  delay(3000);

  digitalWrite(motor1pin1, LOW);
  digitalWrite(motor1pin2, HIGH);

  digitalWrite(motor2pin1, LOW);
  digitalWrite(motor2pin2, HIGH);
  delay(3000);
}
