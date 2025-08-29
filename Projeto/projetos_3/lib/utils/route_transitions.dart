import 'package:flutter/material.dart';

/// Cria uma animação de transição **deslizando da direita para a esquerda**.
///
/// Essa função retorna um [PageRoute] personalizado com um
/// [SlideTransition], útil para navegação entre páginas com um efeito
/// mais fluido do que o padrão.
///
/// ### Exemplo de uso:
/// ```dart
/// Navigator.push(
///   context,
///   slideFromRight(const NotificacoesPage()),
/// );
/// ```
///
/// - [page] → O widget da página de destino.
///
/// Retorna um [PageRoute] configurado com a animação de slide.
Route slideFromRight(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0); // Começa fora da tela, à direita
      const end = Offset.zero;        // Termina na posição normal
      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: Curves.easeInOut),
      );
      final offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}
