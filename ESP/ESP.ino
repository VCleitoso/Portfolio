#include <WiFi.h>
#include <WebServer.h>
#include <ESPmDNS.h>

const char* ssid = "WickedBotz";
const char* password = "wickedbotz";

WebServer server(80); 

// Pinos de controle e comunicação RS485
#define RE 34  // Recepção/Transmissão (controle de direção)
#define DE 32  // Recepção/Transmissão (controle de direção)
#define DI 35  // TX para o sensor RS485
#define RO 33  // RX do sensor RS485 para o ESP32

// Comandos para o sensor
const byte nitro[] = {0x01, 0x03, 0x00, 0x1e, 0x00, 0x01, 0xb5, 0xcc};
const byte phos[] = {0x01, 0x03, 0x00, 0x1f, 0x00, 0x01, 0xe4, 0x0c};
const byte pota[] = {0x01, 0x03, 0x00, 0x20, 0x00, 0x01, 0x85, 0xc0};
byte val1, val2, val3;
byte values[11];
HardwareSerial mod(1);  // Usando a serial 1 para comunicação RS485

void setup() {
  Serial.begin(9600);
  delay(100);
  mod.begin(9600, SERIAL_8N1, DI, RO);  // Iniciando a comunicação serial RS485 com pinos DI e RO
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
    server.on("/", handleRoot);
    server.on("/data", handleData);
    server.on("/redirect", handleRedirect);
    server.begin();
  } else {
    Serial.println("Falha ao conectar ao Wi-Fi");
  }
}

void loop() {
  val1 = nitrogen();
  val2 = phosphorous();
  val3 = potassium();
  server.handleClient();
  delay(200); // Leia os sensores a cada 5 segundos
}

void handleRoot() {
  Serial.println("Acesso ao root detectado");
  server.sendHeader("Access-Control-Allow-Origin", "*");
  server.send(200, "text/html", "<h1>Bem-vindo ao Sensor NPK</h1><p>Acesse <a href='/data'>/data</a> para ver os dados do sensor <br> E <a href='/redirect'>/redirect</a> para acessar o app.</p>");
}

void handleData() {
  server.sendHeader("Access-Control-Allow-Origin", "*"); 
  String valores = "plants?n=" + String(val1) + "&p=" + String(val2) + "&k=" + String(val3);
  server.send(200, "text/plain", valores);
  Serial.print("Valores: ");
  Serial.print(valores);
}

void handleRedirect() {
  Serial.println("Redirecionando para a aplicação...");
  server.sendHeader("Location", "http://inspiron.local:3030", true);
  server.send(302, "text/plain", "Redirecionando...");
}

// Função para ler o nitrogênio
byte nitrogen() {
  digitalWrite(DE, HIGH);  // Ativar modo de transmissão
  digitalWrite(RE, HIGH);  // Ativar modo de transmissão
  delay(10);

  if (mod.write(nitro, sizeof(nitro)) == 8) {  // Envia o comando para o sensor
    digitalWrite(DE, LOW);  // Ativar modo de recepção
    digitalWrite(RE, LOW);  // Ativar modo de recepção
    delay(100);     

    if (mod.available() > 0) {  // Verifica se há dados disponíveis
      for (byte i = 0; i < 7; i++) {
        if (mod.available()) {
          values[i] = mod.read();  // Lê os dados recebidos
        }
      }
    }
  }
  return values[4];   // Retorna o valor de nitrogênio
}

// Função para ler o fósforo
byte phosphorous() {
  digitalWrite(DE, HIGH);  // Ativar modo de transmissão
  digitalWrite(RE, HIGH);  // Ativar modo de transmissão
  delay(10);

  if (mod.write(phos, sizeof(phos)) == 8) {  // Envia o comando para o sensor
    digitalWrite(DE, LOW);  // Ativar modo de recepção
    digitalWrite(RE, LOW);  // Ativar modo de recepção
    delay(100);     

    if (mod.available() > 0) {  // Verifica se há dados disponíveis
      for (byte i = 0; i < 7; i++) {
        if (mod.available()) {
          values[i] = mod.read();  // Lê os dados recebidos
        }
      }
    }
  }
  return values[4];  // Retorna o valor de fósforo
}

// Função para ler o potássio
byte potassium() {
  digitalWrite(DE, HIGH);  // Ativar modo de transmissão
  digitalWrite(RE, HIGH);  // Ativar modo de transmissão
  delay(10);

  if (mod.write(pota, sizeof(pota)) == 8) {  // Envia o comando para o sensor
    digitalWrite(DE, LOW);  // Ativar modo de recepção
    digitalWrite(RE, LOW);  // Ativar modo de recepção
    delay(100);     

    if (mod.available() > 0) {  // Verifica se há dados disponíveis
      for (byte i = 0; i < 7; i++) {
        if (mod.available()) {
          values[i] = mod.read();  // Lê os dados recebidos
        }
      }
    }
  }
  return values[4];  // Retorna o valor de potássio
}
