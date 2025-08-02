import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projetos_3/screens/notifications_screen.dart';
import 'package:projetos_3/utils/route_transitions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /*
    Essa classe define a appbar superior do aplicativo para deixar o desing igual para todas as páginas e reciclar linhas de códigos idênticas, facilitando a reparação de erros futuros 
  */

  const CustomAppBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 2),
            spreadRadius: 1.0,
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Título + ícone
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: const [
                  Text(
                    'Tec Frio',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  SizedBox(width: 5),
                  Icon(Icons.ac_unit, color: Colors.blue),
                ],
              ),
            ),

            // Ícone do sino
            Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.black),
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(slideFromRight(const NotificationsScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
