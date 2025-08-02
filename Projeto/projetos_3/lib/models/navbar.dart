import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Navbar extends StatelessWidget {
  /*
    Essa classe define a appbar inferior do aplicativo para deixar o desing igual para todas as páginas e reciclar linhas de códigos idênticas, facilitando a reparação de erros futuros
    */

  const Navbar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -4), // sombra para cima
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,

          children: [
            IconButton(
              icon: Icon(Icons.home_outlined, size: 24.sp),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },
            ),
            IconButton(
              icon: Icon(Icons.inventory_2_outlined, size: 24.sp),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/inventario');
              },
            ),
            IconButton(
              icon: Icon(Icons.event_note_outlined, size: 24.sp),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/agenda');
              },
            ),
            IconButton(
              icon: Icon(Icons.person_outline, size: 24.sp),
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/andamento');
              },
            ),
          ],
        ),
      ),
    );
  }
}
