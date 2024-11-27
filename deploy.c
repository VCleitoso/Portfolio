#include <stdio.h>
#include <locale.h>

int main() {
    setlocale(LC_ALL, "pt_BR.UTF-8");
	printf("Este deploy só funciona em linux, podes observar os comandos em terminal e executar no windows.\n");
	system("echo executar container && cd Container && sudo docker-compose up -d");
	system("echo executar node && node js/server.js &");
	system("echo abrir servidor na porta 3030 && cd whyfarming/build/web && python3 -m http.server 3030");
  
    return 0;
}
