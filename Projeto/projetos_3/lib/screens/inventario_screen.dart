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
  ];

  final TextEditingController _controller_search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
          child: Column(
            children: [
              SizedBox(height: 20.h),

              // Área do input
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller_search,
                      decoration: InputDecoration(
                        labelText: 'Pesquisar produto',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 20.w),

                  ElevatedButton(
                    onPressed: () {
                      if (_controller_search.text.isNotEmpty) {}
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 6,
                      shadowColor: Colors.black.withOpacity(0.2),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Icon(Icons.search, size: 16.sp),
                  ),
                ],
              ),

              SizedBox(height: 40.h),

              // Lista de produtos
              SizedBox(
                height: 72.h * 5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    itemCount: produtos.length,
                    itemBuilder: (context, index) {
                      return InventarioItens(produto: produtos[index]);
                    },
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              // Botão adicionar item
              TextButton(
                style: TextButton.styleFrom(
                  minimumSize: Size(130.w, 40.h),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    // Define o formato do botão
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () {
                  TextEditingController nomeController =
                      TextEditingController();
                  TextEditingController quantidadeController =
                      TextEditingController(text: "1");

                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Adicionar Produto'),
                        content: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextField(
                              controller: nomeController,
                              decoration: InputDecoration(
                                labelText: 'Nome do Produto',
                              ),
                            ),
                            TextField(
                              controller: quantidadeController,
                              decoration: InputDecoration(
                                labelText: 'Quantidade',
                              ),
                              keyboardType: TextInputType.number,
                            ),
                          ],
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              String nome = nomeController.text.trim();
                              int? quantidade = int.tryParse(
                                quantidadeController.text,
                              );

                              if (nome.isNotEmpty &&
                                  quantidade != null &&
                                  quantidade > 0) {
                                setState(() {
                                  final indexExistente = produtos.indexWhere(
                                    (p) =>
                                        p.nome.toLowerCase() ==
                                        nome.toLowerCase(),
                                  );

                                  if (indexExistente != -1) {
                                    // se já existe, só soma a quantidade
                                    // produtos[indexExistente].quantidade +=
                                    //     quantidade;
                                  } else {
                                    // Se nao existir, adiciona novo produto
                                    produtos.add(
                                      Produto(
                                        id: DateTime.now().toString(),
                                        nome: nome,
                                        quantidade: quantidade,
                                      ),
                                    );
                                  }
                                });
                                Navigator.of(context).pop();
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Preencha os campos corretamente",
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text('Salvar'),
                          ),
                        ],
                      );
                    },
                  );
                },
                child: Text("Adicionar Item"),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: const Navbar(currentRoute: "/inventario"),
    );
  }
}
