import 'package:flutter/material.dart';
import 'package:projetos_3/widgets/appbar.dart';
import 'package:projetos_3/widgets/navbar.dart';

class AndamentoScreen extends StatelessWidget {
  const AndamentoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),

      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          //aba com as novas solicitações
          ExpansionTile(
            title: Text('Novas solicitações'),
            controlAffinity: ListTileControlAffinity.leading,
            children: [ListTile(title: Text('This is tile number 3'))],
          ),

          //aba com as operações em andamento
          ExpansionTile(
            title: Text('Em andamento'),
            controlAffinity: ListTileControlAffinity.leading,
            children: [ListTile(title: Text('This is tile number 3'))],
          ),

          //aba com as operações ja finalizadas
          ExpansionTile(
            title: Text('Finalizadas'),
            controlAffinity: ListTileControlAffinity.leading,
            children: [ListTile(title: Text('This is tile number 3'))],
          ),
        ],
      ),

      bottomNavigationBar: Navbar(),
    );
  }
}
