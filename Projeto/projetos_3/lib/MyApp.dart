import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/inventario_screen.dart';
import 'screens/Lembrete_screen.dart';
import 'screens/usuario_screen.dart';
import 'services/auth.dart';

/// Widget raiz do aplicativo.
///
/// - Define a **configuração global** do app (tema, título e estilo).
/// - Inicializa o [ScreenUtilInit] para ajustar dimensões e textos
///   de acordo com diferentes tamanhos de tela.
/// - Configura as **rotas de navegação** usadas em todo o app:
///   - `/` → [SplashScreen]
///   - `/login` → [LoginScreen]
///   - `/home` → [HomeScreen]
///   - `/inventario` → [InventarioScreen]
///   - `/Lembrete` → [LembreteScreen]
///   - `/usuario` → [UsuarioScreen] (dependente de [AuthService])
///
/// Essa classe é chamada pelo `runApp()` dentro de `main.dart`.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X como base
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, _) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Tec Frio',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/login': (context) => const LoginScreen(),
          '/home': (context) => const HomeScreen(),
          '/inventario': (context) => const InventarioScreen(),
          '/Lembrete': (context) => const LembreteScreen(),
          '/usuario': (context) => UsuarioScreen(authService: AuthService()),
        },
      ),
    );
  }
}
