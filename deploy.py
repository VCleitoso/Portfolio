import subprocess
import threading

# Função para executar um comando em um shell
def run_command(command):
    process = subprocess.Popen(command, shell=True, executable='/bin/bash')
    process.communicate()


# Comando 1: Entrar no diretório /Container e executar docker-compose up -d
command1 = f"echo executar container && cd Container && sudo docker-compose up -d"

# Comando 2: Voltar para o diretório raiz e executar node js/server.js
command2 = f"exit && echo executar node && node js/server.js &"

# Comando 3: Em paralelo, entrar no diretório whyfarming/build/web e executar http.server 3030
command3 = f"echo abrir servidor && cd whyfarming/build/web && python3 -m http.server 3030"

# Executar o comando 1 e esperar que ele termine
run_command(command1)

# Depois de terminar o comando 1, executar os comandos 2 e 3 em paralelo
thread2 = threading.Thread(target=run_command, args=(command2,))
thread3 = threading.Thread(target=run_command, args=(command3,))

thread2.start()
thread3.start()

thread2.join()
thread3.join()
