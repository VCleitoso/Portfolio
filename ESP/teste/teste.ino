#include <WiFi.h>
#include <WebServer.h>
#include <ESPmDNS.h> // Inclua a biblioteca mDNS

const char* ssid = "12345678"; 
const char* password = "12345678"; 

WebServer server(80);

void setup() {
    Serial.begin(9600);
    delay(100);

    WiFi.begin(ssid, password);
    while (WiFi.status() != WL_CONNECTED) {
        delay(1000);
        Serial.println("Conectando ao Wi-Fi...");
    }
    Serial.println("Conectado ao Wi-Fi");

    if (!MDNS.begin("whyfarming")) { // Inicie mDNS (whyfarming.local)
        Serial.println("Erro ao iniciar mDNS");
    }

    server.on("/", handleRoot);
    server.on("/data", handleData);
    server.on("/redirect", handleRedirect); 
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
void handleRedirect() {
    server.sendHeader("Location", "http://inspiron.local:3030", true);
    server.send(302, "text/plain", "Redirecionando...");
}