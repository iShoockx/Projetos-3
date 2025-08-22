import 'package:flutter/material.dart';
import 'package:projetos_3/models/produto.dart';
import 'package:projetos_3/services/itens.dart';

class InventarioItens extends StatelessWidget {
  final Produto produto;

  const InventarioItens({
    super.key,
    required this.produto,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 6), // controla espaço lateral
      
      title: Text(produto.nome),
      subtitle: Text('Quantidade: ${produto.quantidade}'),
      
      trailing:  Row(
        mainAxisSize: MainAxisSize.min, // evita ocupar todo o espaço
        children: [
          // Botão de editar
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              TextEditingController controller = TextEditingController(text: produto.nome);
              TextEditingController quantityController = TextEditingController(text: produto.quantidade.toString());
              
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Editar Produto'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: controller,
                          decoration: const InputDecoration(labelText: 'Nome do Produto'),
                        ),
                        TextField(
                          controller: quantityController,
                          decoration: const InputDecoration(labelText: 'Quantidade'),
                          keyboardType: TextInputType.number,
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () async {
                          final novoNome = controller.text.trim();
                          final novaQuantidade = int.tryParse(quantityController.text) ?? produto.quantidade;

                          if (novoNome.isNotEmpty) {
                            // 🔗 Atualiza no Firestore
                            await updateItem(produto.id, novoNome, novaQuantidade); 
                          
                          }

                          Navigator.of(context).pop();
                        },
                        child: const Text('Salvar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),

          // Botão de delete
          IconButton( 
            icon: const Icon(Icons.delete, color: Colors.black),
            onPressed: () async {
              await deleteItem(produto.id); // 🔗 Remove do Firestore
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${produto.nome} removido do inventário'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
