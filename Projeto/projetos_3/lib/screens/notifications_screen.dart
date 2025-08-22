import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:projetos_3/widgets/Notificacao_itens.dart';
import 'package:projetos_3/services/lembrete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NOTIFICAÇÕES',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 2,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<List<Map<String, dynamic>>>(
          future: LembreteService().getLembretesDoUsuario(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            final lembretes = snapshot.data ?? [];
            if (lembretes.isEmpty) {
              return const Center(child: Text('Nenhum lembrete encontrado.'));
            }

            return ListView.separated(
              itemCount: lembretes.length,
              separatorBuilder: (_, __) => SizedBox(height: 16.h),
              itemBuilder: (context, index) {
                final lembrete = lembretes[index];
                final titulo = lembrete['titulo'] ?? 'Sem título';

                //Conversão segura de Timestamp
                DateTime data = DateTime.now();
                final rawData = lembrete['data'];
                if (rawData is Timestamp) {
                  data = rawData.toDate();
                } else if (rawData is String) {
                  data = DateTime.tryParse(rawData) ?? DateTime.now();
                }

                final tempo = _tempoDecorrido(data);
                return NotificacaoItem(titulo: titulo, tempo: tempo);
              },
            );
          },
        ),
      ),
    );
  }

  /// Calcula o tempo decorrido desde a data passada e retorna como string
  String _tempoDecorrido(DateTime data) {
    final agora = DateTime.now();
    final diferenca = agora.difference(data);

    if (diferenca.inDays > 0) return '${diferenca.inDays}d';
    if (diferenca.inHours > 0) return '${diferenca.inHours}h';
    if (diferenca.inMinutes > 0) return '${diferenca.inMinutes}min';
    return 'agora';
  }
}
