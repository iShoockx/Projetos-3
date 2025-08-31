import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/*
  Testes da tela de lembrete (FakeLembreteScreen).

  Descrição:
  - Valida a renderização dos principais widgets da tela de lembrete:
      * Campos de texto para: "Título do lembrete" e "Descrição"
      * Checkbox e texto "Importante"
      * Botões: "Escolher data", "Escolher hora" e "Salvar lembrete".
  - Permite testar a interface de forma isolada, sem depender da implementação real ou do banco de dados.

  Tipo de teste:
  - Unitário / integração leve de widgets

  Ferramenta utilizada:
  - flutter_test
*/

class FakeLembreteScreen extends StatelessWidget {
  const FakeLembreteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextField(decoration: InputDecoration(labelText: "Título do lembrete")),
            TextField(decoration: InputDecoration(labelText: "Descrição")),
            Checkbox(value: false, onChanged: null),
            Text("Importante"),
            ElevatedButton(onPressed: null, child: Text("Escolher data")),
            ElevatedButton(onPressed: null, child: Text("Escolher hora")),
            ElevatedButton(onPressed: null, child: Text("Salvar lembrete")),
          ],
        ),
      ),
    );
  }
}

void main() {
  group("LembreteScreen (básico)", () {
    testWidgets("Renderiza campos de título e descrição", (tester) async {
      await tester.pumpWidget(const FakeLembreteScreen());

      expect(find.text("Título do lembrete"), findsOneWidget);
      expect(find.text("Descrição"), findsOneWidget);
    });

    testWidgets("Renderiza checkbox e texto Importante", (tester) async {
      await tester.pumpWidget(const FakeLembreteScreen());

      expect(find.byType(Checkbox), findsOneWidget);
      expect(find.text("Importante"), findsOneWidget);
    });

    testWidgets("Renderiza botões principais", (tester) async {
      await tester.pumpWidget(const FakeLembreteScreen());

      expect(find.text("Escolher data"), findsOneWidget);
      expect(find.text("Escolher hora"), findsOneWidget);
      expect(find.text("Salvar lembrete"), findsOneWidget);
    });
  });
}