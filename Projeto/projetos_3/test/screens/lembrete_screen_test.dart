// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:projetos_3/screens/lembrete_screen.dart';
// import 'package:projetos_3/services/lembrete.dart';

// // Mock do LembreteService
// class MockLembreteService extends Mock implements LembreteService {}

// void main() {
//   late MockLembreteService mockService;

//   setUp(() {
//     mockService = MockLembreteService();
//   });

//   testWidgets('Exibe campos e botões corretamente', (
//     WidgetTester tester,
//   ) async {
//     // Constrói a tela com o mockService
//     await tester.pumpWidget(MaterialApp(home: LembreteScreen()));

//     // Verifica se os campos existem
//     expect(find.text("Título do lembrete"), findsOneWidget);
//     expect(find.text("Descrição"), findsOneWidget);
//     expect(find.text("Escolher data"), findsOneWidget);
//     expect(find.text("Escolher hora"), findsOneWidget);
//     expect(find.text("Salvar lembrete"), findsOneWidget);
//   });

//   testWidgets('Mostra Snackbar ao tentar salvar sem preencher', (
//     WidgetTester tester,
//   ) async {
//     await tester.pumpWidget(MaterialApp(home: LembreteScreen()));

//     // Tenta clicar em salvar sem preencher nada
//     await tester.tap(find.text("Salvar lembrete"));
//     await tester.pump(); // Atualiza a tela

//     expect(find.text("Preencha título, data e hora"), findsOneWidget);
//   });

//   testWidgets('Chama LembreteService ao salvar lembrete', (
//     WidgetTester tester,
//   ) async {
//     await tester.pumpWidget(
//       MaterialApp(home: LembreteScreen(lembreteService: mockService)),
//     );

//     await tester.enterText(find.byType(TextField).at(0), "Teste");
//     await tester.enterText(find.byType(TextField).at(1), "Descrição teste");

//     // Simule seleção de data/hora via métodos públicos ou interação

//     when(
//       () => mockService.adicionarLembrete(any(), any(), any(), any()),
//     ).thenAnswer((_) async {});

//     await tester.tap(find.text("Salvar lembrete"));
//     await tester.pump();

//     verify(
//       () => mockService.adicionarLembrete(
//         "Teste",
//         "Descrição teste",
//         any(),
//         false,
//       ),
//     ).called(1);
//     expect(find.text("Lembrete salvo com sucesso!"), findsOneWidget);
//   });
// }
