import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

// Widget fake para simular a tela de inventário
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
