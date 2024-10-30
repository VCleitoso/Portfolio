import http.server
import socketserver
import subprocess
import os

os.chdir("whyfarming/build/web")

if not os.path.exists("."):
    print("Diretório não encontrado.")
    exit(1)

PORT = 3030 #alterar porta caso necessário.
Handler = http.server.SimpleHTTPRequestHandler

with socketserver.TCPServer(("", PORT), Handler) as httpd:
    print(f"Servidor HTTP rodando na porta {PORT}")
    httpd.serve_forever()
