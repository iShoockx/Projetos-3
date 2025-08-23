import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/appbar.dart';
import '../widgets/navbar.dart';
import '../cache/user_cache.dart'; 

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
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(200.w, 200.h),
                backgroundColor: const Color.fromARGB(255, 241, 185, 204),
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100.r),
                ),
              ),
              onPressed: () async {
                Navigator.pushNamed(context, "/login");
              },
              child: const Text("Botão do Rafael"),
            ),
            SizedBox(height: 20.h),
            Text(
              _uid != null ? "UID do usuário: $_uid" : "Carregando UID...",
              style: TextStyle(fontSize: 16.sp),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Navbar(currentRoute: "/home"),
    );
  }
}
