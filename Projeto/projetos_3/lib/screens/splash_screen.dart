import 'package:flutter/material.dart';
import 'dart:async';

/// Tela de Splash/Boas-vindas do aplicativo
/// 
/// Esta tela é exibida durante a inicialização do aplicativo e serve para:
/// - Apresentar a identidade visual da marca
/// - Realizar inicializações assíncronas necessárias
/// - Preparar o ambiente antes de navegar para a tela principal
/// - Proporcionar uma experiência profissional de carregamento
/// 
/// **Funcionalidades:**
/// - Exibição temporizada (3 segundos)
/// - Transição automática para a tela de login
/// - Interface limpa e profissional
/// - Indicador visual de carregamento
/// 
/// **Fluxo:**
/// 1. App inicia → Exibe SplashScreen
/// 2. Aguarda 3 segundos
/// 3. Navega automaticamente para /login
/// 4. Nunca retorna (pushReplacement)

class SplashScreen extends StatefulWidget {

  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.ac_unit, size: 80, color: Colors.blue),
            SizedBox(height: 20),
            Text(
              'Tec Frio',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
