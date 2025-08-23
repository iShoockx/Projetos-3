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
            Text(
              'Bem-vindo ao Home Screen!',
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
