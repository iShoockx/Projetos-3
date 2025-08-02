import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projetos_3/models/Notificacao_itens.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar( //Appbar específica para página de notificações
        title: const Text(
          'NOTIFICAÇÕES',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            NotificacaoItem(titulo: 'Alicate', tempo: '5d'), 
            //chama a renderização das notificações
            SizedBox(height: 16.h),
            NotificacaoItem(titulo: 'Manutenção', tempo: '4h'),
          ],
        ),
      ),
    );
  }
}


