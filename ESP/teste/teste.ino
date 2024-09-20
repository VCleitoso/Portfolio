#include <WiFi.h>
#include <WebServer.h>

const char* ssid = "flavio-2G"; 
const char* password = "2219280214"; 

IPAddress local_IP(192, 168, 137, 218);
IPAddress gateway(192, 168, 137, 1);
IPAddress subnet(255, 255, 255, 0);

WebServer server(80);

void setup() {
    Serial.begin(9600);
    delay(100); // Aguarde para garantir que o Serial esteja pronto

    if (!WiFi.config(local_IP, gateway, subnet)) {
        Serial.println("Falha ao configurar IP estático");
    } else {
        Serial.println("IP estático configurado");
    }

    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.println("Conectando ao Wi-Fi...");
    }
    Serial.println("Conectado ao Wi-Fi");

    server.on("/", handleRoot);
    server.on("/data", handleData);
    server.begin();
}

void loop() {
    server.handleClient();
}

void handleRoot() {
    server.sendHeader("Access-Control-Allow-Origin", "*");
    server.send(200, "text/html", "<h1>Bem-vindo ao Sensor NPK</h1><p>Acesse <a href='/data'>/data</a> para ver os dados do sensor.</p>");
}

void handleData() {
    server.sendHeader("Access-Control-Allow-Origin", "*"); 
    String valores_estaticos = "plants?n=1&p=1&k=1";
    server.send(200, "text/plain", valores_estaticos);
}
