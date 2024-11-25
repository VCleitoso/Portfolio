import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WhyFarming'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/WhyFarmingLogo.png',
              height: 100,
            ),
            const SizedBox(height: 50),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FirstScreen()),
                );
              },
              child: const Text('Input Manual'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
              child: const Text('Input automático'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LogsScreen()),
                );
              },
              child: const Text('Visualizar logs'),
            ),
          ],
        ),
      ),
    );
  }
}

// Tela de Input Manual
class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  final _nController = TextEditingController();
  final _pController = TextEditingController();
  final _kController = TextEditingController();
  String _result = '';

  Future<void> _fetchData() async {
    final n = _nController.text;
    final p = _pController.text;
    final k = _kController.text;

    final url = Uri.parse('http://inspiron.local:3000/plants?n=$n&p=$p&k=$k');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      final plantData = data.map((item) => {
        'nome': item['nome'],
        'descricao': item['descricao'],
        'url': item['url']
      }).toList();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => PlantDetailsScreen(plantData: plantData),
        ),
      );
    } else {
      setState(() {
        _result = 'Failed to fetch data';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Manual'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Image.asset(
                'assets/images/WhyFarmingLogo.png',
                height: 100,
              ),
            ),
            const SizedBox(height: 30),
            TextField(
              controller: _nController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'N',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _pController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'P',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _kController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'K',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchData,
              child: const Text('Buscar Plantas'),
            ),
            const SizedBox(height: 20),
            Text(_result),
          ],
        ),
      ),
    );
  }
}

// Tela de Input Automático
class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  _SecondScreenState createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  String _result = '';

  Future<void> _fetchArduinoData() async {
    final url = Uri.parse('http://whyfarming.local/data'); // Altere para o IP do seu ESP32

    try {
      // Primeiro, obtenha a string do Arduino
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final dataString = response.body;
        print('Data from Arduino: $dataString');

        // Aqui você pode manipular a string, se necessário
        final newUrl = Uri.parse('http://inspiron.local:3000/$dataString');
        print('New URL: $newUrl');

        // Agora, faça a segunda requisição
        final newResponse = await http.get(newUrl);

        if (newResponse.statusCode == 200) {
          final data = json.decode(newResponse.body) as List;
          print('Data from local server: $data');

          final plantData = data.map((item) => {
            'nome': item['nome'],
            'descricao': item['descricao'],
            'url': item['url']
          }).toList();

          // Navegar para a tela de detalhes
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PlantDetailsScreen(plantData: plantData),
            ),
          );
        } else {
          setState(() {
            _result = 'Failed to fetch data from second URL: ${newResponse.statusCode}';
          });
        }
      } else {
        setState(() {
          _result = 'Failed to fetch data from Arduino: ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        _result = 'Error: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Automático'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/WhyFarmingLogo.png',
              height: 100,
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _fetchArduinoData,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Detectar sinal do ESP'),
            ),
            const SizedBox(height: 20),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
// Tela de Logs
// Tela de Logs
class LogsScreen extends StatefulWidget {
  const LogsScreen({super.key});

  @override
  _LogsScreenState createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  // Lista para armazenar os logs recebidos da API
  List<dynamic> logs = [];

  // Função para buscar os logs do servidor
  Future<void> fetchLogs() async {
    final url = Uri.parse('http://localhost:3000/logs');  // Altere para o URL do seu servidor

    try {
      // Enviar a requisição GET
      final response = await http.get(url);

      if (response.statusCode == 200) {
        // Se a resposta for bem-sucedida, converta o corpo da resposta para JSON
        setState(() {
          logs = json.decode(response.body);
        });
      } else {
        // Caso a requisição falhe, exibe uma mensagem de erro
        throw Exception('Falha ao carregar os logs');
      }
    } catch (e) {
      // Em caso de erro ao fazer a requisição
      print('Erro ao carregar os logs: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLogs();  // Chama a função para carregar os logs ao inicializar a tela
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Logs'),
      ),
      body: logs.isEmpty
          ? const Center(child: CircularProgressIndicator())  // Exibe um indicador de carregamento enquanto os logs não são carregados
          : ListView.builder(
        itemCount: logs.length,
        itemBuilder: (context, index) {
          // Formatação do log (ajuste conforme os campos que você usa no seu banco)
          final log = logs[index];
          return ListTile(
            title: Text('Log ${log['id']} - ${log['endpoint']}'),  // Exibe o id e o endpoint como exemplo
            subtitle: Text('IP: ${log['ip']} - Data: ${log['timestamp']}'), // Exibe o IP e a data
          );
        },
      ),
    );
  }
}


// Tela de Detalhes das Plantas
class PlantDetailsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> plantData;

  const PlantDetailsScreen({Key? key, required this.plantData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes das plantas'),
      ),
      body: ListView.builder(
        itemCount: plantData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(plantData[index]['nome']),
            subtitle: Text(plantData[index]['descricao']),
            trailing: plantData[index]['url'] != null
                ? OutlinedButton(
              onPressed: () async {
                final url = plantData[index]['url'];
                if (await canLaunch(url)) {
                  await launch(
                    url,
                    forceSafariVC: false,
                    forceWebView: false,
                    enableJavaScript: true,
                    webOnlyWindowName: '_blank',
                  );
                } else {
                  print('Não foi encontrado $url');
                }
              },
              child: Text('Instruções'),
            )
                : null,
          );
        },
      ),
    );
  }
}
