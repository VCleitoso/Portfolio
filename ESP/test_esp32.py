import requests

ESP32_IP = "http://whyfarming.local" 
def test_data():
    url = f"{ESP32_IP}/data"
    print("Fazendo requisição para /data...")
    
    try:
        response = requests.get(url)
        if response.status_code == 200:
            print("Resposta recebida com sucesso!")
            print("Dados retornados:", response.text)
        else:
            print(f"Erro na requisição. Código de status: {response.status_code}")
    except requests.exceptions.RequestException as e:
        print(f"Erro ao fazer a requisição para {url}: {e}")

def test_redirect():
    url = f"{ESP32_IP}/redirect"
    print("Fazendo requisição para /redirect...")
    
    try:
        response = requests.get(url)
        if response.status_code == 302:
            print("Redirecionamento detectado. Localização:", response.headers['Location'])
        else:
            print(f"Erro no redirecionamento. Código de status: {response.status_code}")
    except requests.exceptions.RequestException as e:
        print(f"Erro ao fazer a requisição para {url}: {e}")

def run_tests():
    test_data()
    test_redirect()

if __name__ == "__main__":
    run_tests()
