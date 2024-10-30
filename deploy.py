import http.server
import socketserver
import subprocess
import os
import time


def run_commands():
 
    docker_process = subprocess.Popen(["docker-compose", "up"], cwd="Container")
    node_process = subprocess.Popen(["node", "js/server.js"])

    return docker_process, node_process

docker_process, node_process = run_commands()

time.sleep(5)

# Muda para o diretório correto
os.chdir("whyfarming/build/web")

# Verifica se o diretório existe
if not os.path.exists("."):
    print("Diretório não encontrado.")
    exit(1)

# Inicia o servidor HTTP
PORT = 3030
Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Servidor HTTP rodando na porta {PORT}")
    httpd.serve_forever()

# Não esquecer de terminar os processos ao final
docker_process.terminate()
node_process.terminate()
