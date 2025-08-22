import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projetos_3/widgets/appbar.dart';
import 'package:projetos_3/widgets/navbar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      body: Center(
        child: TextButton(
          style: TextButton.styleFrom(
            minimumSize: Size(200.w, 200.h),
            backgroundColor: const Color.fromARGB(255, 241, 185, 204),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100.r),
            ),
          ),
          onPressed: (){

        }, child: Text("Botão do Rafael")),
      ),

      bottomNavigationBar: const Navbar(currentRoute: "/home"),
    );
  }
}
