import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegistrarScreen extends StatefulWidget {
  const RegistrarScreen({Key? key}) : super(key: key);

  @override
  State<RegistrarScreen> createState() => _RegistrarScreenState(); // necessario para StatefulWidget criação de estado
}

class _RegistrarScreenState extends State<RegistrarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold é o layout básico do Material Design
      appBar: AppBar(
        elevation: 2,
        backgroundColor: Colors.white,
        title: Row(
          children: [
            Text(
              'Tec Frio',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 22.sp,
              ),
            ),
            SizedBox(width: 5.w),
            const Icon(Icons.ac_unit, color: Colors.blue),
          ],
        ),
      ),
      body: Padding(
        // Corpo do texto
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          // Coluna para organizar os widgets verticalmente
          mainAxisAlignment:
              MainAxisAlignment.center, // Centraliza verticalmente
          children: [
            // Comando para adicionar widgets
            const TextField(
              // Campo de texto para o usuário
              decoration: InputDecoration(
                labelText: 'Usuário',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            const TextField(
              // campo de texto para a senha
              obscureText: true, // Esconde o texto digitado
              decoration: InputDecoration(
                labelText: 'Senha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),
            SizedBox(height: 10.h),
            const TextField(
              // campo de texto para a senha
              obscureText: true, // Esconde o texto digitado
              decoration: InputDecoration(
                labelText: 'Nova Senha',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
              ),
            ),

            SizedBox(height: 10.h),

            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/home');
              },

              style: ElevatedButton.styleFrom(
                elevation: 6,
                shadowColor: Colors.black.withOpacity(0.2),
                backgroundColor: Colors.grey[300],
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 15,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text('criar conta'),
            ),
          ],
        ),
      ),
    );
  }
}
