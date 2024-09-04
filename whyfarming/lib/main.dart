import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
            RichText(
              text: const TextSpan(
                children: [
                  TextSpan(
                    text: 'Why',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.yellow,
                    ),
                  ),
                  TextSpan(
                    text: 'Farming',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ],
              ),
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
          ],

        ),
      ),
    );
  }
}

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

    final url = Uri.parse('http://127.0.0.1:3000/plants?n=$n&p=$p&k=$k');
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
                '/home/vandelsoncleitoso/Documentos/Faculdade/git/Portfolio/whyfarming/lib/WhyFarmingLogo.png',
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
class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

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
              '/home/vandelsoncleitoso/Documentos/Faculdade/git/Portfolio/whyfarming/WhyFarmingLogo.png',
              height: 100, // ajuste o tamanho conforme necessário
            ),
            const SizedBox(height: 40), // Espaçamento entre o texto e o botão

            // Botão "Detectar sinal do ESP"
            ElevatedButton(
              onPressed: () {
                // Adicione a lógica para detectar o sinal do ESP aqui
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
              ),
              child: const Text('Detectar sinal do ESP'),
            ),
          ],
        ),
      ),
    );
  }
}
class PlantDetailsScreen extends StatelessWidget {
  final List<Map<String, dynamic>> plantData;

  const PlantDetailsScreen({Key? key, required this.plantData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes das plantas),
      ),
      body: ListView.builder(
        itemCount: plantData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(plantData[index]['nome']),
            subtitle: Text(plantData[index]['descricao']),
            trailing: plantData[index]['url'] != null
                ? Image.network(plantData[index]['url'])
                : null,
          );
        },
      ),
    );
  }
}