import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/*
  Testes da tela de notificações (FakeNotificationsScreen).

  Descrição:
  - FakeNotificationsScreen é uma versão simplificada da tela de notificações,
    utilizada apenas para testes de UI sem depender da implementação real.
  - Permite simular três estados principais:
      * Loading: exibe CircularProgressIndicator
      * Erro: exibe mensagem de erro
      * Lista de lembretes: exibe lembretes em ListView
      * Nenhum lembrete: exibe mensagem informando que não há lembretes

  Funcionalidades verificadas nos testes:
  - Indicador de loading é exibido corretamente
  - Mensagem de erro é exibida quando fornecida
  - Mensagem de "nenhum lembrete encontrado" é exibida quando a lista está vazia
  - Lembretes são renderizados corretamente na lista

  Tipo de teste:
  - Unitário / integração leve de widgets

  Ferramenta utilizada:
  - flutter_test
*/

class FakeNotificationsScreen extends StatelessWidget {
  final bool isLoading;
  final String? error;
  final List<Map<String, dynamic>> lembretes;

  const FakeNotificationsScreen({
    super.key,
    this.isLoading = false,
    this.error,
    this.lembretes = const [],
  });

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (error != null) {
      return Scaffold(body: Center(child: Text('Erro: $error')));
    }

    if (lembretes.isEmpty) {
      return const Scaffold(body: Center(child: Text('Nenhum lembrete encontrado.')));
    }

    return Scaffold(
      appBar: AppBar(title: const Text('NOTIFICAÇÕES')),
      body: ListView(
        children: lembretes
            .map((l) => ListTile(
                  title: Text(l['titulo'] ?? 'Sem título'),
                  subtitle: Text(l['descricao'] ?? 'Sem descrição'),
                ))
            .toList(),
      ),
    );
  }
}

void main() {
  testWidgets('Exibe indicador de loading', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: FakeNotificationsScreen(isLoading: true),
    ));

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('Exibe mensagem de erro', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: FakeNotificationsScreen(error: 'Falha na conexão'),
    ));

    expect(find.text('Erro: Falha na conexão'), findsOneWidget);
  });

  testWidgets('Exibe mensagem quando não há lembretes', (tester) async {
    await tester.pumpWidget(const MaterialApp(
      home: FakeNotificationsScreen(lembretes: []),
    ));

    expect(find.text('Nenhum lembrete encontrado.'), findsOneWidget);
  });

  testWidgets('Renderiza lista de lembretes', (tester) async {
    final lembretes = [
      {'titulo': 'Lembrete 1', 'descricao': 'Descrição 1'},
      {'titulo': 'Lembrete 2', 'descricao': 'Descrição 2'},
    ];

    await tester.pumpWidget(MaterialApp(
      home: FakeNotificationsScreen(lembretes: lembretes),
    ));

    expect(find.text('Lembrete 1'), findsOneWidget);
    expect(find.text('Lembrete 2'), findsOneWidget);
  });
}