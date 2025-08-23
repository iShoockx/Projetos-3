import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:projetos_3/screens/login_screen.dart';
import 'package:projetos_3/services/auth.dart';
import 'package:projetos_3/models/usuario.dart';

/// Mock do AuthService
class MockAuthService extends Mock implements AuthService {}

void main() {
  late MockAuthService mockAuth;

  setUp(() {
    mockAuth = MockAuthService();
  });

  Future<void> pumpLoginScreen(WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        routes: {
          '/home': (context) => const Scaffold(body: Text('HomePage')),
        },
        home: LoginScreen(auth: mockAuth),
      ),
    );
  }

  group('LoginScreen', () {
    testWidgets('exibe título Entrar por padrão', (tester) async {
      await pumpLoginScreen(tester);

      expect(find.text('Entrar'), findsOneWidget);
      expect(find.text('Criar conta'), findsNothing);
    });

    testWidgets('alternar para cadastro mostra campos de Nome e Celular',
        (tester) async {
      await pumpLoginScreen(tester);

      await tester.tap(find.text('Ainda não tem conta? Cadastrar'));
      await tester.pumpAndSettle();

      expect(find.text('Criar conta'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Nome'), findsOneWidget);
      expect(find.widgetWithText(TextFormField, 'Celular (opcional)'),
          findsOneWidget);
    });

    testWidgets('valida formulário de login com email inválido', (tester) async {
      await pumpLoginScreen(tester);

      await tester.enterText(
          find.widgetWithText(TextFormField, 'E-mail'), 'invalido');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Senha'), '123456');

      await tester.tap(find.text('Entrar'));
      await tester.pump();

      expect(find.text('Informe um e-mail válido'), findsOneWidget);
    });

    testWidgets('ao cadastrar chama signUp e navega para home',
        (tester) async {
      await pumpLoginScreen(tester);

      await tester.tap(find.text('Ainda não tem conta? Cadastrar'));
      await tester.pumpAndSettle();

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Nome'), 'João');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'E-mail'), 'teste@email.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Senha'), '123456');

      final fakeUser = AppUser(
        id: '123',
        name: 'João',
        email: 'teste@email.com',
        role: UserRole.cliente,
        createdAt: DateTime.now(),
      );

      when(() => mockAuth.signUp(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
            celular: any(named: 'celular'),
            role: any(named: 'role'),
          )).thenAnswer((_) async => fakeUser);

      await tester.tap(find.text('Cadastrar'));
      await tester.pumpAndSettle();

      expect(find.text('HomePage'), findsOneWidget);
      verify(() => mockAuth.signUp(
            name: 'João',
            email: 'teste@email.com',
            password: '123456',
            celular: null,
            role: UserRole.cliente,
          )).called(1);
    });

    testWidgets('ao logar chama signIn e navega para home',
        (tester) async {
      await pumpLoginScreen(tester);

      await tester.enterText(
          find.widgetWithText(TextFormField, 'E-mail'), 'teste@email.com');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Senha'), '123456');

      final fakeUser = AppUser(
        id: '321',
        name: 'Maria',
        email: 'teste@email.com',
        role: UserRole.cliente,
        createdAt: DateTime.now(),
      );

      when(() => mockAuth.signIn(
            email: any(named: 'email'),
            password: any(named: 'password'),
          )).thenAnswer((_) async => fakeUser);

      await tester.tap(find.text('Entrar'));
      await tester.pumpAndSettle();

      expect(find.text('HomePage'), findsOneWidget);
      verify(() => mockAuth.signIn(
            email: 'teste@email.com',
            password: '123456',
          )).called(1);
    });
  });
}
