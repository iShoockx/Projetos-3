import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../screens/notifications_screen.dart';
import '../utils/route_transitions.dart';

/// CustomAppBar - Barra de aplicativo personalizada
/// 
/// Barra de navegação superior customizada com:
/// - Logo e nome da marca (Tec Frio)
/// - Ícone de notificações com navegação
/// - Animação personalizada de transição
/// - Design responsivo com ScreenUtil
/// - Implementa PreferredSizeWidget
/// 
/// **Características:**
/// - Sombra suave para efeito de profundidade
/// - SafeArea integrado para dispositivos com notch
/// - Layout responsivo com espaçamentos adaptativos
/// - Navegação com animação slideFromRight
/// - Ícone temático azul (ac_unit)

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {

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
