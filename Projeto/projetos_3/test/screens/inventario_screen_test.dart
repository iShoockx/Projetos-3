// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:projetos_3/screens/inventario_screen.dart';

// //teste de widget

// void main() {
//   testWidgets('Renderiza campo de texto e botão "Adicionar Item"', 
//       (WidgetTester tester) async {
//     await tester.pumpWidget(
//       const MaterialApp(home: InventarioScreen()),
//     );

//     expect(find.byType(TextField), findsOneWidget);

//     // Botão de adicionar item
//     expect(find.text("Adicionar Item"), findsOneWidget);
//   });

//   testWidgets('Renderiza indicador de loading ao abrir a tela',
//       (WidgetTester tester) async {
//     await tester.pumpWidget(
//       const MaterialApp(home: InventarioScreen()),
//     );

//     expect(find.byType(CircularProgressIndicator), findsOneWidget);
//   });
// }