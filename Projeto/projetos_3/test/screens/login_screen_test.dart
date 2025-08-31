import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

/*
  Testes da tela de login (FakeLoginScreen).

  Descrição:
  - FakeLoginScreen é uma versão mínima da tela de login, utilizada apenas
    para testes de UI básicos, sem alterar a implementação real.
  - Testa a renderização e comportamento dos principais widgets:
      * Campos de texto: Nome, Celular (opcional), E-mail, Senha
      * Botão principal: Entrar
      * Botão de alternar para cadastro
      * Título da página

  Funcionalidades verificadas nos testes:
  - Renderização correta de todos os campos e botões
  - Possibilidade de inserir texto nos campos
  - Presença de textos e títulos esperados

  Tipo de teste:
  - Unitário / integração leve de widgets

  Ferramenta utilizada:
  - flutter_test
*/


/// Versão mínima da tela só para testes UI básicos.
class FakeLoginScreen extends StatelessWidget {
  const FakeLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Tec Frio')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text('Entrar', key: Key('pageTitle')),
              const SizedBox(height: 12),

              // Campos (com Keys para seleção estável nos testes)
              const TextField(
                key: Key('nameField'),
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              const SizedBox(height: 8),
              const TextField(
                key: Key('celularField'),
                decoration: InputDecoration(labelText: 'Celular (opcional)'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: 8),
              const TextField(
                key: Key('emailField'),
                decoration: InputDecoration(labelText: 'E-mail'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 8),
              const TextField(
                key: Key('passwordField'),
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
              ),
              const SizedBox(height: 16),

              // Botão principal (Entrar)
              ElevatedButton(
                key: Key('primaryButton'),
                onPressed: () {},
                child: const Text('Entrar'),
              ),

              const SizedBox(height: 8),

              // TextButton de alternar para cadastro
              TextButton(
                key: Key('toggleRegisterButton'),
                onPressed: () {},
                child: const Text('Ainda não tem conta? Cadastrar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  group('FakeLoginScreen - testes básicos', () {
    testWidgets('renderiza campos principais', (tester) async {
      await tester.pumpWidget(const FakeLoginScreen());

      expect(find.byKey(const Key('nameField')), findsOneWidget);
      expect(find.byKey(const Key('celularField')), findsOneWidget);
      expect(find.byKey(const Key('emailField')), findsOneWidget);
      expect(find.byKey(const Key('passwordField')), findsOneWidget);
    });

    testWidgets('renderiza botões e textos esperados', (tester) async {
      await tester.pumpWidget(const FakeLoginScreen());

      // título da página
      expect(find.byKey(const Key('pageTitle')), findsOneWidget);
      expect(find.text('Entrar'), findsWidgets); // título + botão
      // botão principal específico
      expect(find.widgetWithText(ElevatedButton, 'Entrar'), findsOneWidget);
      // botão de alternar cadastro
      expect(find.text('Ainda não tem conta? Cadastrar'), findsOneWidget);
    });

    testWidgets('permite inserir texto nos campos', (tester) async {
      await tester.pumpWidget(const FakeLoginScreen());

      await tester.enterText(find.byKey(const Key('emailField')), 'x@x.com');
      await tester.enterText(find.byKey(const Key('passwordField')), '123456');

      expect(find.text('x@x.com'), findsOneWidget);
      expect(find.text('123456'), findsOneWidget);
    });
  });
}