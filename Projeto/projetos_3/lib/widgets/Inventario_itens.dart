import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projetos_3/models/produto.dart';

class InventarioItens extends StatefulWidget {
  final Produto produto;

  const InventarioItens({super.key, required this.produto});

  @override
  State<InventarioItens> createState() => _InventarioItensState();
}

class _InventarioItensState extends State<InventarioItens> {
  late int quantidade;

  @override
  void initState() {
    super.initState();
    quantidade = widget.produto.quantidade; // inicia com a quantidade do produto
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.h,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black, width: 1.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100.w,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.produto.nome,
                    style: const TextStyle(fontWeight: FontWeight.w800)),
                Text(quantidade.toString(),
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),

          // Botão de +
          ElevatedButton(
            onPressed: () {
              setState(() {
                quantidade++;
              });
            },
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: EdgeInsets.all(8.w),
              backgroundColor:Colors.transparent,
            ),
            child: const Text('+'),
          ),

          // Botão de -
          ElevatedButton(
            onPressed: () {
              setState(() {
                if (quantidade > 0) quantidade--;
              });
            },
            child: const Text('-'),
          ),

          const Icon(Icons.delete),
        ],
      ),
    );
  }
}
