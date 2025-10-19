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
#include <SPI.h>
#include <Bme280.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

// OLED display width and height, in pixels
#define SCREEN_WIDTH 128 
#define SCREEN_HEIGHT 64 // Or 32, depending on your specific OLED module

// Declaration for an SSD1306 display connected to Arduino via SPI
#define OLED_DC     17   // Data/Command pin
#define OLED_CS     21  // Chip Select pin
#define OLED_RESET  16   // Reset pin

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &SPI, OLED_DC, OLED_RESET, OLED_CS);

int temp_cspin = 5;

Bme280FourWire sensor;

void setup() {
  Serial.begin(9600);

  // SSD1306_SWITCHCAPVCC = generate display voltage from 3.3V internally
  if(!display.begin(SSD1306_SWITCHCAPVCC)) {
    Serial.println(F("SSD1306 allocation failed"));
    for(;;); // Don't proceed, loop forever
  }

  // Clear the buffer
  display.clearDisplay();

  // Set text size, color, and cursor position
  display.setTextSize(2);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(0,0);

  // set text and update display
  display.println(F("Hello, UMLIFE OLED!"));
  display.display();

  //SPI.begin();
  sensor.begin(temp_cspin, &SPI);
  sensor.setSettings(Bme280Settings::indoor());
}

int num = 0;
char buf[200];

void loop() {
  delay(2000);
  num++;

  auto temperature = "T:" + String(sensor.getTemperature()) + " C";
  auto pressure = "P:" + String(sensor.getPressure() / 100.0) + " hPa";

  Serial.println(temperature);
  Serial.println(pressure);

  // Clear the buffer
  display.clearDisplay();

  // Set text size, color, and cursor position
  display.setTextSize(2);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(0,0);

  // set text and update display
  //display.println(F("Hello there."));
  //display.println(itoa(num, buf, 10));
  display.println(temperature);
  display.println(pressure);
  display.display();
}
