#include <WiFi.h>
#include <WebServer.h>
#include <ESPmDNS.h>

const char* ssid = "12345678";
const char* password = "12345678";

WebServer server(80); // Create a WebServer instance on port 80

#define RE 34
#define DE 32

const byte nitro[] = {0x01, 0x03, 0x00, 0x1e, 0x00, 0x01, 0xe4, 0x0c};
const byte phos[] = {0x01, 0x03, 0x00, 0x1f, 0x00, 0x01, 0xb5, 0xcc};
const byte pota[] = {0x01, 0x03, 0x00, 0x20, 0x00, 0x01, 0x85, 0xc0};

byte values[11];

HardwareSerial mod(1); // Use HardwareSerial instead of SoftwareSerial

void setup() {
  Serial.begin(9600);
  delay(100);
  mod.begin(9600, SERIAL_8N1, 35, 33); // Configure Serial2 with RX and TX pins on D35 and D33
  delay(100);
  pinMode(RE, OUTPUT);
  pinMode(DE, OUTPUT);
  Serial.println("Iniciando Wi-Fi...");
  WiFi.begin(ssid, password);
  unsigned long startAttemptTime = millis();
  while (WiFi.status() != WL_CONNECTED && millis() - startAttemptTime < 30000) {
    delay(1000);
    Serial.println("Conectando ao Wi-Fi...");
  }
  if (WiFi.status() == WL_CONNECTED) {
    Serial.println("Conectado ao Wi-Fi");
    if (!MDNS.begin("whyfarming")) {
      Serial.println("Erro ao iniciar mDNS");
    }
    //server.on("/", handleRoot);
    server.on("/data", handleData);
   // server.on("/redirect", handleRedirect);
    server.on("/", handleRedirect);
    server.begin();
  } else {
    Serial.println("Falha ao conectar ao Wi-Fi");
  }
}

void loop() {
  server.handleClient();
  delay(200); // Small delay to prevent blocking
}

void handleRoot() {
  Serial.println("Acesso ao root detectado");
  server.sendHeader("Access-Control-Allow-Origin", "*");
  server.send(200, "text/html", "<h1>Bem-vindo ao Sensor NPK</h1><p>Acesse <a href='/data'>/data</a> para ver os dados do sensor <br> E <a href='/redirect'>/redirect</a> para acessar o app.</p>");
}

void handleData() {
  server.sendHeader("Access-Control-Allow-Origin", "*"); 
  byte val1 = nitrogen();
  byte val2 = phosphorous();
  byte val3 = potassium();
  String valores = "plants?n=" + String(val1) + "&p=" + String(val2) + "&k=" + String(val3);
  String valoresestaticos = "plants?n=12.30&p=18.50&k=9.20"; // 12.30, 18.50, 9.20,
  server.send(200, "text/plain", valores);
  Serial.print("Valores: ");
  Serial.print(valores);
}

void handleRedirect() {
  Serial.println("Redirecionando para a aplicação...");
  server.sendHeader("Location", "http://192.168.137.4:3030", true);
  server.send(302, "text/plain", "Redirecionando...");
}

byte nitrogen() {
  digitalWrite(DE, HIGH);
  digitalWrite(RE, HIGH);
  delay(10);
  if (mod.write(nitro, sizeof(nitro)) == 8) {
    digitalWrite(DE, LOW);
    digitalWrite(RE, LOW);
    delay(100); // Small delay to ensure data is received
    for (byte i = 0; i < 7; i++) {
      if (mod.available()) {
        values[i] = mod.read();
        Serial.print(values[i], HEX);
      }
    }
    Serial.println();
  }
  return values[4];
}

byte phosphorous() {
  digitalWrite(DE, HIGH);
  digitalWrite(RE, HIGH);
  delay(10);
  if (mod.write(phos, sizeof(phos)) == 8) {
    digitalWrite(DE, LOW);
    digitalWrite(RE, LOW);
    delay(100); // Small delay to ensure data is received
    for (byte i = 0; i < 7; i++) {
      if (mod.available()) {
        values[i] = mod.read();
        Serial.print(values[i], HEX);
      }
    }
    Serial.println();
  }
  return values[4];
}

byte potassium() {
  digitalWrite(DE, HIGH);
  digitalWrite(RE, HIGH);
  delay(10);
  if (mod.write(pota, sizeof(pota)) == 8) {
    digitalWrite(DE, LOW);
    digitalWrite(RE, LOW);
    delay(100); // Small delay to ensure data is received
    for (byte i = 0; i < 7; i++) {
      if (mod.available()) {
        values[i] = mod.read();
        Serial.print(values[i], HEX);
      }
    }
    Serial.println();
  }
  return values[4];
}
