#include <stdio.h>
#include <locale.h>

int main() {
    setlocale(LC_ALL, "pt_BR.UTF-8");
    printf("Este deploy só funciona no windows, podes executar o deploy_linux, se quiser.\n");

    system("echo executar container && cd Container && docker-compose up -d");
    
    system("echo executar elastic search e kibana && cd .. && cd elasticsearch && docker-compose up -d"):

    system("start cmd /c \"cd .. && echo executar node && node js/server.js\"");

    system("echo abrir servidor na porta 3030 && cd whyfarming\\build\\web && python3 -m http.server 3030");

    return 0;
}
