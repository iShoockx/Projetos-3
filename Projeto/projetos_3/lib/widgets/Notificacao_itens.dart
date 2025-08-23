import 'package:flutter/material.dart';
import 'package:projetos_3/services/lembrete.dart';

class NotificacaoItem extends StatelessWidget {
  final String? id;
  final String titulo;
  final String descricao;
  final String tempo;
  final bool importante;
  final VoidCallback? onDelete;

  const NotificacaoItem({
    super.key,
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.tempo,
    required this.importante,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          margin: const EdgeInsets.only(top: 8, right: 8), // Espaço para o X
          decoration: BoxDecoration(
            color: importante ? Colors.red[50] : Colors.white,
            border: Border.all(
              color: importante ? Colors.blue : Colors.grey.shade300,
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                importante ? Icons.access_alarms : Icons.notifications_none,
                color: importante ? Colors.blue : Colors.grey,
                size: 24,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      titulo,
                      style: TextStyle(
                        fontWeight: importante
                            ? FontWeight.bold
                            : FontWeight.normal,
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      descricao,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      tempo,
                      style: TextStyle(color: Colors.grey[600], fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Botão X no canto superior direito
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () async {
              if (id != null) {
                try {
                  await LembreteService().deletarLembrete(id);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Lembrete removido'),
                      duration: Duration(seconds: 2),
                    ),
                  );

                  // Notifica o widget parent se necessário
                  if (onDelete != null) {
                    onDelete!();
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Erro ao remover lembrete: $e'),
                      backgroundColor: Colors.red,
                      duration: const Duration(seconds: 3),
                    ),
                  );
                }
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('ID do lembrete não encontrado'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
            },
            child: Container(
              width: 28,
              height: 28,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                shape: BoxShape.circle,
                border: Border.all(
                  color: importante ? Colors.blue : Colors.grey,
                  width: 1,
                ),
              ),
              child: Icon(
                Icons.close,
                color: importante ? Colors.blue : Colors.grey[700],
                size: 18,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
