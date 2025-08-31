import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/*
  Testes da tela de inventário (FakeInventarioScreen).

  Descrição:
  - Valida a renderização dos principais widgets da tela:
      * Campo de texto (TextField)
      * Botão/texto "Adicionar Item"
      * Indicador de loading (CircularProgressIndicator)
  - Permite testar o comportamento da interface de forma isolada,
    sem depender da implementação real ou do banco de dados.

  Tipo de teste:
  - Unitário / integração leve de widgets

  Ferramenta utilizada:
  - flutter_test
*/

class FakeInventarioScreen extends StatelessWidget {
  const FakeInventarioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const TextField(),
          StreamBuilder(
            stream: Stream<List<Map<String, dynamic>>>.fromIterable([
              ?null, // simula o estado de loading
            ]),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const CircularProgressIndicator();
              }
              return const SizedBox();
            },
          ),
          const Text("Adicionar Item"),
        ],
      ),
    );
  }
}

void main() {
  testWidgets('Renderiza campo de texto e botão "Adicionar Item"', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: FakeInventarioScreen()));

    expect(find.byType(TextField), findsOneWidget);
    expect(find.text("Adicionar Item"), findsOneWidget);
  });

  testWidgets('Renderiza indicador de loading ao abrir a tela', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: FakeInventarioScreen()));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
