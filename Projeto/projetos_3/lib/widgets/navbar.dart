import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Um widget de barra de navegação inferior (navbar) personalizada.
///
/// A Navbar exibe quatro itens principais: **Início**, **Inventário**,
/// **Lembrete** e **Perfil**. Cada ícone muda de cor e estilo quando ativo,
/// e a rota correspondente é aberta ao ser clicado.
///
/// O item ativo é destacado com:
/// - Uma faixa azul na parte superior
/// - Ícone preenchido e maior
/// - Texto em negrito e azul
class Navbar extends StatelessWidget {
  /// Rota atual usada para determinar qual item deve estar ativo.
  final String currentRoute;

  /// Construtor da Navbar.
  ///
  /// O parâmetro [currentRoute] é obrigatório e deve corresponder
  /// a uma das rotas registradas no MaterialApp.routes.

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
            _buildNavItem(
              context,
              icon: Icons.home_outlined,
              activeIcon: Icons.home,
              route: '/home',
              label: "Início",
            ),
            _buildNavItem(
              context,
              icon: Icons.inventory_2_outlined,
              activeIcon: Icons.inventory_2,
              route: '/inventario',
              label: "Inventário",
            ),
            _buildNavItem(
              context,
              icon: Icons.event_note_outlined,
              activeIcon: Icons.event_note,
              route: '/Lembrete',
              label: "Lembrete",
            ),
            _buildNavItem(
              context,
              icon: Icons.person_outline,
              activeIcon: Icons.person,
              route: '/usuario',
              label: "Perfil",
            ),
          ],
        ),
      ),
    );
  }

  /// Constrói um item de navegação da [Navbar].
  ///
  /// - [icon]: ícone exibido quando o item não está ativo.
  /// - [activeIcon]: ícone exibido quando o item está ativo.
  /// - [route]: rota que será aberta ao clicar no item.
  /// - [label]: texto descritivo exibido abaixo do ícone.
  Widget _buildNavItem(
    BuildContext context, {
    required IconData icon,
    required IconData activeIcon,
    required String route,
    required String label,
  }) {
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
            /// Linha azul no topo indicando o item ativo.
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              height: 3.h,
              width: double.infinity,
              color: isActive ? Colors.blue : Colors.transparent,
            ),
            SizedBox(height: 6.h),

            /// Ícone do item de navegação.
            Icon(
              isActive ? activeIcon : icon,
              size: isActive ? 28.sp : 24.sp,
              color: isActive ? Colors.blue : Colors.black,
            ),
            SizedBox(height: 4.h),

            /// Texto do item de navegação.
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
