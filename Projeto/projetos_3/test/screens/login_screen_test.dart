// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:projetos_3/screens/login_screen.dart';
// import 'package:projetos_3/services/auth.dart';
// import 'package:projetos_3/models/usuario.dart';

// /// Serviço fake de autenticação para testes
// class FakeAuthService implements AuthService {
//   @override
//   Future<AppUser> signIn({
//     required String email,
//     required String password,
//   }) async {
//     if (email == 'teste@email.com' && password == '123456') {
//       return AppUser(
//         id: '321',
//         name: 'Maria',
//         email: email,
//         role: UserRole.cliente,
//         createdAt: DateTime.now(),
//       );
//     }
//     throw Exception('Credenciais inválidas');
//   }

//   @override
//   Future<AppUser> signUp({
//     required String name,
//     required String email,
//     required String password,
//     String? celular,
//     required UserRole role,
//   }) async {
//     if (email == 'teste@email.com') {
//       return AppUser(
//         id: '123',
//         name: name,
//         email: email,
//         role: role,
//         createdAt: DateTime.now(),
//       );
//     }
//     throw Exception('Erro ao cadastrar');
//   }
// }

// void main() {
//   late AuthService fakeAuth;

//   setUp(() {
//     fakeAuth = FakeAuthService();
//   });

//   Future<void> pumpLoginScreen(WidgetTester tester) async {
//     await tester.pumpWidget(
//       MaterialApp(
//         routes: {'/home': (context) => const Scaffold(body: Text('HomePage'))},
//         home: LoginScreen(auth: fakeAuth),
//       ),
//     );
//   }

//   group('LoginScreen com fake', () {
//     testWidgets('login com sucesso', (tester) async {
//       await pumpLoginScreen(tester);

//       await tester.enterText(
//         find.widgetWithText(TextFormField, 'E-mail'),
//         'teste@email.com',
//       );
//       await tester.enterText(
//         find.widgetWithText(TextFormField, 'Senha'),
//         '123456',
//       );

//       await tester.tap(find.text('Entrar'));
//       await tester.pumpAndSettle();

//       expect(find.text('HomePage'), findsOneWidget);
//     });

//     testWidgets('cadastro com sucesso', (tester) async {
//       await pumpLoginScreen(tester);

//       await tester.tap(find.text('Ainda não tem conta? Cadastrar'));
//       await tester.pumpAndSettle();

//       await tester.enterText(
//         find.widgetWithText(TextFormField, 'Nome'),
//         'João',
//       );
//       await tester.enterText(
//         find.widgetWithText(TextFormField, 'E-mail'),
//         'teste@email.com',
//       );
//       await tester.enterText(
//         find.widgetWithText(TextFormField, 'Senha'),
//         '123456',
//       );

//       await tester.tap(find.text('Cadastrar'));
//       await tester.pumpAndSettle();

//       expect(find.text('HomePage'), findsOneWidget);
//     });

//     testWidgets('login com erro', (tester) async {
//       await pumpLoginScreen(tester);

//       await tester.enterText(
//         find.widgetWithText(TextFormField, 'E-mail'),
//         'errado@email.com',
//       );
//       await tester.enterText(
//         find.widgetWithText(TextFormField, 'Senha'),
//         'senhaerrada',
//       );

//       await tester.tap(find.text('Entrar'));
//       await tester.pumpAndSettle();

//       expect(find.textContaining('Credenciais inválidas'), findsOneWidget);
//     });
//   });
// }
