/***************************************************************************
  This is a library for the BMP280 humidity, temperature & pressure sensor

  Designed specifically to work with the Adafruit BMP280 Breakout
  ----> http://www.adafruit.com/products/2651

  These sensors use I2C or SPI to communicate, 2 or 4 pins are required
  to interface.

  Adafruit invests time and resources providing this open source code,
  please support Adafruit andopen-source hardware by purchasing products
  from Adafruit!

  Written by Limor Fried & Kevin Townsend for Adafruit Industries.
  BSD license, all text above must be included in any redistribution


VIN
3V
GND
SCK
SDO
SDI
CS

VCC
GND
SCL
SDA
CSE
SDO

MOSI
MISO
CLK
CS




 ***************************************************************************/
#include <Arduino.h>
#include <Bme280.h>

int temp_cspin = 5;

Bme280FourWire sensor;

void setup() {
  Serial.begin(9600);
  SPI.begin();

  sensor.begin(temp_cspin, &SPI);
  sensor.setSettings(Bme280Settings::indoor());
}

void loop() {
  auto temperature = String(sensor.getTemperature()) + " °C";
  auto pressure = String(sensor.getPressure() / 100.0) + " hPa";
  auto humidity = String(sensor.getHumidity()) + " %";

  String measurements = temperature + ", " + pressure + ", " + humidity;
  Serial.println(measurements);

  delay(2000);
}
