import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/inventario_screen.dart';
import 'screens/agenda_screen.dart';
import 'screens/andamento_screen.dart';


class MyApp extends StatelessWidget {
  /* 
    Essa classe tem como função colocar a personalização base do site, como seu style e sua página principal.
    Ela é chamada pelo runApp() e chama a função da home que guiara o usuário pelo seu aplicativo.
  */
  const MyApp({super.key}); //Construtor necessário para todas as classes

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812), // iPhone X base
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
          '/agenda': (context) => const AgendaScreen(),
          '/andamento': (context) => const AndamentoScreen(),
        },
      ),
    );
  }
}
