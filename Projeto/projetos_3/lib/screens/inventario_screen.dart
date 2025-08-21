import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projetos_3/widgets/inventario_itens.dart';
import 'package:projetos_3/widgets/appbar.dart';
import 'package:projetos_3/widgets/navbar.dart';
import 'package:projetos_3/models/produto.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  // Lista inicial de produtos
  final List<Produto> produtos = [
    Produto(id: '1', nome: 'Chave de fenda', quantidade: 10),
    Produto(id: '2', nome: 'Martelo', quantidade: 5),
    Produto(id: '3', nome: 'Alicate', quantidade: 7),
    Produto(id: '3', nome: 'Alicate', quantidade: 7),
    Produto(id: '3', nome: 'Alicate', quantidade: 7),
    Produto(id: '3', nome: 'Alicate', quantidade: 7),
    Produto(id: '3', nome: 'Alicate', quantidade: 7),
    Produto(id: '3', nome: 'Alicate', quantidade: 7),
  ];

  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            // Área do input
            Row(
              
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      labelText: 'Novo produto',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 20.w),

                ElevatedButton(
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      setState(() { // padrao para adicionar itens a lista
                        produtos.add(
                          Produto(
                            id: DateTime.now().toString(),
                            nome: _controller.text,
                            quantidade: 1,
                          ),
                        );
                        _controller.clear(); // limpa o campo após adicionar
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    elevation: 6,
                    shadowColor: Colors.black.withOpacity(0.2),
                    backgroundColor: Colors.lightBlue.shade100,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: const Text('+'),
                ),
              ],
            ),

            SizedBox(height: 40.h),

            // Lista de produtos
            SizedBox(
              height: 68.h * 4, // altura de 5 itens
              child: Container( 
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade100,
                  borderRadius: BorderRadius.circular(12.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  itemCount: produtos.length,
                  itemBuilder: (context, index) {
                    return InventarioItens(produto: produtos[index]);
                  },
                ),
              ),
            ),
          ],
        ),
      ),

      bottomNavigationBar: const Navbar(currentRoute: "/inventario"),
    );
  }
}
