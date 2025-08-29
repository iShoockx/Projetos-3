import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart'; 
import 'package:projetos_3/MyApp.dart';

/// Função principal do aplicativo.
///
/// - Garante que os bindings do Flutter estejam inicializados
///   com [WidgetsFlutterBinding.ensureInitialized].
/// - Inicializa o Firebase usando as opções definidas em
///   [DefaultFirebaseOptions.currentPlatform].
/// - Executa o widget raiz [MyApp].
///
/// O `main` é `async` porque a inicialização do Firebase é assíncrona.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  runApp(const MyApp());
}
