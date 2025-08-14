import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InventarioItens extends StatelessWidget {
    /*
    Essa classe renderiza dentro do inventário uma linha para cada item cadastrado
    */
    const InventarioItens({super.key, required int index});

    @override
    Widget build(BuildContext context) {
        return Container(
            height: 60.h,
            decoration: const BoxDecoration(
                border: Border(
                bottom: BorderSide(
                    color: Colors.black, // cor da borda inferior
                    width: 1.0, // espessura da borda inferior
                ),
                ),
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                    Text('Nome', style: TextStyle(fontWeight: FontWeight.w800)),
                    Text('Descrição'),
                    ],
                ),
                const Text('0'),
                const Text('+'),
                const Text('-'),
                const Icon(Icons.delete),
                ],
            ),
        );
    }
}
