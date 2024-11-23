#include <stdio.h>
#include <locale.h>

int main() {
    setlocale(LC_ALL, "pt_BR.UTF-8");
	printf("Pequeno script pra derrubar containers criados");
	system("echo Derrubar container MySQL && cd Container && sudo docker-compose down -v");
	//system("echo derrubar  Elastic Search e Kibana && cd elasticsearch && sudo docker-compose down -v && cd .. && cd kibana && sudo docker-compose down -v"); 
	 
    return 0;
}
