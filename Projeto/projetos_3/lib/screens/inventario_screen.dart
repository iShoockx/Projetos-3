import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projetos_3/widgets/inventario_itens.dart';
import 'package:projetos_3/widgets/appbar.dart';
import 'package:projetos_3/widgets/navbar.dart';
import 'package:projetos_3/models/produto.dart';
import 'package:projetos_3/services/itens.dart';

class InventarioScreen extends StatefulWidget {
  const InventarioScreen({super.key});

  @override
  State<InventarioScreen> createState() => _InventarioScreenState();
}

class _InventarioScreenState extends State<InventarioScreen> {
  final TextEditingController _controllerSearch = TextEditingController();
  String query = "";

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        child: Column(
          children: [
            SizedBox(height: 20.h),

            // Input de pesquisa
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controllerSearch,
                    decoration: InputDecoration(
                      labelText: 'Pesquisar produto',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onChanged: (value) {
                      // se quiser pesquisa em tempo real
                      setState(() {
                        query = value.toLowerCase();
                      });
                    },
                  ),
                ),
              ],
            ),

            SizedBox(height: 40.h),

            // Lista de produtos do Firebase
            Expanded(
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
                child: StreamBuilder<List<Map<String, dynamic>>>(
                  stream: getItens(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Erro: ${snapshot.error}"));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("Nenhum item encontrado"),
                      );
                    }

                    // Converte Maps do Firebase para Model Produto
                    final produtos = snapshot.data!
                        .map((item) => Produto.fromMap(item))
                        .toList();

                    // 🔎 aplica o filtro
                    final filtrados = produtos.where((produto) {
                      return produto.nome.toLowerCase().contains(query);
                    }).toList();

                    if (filtrados.isEmpty) {
                      return const Center(
                        child: Text("Nenhum item encontrado"),
                      );
                    }

                    return ListView.builder(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20.w,
                        vertical: 10.h,
                      ),
                      itemCount: filtrados.length,
                      itemBuilder: (context, index) {
                        return InventarioItens(produto: filtrados[index]);
                      },
                    );
                  },
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // Botão adicionar item
            // (mantive igual ao que você já tinha)
            TextButton(
              style: TextButton.styleFrom(
                minimumSize: Size(130.w, 40.h),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                TextEditingController nomeController = TextEditingController();
                TextEditingController quantidadeController =
                    TextEditingController(text: "1");
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Adicionar Produto'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: nomeController,
                            decoration: const InputDecoration(
                              labelText: 'Nome do Produto',
                            ),
                          ),
                          TextField(
                            controller: quantidadeController,
                            decoration: const InputDecoration(
                              labelText: 'Quantidade',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            String nome = nomeController.text.trim();
                            int? quantidade = int.tryParse(
                              quantidadeController.text,
                            );
                            if (nome.isNotEmpty &&
                                quantidade != null &&
                                quantidade > 0) {
                              final snapshot = await getItens().first;
                              final encontrados = snapshot
                                  .where(
                                    (item) =>
                                        item['nome'].toString().toLowerCase() ==
                                        nome.toLowerCase(),
                                  )
                                  .toList();
                              if (encontrados.isNotEmpty) {
                                final existente = encontrados.first;
                                final id = existente['id_item'];
                                if (id != null && id is String) {
                                  final novaQuantidade =
                                      (existente['quantidade'] ?? 0) +
                                      quantidade;
                                  await updateItem(id, nome, novaQuantidade);
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        "Erro ao identificar o item no banco de dados.",
                                      ),
                                    ),
                                  );
                                }
                              } else {
                                addItem(nome, quantidade);
                              }
                              Navigator.of(context).pop();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    "Preencha os campos corretamente",
                                  ),
                                ),
                              );
                            }
                          },
                          child: const Text('Salvar'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text("Adicionar Item"),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const Navbar(currentRoute: "/inventario"),
    );
  }
}
