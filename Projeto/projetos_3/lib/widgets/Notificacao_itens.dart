import 'package:flutter/material.dart';
import '../services/lembrete.dart';

/// Um widget que exibe um lembrete/aviso com título, descrição e tempo.
///
/// - Mostra um ícone diferente se o lembrete for [importante].
/// - Exibe um botão de fechar (X) no canto superior direito, 
///   que remove o lembrete do banco via [LembreteService].
/// - Pode notificar o pai via callback [onDelete] após exclusão.
class NotificacaoItem extends StatelessWidget {
  /// ID do lembrete no banco de dados (Firebase).
  final String? id;

  /// Título do lembrete exibido em destaque.
  final String titulo;

  /// Texto descritivo do lembrete.
  final String descricao;

  /// Informação sobre o tempo (ex: "há 2h", "ontem", "10/08").
  final String tempo;

  /// Se `true`, destaca o lembrete como importante
  /// (com borda azul e ícone de alarme).
  final bool importante;

  /// Função callback opcional chamada após a exclusão.
  final VoidCallback? onDelete;

  /// Cria um item de notificação/lembrete estilizado.
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
        // Container principal do lembrete
        Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          margin: const EdgeInsets.only(top: 8, right: 8),
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

              // Texto do lembrete
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// Título
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

                    /// Descrição
                    Text(
                      descricao,
                      style: const TextStyle(fontSize: 14),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),

                    /// Tempo
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

        // Botão de fechar (X)
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

                  // Notifica o pai se necessário
                  onDelete?.call();
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
