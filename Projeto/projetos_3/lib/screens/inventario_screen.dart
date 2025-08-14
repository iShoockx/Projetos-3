import 'package:flutter/material.dart';
import 'package:projetos_3/widgets/Inventario_itens.dart';
import 'package:projetos_3/widgets/appbar.dart';
import 'package:projetos_3/widgets/navbar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      // Corpo da página
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //Área do input
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Campo de texto para o usuário
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'Novo produto',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 20.w), // espaço entre campo e botão
                //botão
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 10.h),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },

                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      shadowColor: Colors.black.withOpacity(0.2),
                      backgroundColor: Colors.lightBlue,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('+'),
                  ),
                ),
              ],
            ),

            SizedBox(height: 20.h),

            //Renderização da lista com os materiais
            Container(
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(12.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 6,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              height: 300.h,
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                children: List.generate(
                  3,
                  (index) => InventarioItens(index: index),
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: Navbar(),
    );
  }
}
