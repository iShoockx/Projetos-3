import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Navbar extends StatelessWidget {
  final String currentRoute;

  const Navbar({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.only(bottom: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(context,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                route: '/home',
                label: "Início"),
            _buildNavItem(context,
                icon: Icons.inventory_2_outlined,
                activeIcon: Icons.inventory_2,
                route: '/inventario',
                label: "Inventário"),
            _buildNavItem(context,
                icon: Icons.event_note_outlined,
                activeIcon: Icons.event_note,
                route: '/Lembrete',
                label: "Lembrete"),
            _buildNavItem(context,
                icon: Icons.person_outline,
                activeIcon: Icons.person,
                route: '/andamento',
                label: "Perfil"),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context,
      {required IconData icon,
      required IconData activeIcon,
      required String route,
      required String label}) {
    final bool isActive = currentRoute == route;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (!isActive) {
            Navigator.pushReplacementNamed(context, route);
          }
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 🔹 Faixa preenchendo a borda superior
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: 3.h,
              width: double.infinity,
              color: isActive ? Colors.blue : Colors.transparent,
            ),
            SizedBox(height: 6.h),
            Icon(
              isActive ? activeIcon : icon,
              size: isActive ? 28.sp : 24.sp,
              color: isActive ? Colors.blue : Colors.black,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                color: isActive ? Colors.blue : Colors.black,
              ),
            )
          ],
        ),
      ),
    );
  }
}
