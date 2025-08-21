import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projetos_3/models/produto.dart';

class InventarioItens extends StatelessWidget {
  final Produto produto;

  const InventarioItens({
    Key? key,
    required this.produto,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(produto.nome),
      subtitle: Text('Quantidade: ${produto.quantidade}'),
      trailing: Padding(
        padding: const EdgeInsets.only(left: 16.0), // espaçamento à direita),
        child: Row(
          
          mainAxisSize: MainAxisSize.min, // evita ocupar todo o espaço
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () {
                // Ação para editar o item
                TextEditingController controller =
                    TextEditingController(text: produto.nome);
                TextEditingController quantityController =
                    TextEditingController(text: produto.quantidade.toString());
        
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Editar Produto'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: controller,
                            decoration:
                                InputDecoration(labelText: 'Nome do Produto'),
                          ),
                          TextField(
                            controller: quantityController,
                            decoration: InputDecoration(labelText: 'Quantidade'),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            // Ação para salvar as alterações
                            // Aqui você pode atualizar os valores do produto
                            Navigator.of(context).pop();
                          },
                          child: Text('Salvar'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.black),
              onPressed: () {
                // Ação para remover o item
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${produto.nome} removido do inventário'),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
