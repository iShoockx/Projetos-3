import 'package:flutter/material.dart';

class NotificacaoItem extends StatelessWidget {
  /*
    Essa classe renderiza cada uma das notificações dentro da página
    */

  final String titulo;
  final String descricao;
  final String tempo;
  final bool importante;

  const NotificacaoItem({
    super.key,
    required this.titulo,
    required this.descricao,
    required this.tempo,
    required this.importante,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
                    color: importante ? Colors.black : Colors.black,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  descricao,
                  style: const TextStyle(fontSize: 14),
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
    );
  }
}
