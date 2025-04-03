#include "WiFi.h"

#define ssid "GRAYVAN7"
#define password "Atla55hrugg3d"

void initWiFi()
{
    Serial.print("Connecting to WiFi ..");
    // WiFi.mode(WIFI_STA);
    Serial.print("Beginning WiFi ..");
    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED)
    {
        Serial.print('.');
        delay(1000);
    }
    Serial.println(WiFi.localIP());
}

void setup()
{
    Serial.begin(115200);
    initWiFi();
}

void loop()
{
}
