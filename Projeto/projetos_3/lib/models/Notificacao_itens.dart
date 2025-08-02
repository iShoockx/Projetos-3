import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NotificacaoItem extends StatelessWidget {
    /*
    Essa classe renderiza cada uma das notificações dentro da página
    */

  final String titulo;
  final String tempo;

  const NotificacaoItem({super.key, required this.titulo, required this.tempo});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.sp),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(titulo, style: TextStyle(fontSize: 16.sp)),
          Text(tempo, style: TextStyle(fontSize: 14, color: Colors.grey)),
        ],
      ),
    );
  }
}
