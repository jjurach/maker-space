#include <SPI.h>
#include <Adafruit_GFX.h>
#include <Adafruit_SSD1306.h>

// OLED display width and height, in pixels
#define SCREEN_WIDTH 128 
#define SCREEN_HEIGHT 64 // Or 32, depending on your specific OLED module

// Declaration for an SSD1306 display connected to Arduino via SPI
#define OLED_MOSI   23  // MOSI pin
#define OLED_CLK    18  // SCK pin
#define OLED_DC     17   // Data/Command pin
#define OLED_CS     21  // Chip Select pin
#define OLED_RESET  16   // Reset pin

Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT,
  OLED_MOSI, OLED_CLK, OLED_DC, OLED_RESET, OLED_CS);

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
  display.setTextSize(1);
  display.setTextColor(SSD1306_WHITE);
  display.setCursor(0,0);

  // Display text
  display.println(F("Hello, UMLIFE OLED!"));

  // Update display
  display.display();
}

void loop() {
  // Add your custom display code here
}
