import 'package:flutter/material.dart';
import '../models/produto.dart';
import '../services/itens.dart';

/// InventarioItens - Item da lista de inventário
///
/// Componente que representa um produto no inventário com:
/// - Funcionalidade de edição in-line
/// - Opção de exclusão com confirmação implícita
/// - Exibição de nome e quantidade
/// - Integração direta com Firestore
///
/// **Funcionalidades:**
/// - Modal de edição com formulário
/// - Atualização em tempo real no Firebase
/// - Exclusão com feedback visual
/// - Interface compacta e intuitiva
///
/// **Integração:**
/// - Firestore para operações CRUD
/// - Serviço `itens.dart` para gerenciamento
/// - Modelo `Produto` para estrutura de dados

class InventarioItens extends StatelessWidget {
  final Produto produto;

  const InventarioItens({super.key, required this.produto});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 6,
      ), // controla espaço lateral

      title: Text(produto.nome),
      subtitle: Text('Quantidade: ${produto.quantidade}'),

      trailing: Row(
        mainAxisSize: MainAxisSize.min, // evita ocupar todo o espaço
        children: [
          // Botão de editar
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              TextEditingController controller = TextEditingController(
                text: produto.nome,
              );
              TextEditingController quantityController = TextEditingController(
                text: produto.quantidade.toString(),
              );

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
                          decoration: const InputDecoration(
                            labelText: 'Nome do Produto',
                          ),
                        ),
                        TextField(
                          controller: quantityController,
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
                          final novoNome = controller.text.trim();
                          final novaQuantidade =
                              int.tryParse(quantityController.text) ??
                              produto.quantidade;

                          if (novoNome.isNotEmpty) {
                            // 🔗 Atualiza no Firestore
                            await updateItem(
                              produto.id,
                              novoNome,
                              novaQuantidade,
                            );
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
