import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import '/home/vandelsoncleitoso/Documentos/Faculdade/git/Portfolio/whyfarming/lib/main.dart'; // Substitua pelo seu caminho correto

class MockClient extends Mock implements http.Client {}

void main() {
  testWidgets('HomeScreen displays title image and buttons', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.byType(Image), findsOneWidget); // Verifica se a imagem está presente
    expect(find.byType(ElevatedButton), findsNWidgets(2));
    expect(find.text('Input Manual'), findsOneWidget);
    expect(find.text('Input automático'), findsOneWidget);
  });

  testWidgets('FirstScreen fetches data and displays it', (WidgetTester tester) async {
    final client = MockClient();

    // Configura a resposta do MockClient
    when(client.get(Uri.parse('http://192.168.137.4:3000/plants?n=1&p=2&k=3')))
        .thenAnswer((_) async => http.Response('[{"nome": "Plant1", "descricao": "Desc1", "url": "http://example.com"}]', 200));

    // Usa o MockClient
    await tester.pumpWidget(MyApp(client: client));

    // Navega para a FirstScreen
    await tester.tap(find.text('Input Manual'));
    await tester.pumpAndSettle();

    // Preenche os campos e envia a solicitação
    await tester.enterText(find.byKey(Key('nField')), '1');
    await tester.enterText(find.byKey(Key('pField')), '2');
    await tester.enterText(find.byKey(Key('kField')), '3');
    await tester.tap(find.text('Buscar Plantas'));
    await tester.pumpAndSettle();

    // Verifica se a planta foi exibida
    expect(find.text('Plant1'), findsOneWidget);
  });

  // Adicione mais testes conforme necessário...
}
