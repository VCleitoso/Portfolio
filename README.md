(documento em edição)
# Portfolio

Descrição do projeto WhyFarming

# IMPORTANTE

Ao dar deploy na aplicação, alterar o endereço de ip nos arquivos: 
/whyfarming/lib/main.dart
/Container/init.sql
Alterar para endereço do servidor usado pra deploy.
Necessário executar npm install @elastic/elasticsearch para utilizar o elastic search no servidor, e npm install axios para realizar a comunicação.
Se o monitoramento não for necessário, pode executar o server_no_kibana.js ao invés do server.js
Para dar deploy na aplicação:
executar deploy_linux, se estiver no linux
executar deploy_windows se estiver no windows

Caso queira executar manualmente, basta:
* Executar o docker-compose na pasta Container, elastic search e kibana;
* Em seguida, executar o server.js na pasta js;
* Após os passos anteriores entrar na pasta whyfarming/build/web e executar: python3 -m http.server 3030.

# Capa

- **Título do Projeto**: WhyFarming
- **Nome do Estudante**: Júlio Spezzia de Souza
- **Curso**: Engenharia de Software.


# Resumo

O presente documento apresenta o conceito e as funcionalidades do WhyFarming, uma ferramenta que auxilia pequenos agricultores na tomada de decisão, no que se refere à quais plantas vão cultivar. O produto avalia o solo através do produto de hardware, para fornecer recomendações de cultivo, tornando mais rápido o processo de análise do solo e facilitando na tomada de decisão]

# Introdução

Segundo  Kist, Severgnini, Four Comunicação, Radtke e Beling (2020), a agricultura familiar é a principal característica das pequenas propriedades da região sul do Brasil, auxiliando na economia das cidades locais, gerando recurso e renda, abastecendo o mercado interno e desacelerando o êxodo rural.
	
Com isso, o reconhecimento do trabalhador da agricultura familiar é essencial para o desenvolvimento destas regiões, porém, tais produtores possuem dificuldades, especialmente com questões burocráticas, sendo o processo de formalização muito cara e demorada, sendo inviável para pequenos produtores (KIST; SEVERGNINI; FOUR COMUNICAÇÃO; RADTKE; BELING, 2020).
	
Tendo em vista a importância do pequeno produtor, existem aplicativos que auxiliam no processo produtivo. Dentre os aplicativos observados, pode-se usar o exemplo do “Doutor Milho”(FERTISYSTEM, 2021).
	
O “Doutor Milho” oferece diferente instruções de plantio e manejo de milho (FERTISYSTEM, 2021), não existe, porém, um aplicativo barato focado no pequeno produtor que possua todas funcionalidades envolvendo análise de solo e sugestões de cultivo em um único produto.
	
## 1. Descrição do Projeto

O tema do projeto é um desenvolvimento de uma ferramenta de análise de solo com foco no pequeno agricultor. Percebe-se que a principal dor dos pequenos agricultores, como citada na introdução, é a burocracia excessiva, no entanto, não há software capaz de mudar legislações. Com isso, o WhyFarming possui o intuito de auxiliar na análise do solo,

## 1.1 Problemas a resolver



# Requisitos

**Requisitos funcionais**

1·	O sistema deve ser capaz de ler e interpetar as informações do solo fornecidos pelo usuário.
2·	O sistema deve ter um banco de dados de plantas que inclua informações sobre as condições ideais de cultivo, como clima, solo e exposição solar.
3·	O sistema deve recomendar uma lista de plantas adequadas para o cultivo na região específica do usuário, com base na qualidade do solo.
4·	Para cada planta recomendada, o sistema deve fornecer informações detalhadas, como instruções de cultivo, cuidados específicos, época de plantio e colheita, e possíveis pragas ou doenças.
 Uma abstração do funcionamento do sistema poder ser observado nas Figuras 
5·	O sistema deve ter uma interface de usuário amigável e intuitiva que permita aos usuários navegar facilmente pelas recomendações de plantas e acessar informações detalhadas.

 
**Requisitos não funcionais**

1·	É necessária conexão com a internet.
2·	É necessário o produto de hardware.
