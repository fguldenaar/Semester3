
#include <ESP8266WiFi.h>
#include <ESP8266HTTPClient.h>

int SENSOR_D4 = 2;

int LED_D5 = 14;
int LED_D7 = 13;

IPAddress staticIP(192, 168, 178, 44); //ESP static ip
IPAddress gateway(192, 168, 178, 1);   //IP Address of your WiFi Router (Gateway)
IPAddress subnet(255, 255, 255, 0);  //Subnet mask
IPAddress dns(1, 1, 1, 1);  //DNS
 
//Hostname 
const char* deviceName = "WemosD1Wifi";

//SSID and Password of WiFi
const char* ssid = "ssid";
const char* password = "password";



void setup() {
  Serial.begin(19200);      // Set Baudrate

  connectToWifi();
  initPins();               // Initialize the pins


}

void connectToWifi(){
  Serial.print("Connecting to WiFi");
  WiFi.begin(ssid, password);     //Connect to WiFi

//Wait for connection
  while (WiFi.status() != WL_CONNECTED) {
    // Wait for a half second
    delay(500);                   
    // Print dot untill connected
    Serial.print(".");            
  }

  Serial.println("\nConnected");
  Serial.println("");

  WiFi.disconnect();  //Prevent connecting to wifi based on previous configuration

  // DHCP Hostname (useful for finding device for static lease)
  WiFi.hostname(deviceName);      
  WiFi.config(staticIP, subnet, gateway, dns);
  WiFi.begin(ssid, password);
 
 

  //If connection successful show IP address in serial monitor
  Serial.println("");
  Serial.print("Connected to: ");
  Serial.println(ssid);
  Serial.print("IP address: ");
  
  //IP address assigned to your ESP
  Serial.println(WiFi.localIP());  
}

void initPins() {
  pinMode(SENSOR_D4, INPUT);
  pinMode(LED_D5, OUTPUT);
  pinMode(LED_D7, OUTPUT);
  }




void loop() {
  int timer = 0;

  ledOff(LED_D5);                           // Turn off the Green LED
  ledOff(LED_D7);                           // Turn off the Yellow LED

  while (WiFi.status() == WL_CONNECTED) {
    if (timer % 2) {
      ledOff(LED_D5);                       // Turn off the Green LED
    } else {
      ledOn(LED_D5);                        // Turn on the Green LED
    }

    if (timer == 60) {
      httpCall("5042pc183Til", "Alive");      // Call the API
      timer = 0;                            // Reset timer for Alive call
    }


    if (isMotion(SENSOR_D4)) {
      ledOn(LED_D7);                        // Turn on the Green LED
      httpCall("5042pc183Til", "WakeyWakey"); // Call the API
    } else {
      ledOff(LED_D7);                       // Turn off the Green LED
    }

    delay(1000);                            // Wait for one second

    timer++;
  }
}

bool isMotion(int Sensor) {
  return digitalRead(Sensor) == HIGH;
  Serial.print(Sensor);
}

void ledOff(int LED) {
  digitalWrite(LED, LOW);            // Turn the LED on (Note that LOW is the voltage level)
}

void ledOn(int LED) {
  digitalWrite(LED, HIGH);            // Turn the LED on (Note that LOW is the voltage level)
}

void httpCall(String IoT, String endpoint) {
  HTTPClient http;

  BearSSL::WiFiClientSecure client;
  client.setInsecure();                // Don't check fingerprint
  String url = "https://rondjewelzijnapi.azurewebsites.net/api/" + endpoint + "/" + IoT + "";
  http.begin(client, url);

  int httpCode = http.GET();
  String payload = http.getString();

  if (httpCode == HTTP_CODE_OK) {
    Serial.println("Calling: " + endpoint);
  } else {
    Serial.printf("HTTP Error: %s\n", http.errorToString(httpCode).c_str());
    return;
  }

  http.end();
}
