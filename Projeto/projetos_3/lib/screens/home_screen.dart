import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/appbar.dart';
import '../widgets/navbar.dart';
import '../cache/user_cache.dart'; 

/// Tela inicial do aplicativo exibida após o login.
///
/// Essa tela:
/// - Mostra uma saudação de boas-vindas.
/// - Recupera e mantém em memória o uid do usuário
///   armazenado em cache ([UserCache]).
/// - Possui uma [CustomAppBar] no topo e uma [Navbar] fixa na parte inferior.
///
/// O estado dessa tela é gerenciado pelo [_HomeScreenState].

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? _uid;

  @override
  void initState() {
    super.initState();
    _loadUid();
  }

  Future<void> _loadUid() async {
    final uid = await UserCache.getUid();
    setState(() {
      _uid = uid;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Bem-vindo!',
              style: TextStyle(fontSize: 24.sp),
            ),
            SizedBox(height: 20.h),
          
          ],
        ),
      ),
      bottomNavigationBar: const Navbar(currentRoute: "/home"),
    );
  }
}
