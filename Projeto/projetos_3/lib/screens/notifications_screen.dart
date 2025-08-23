import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/Notificacao_itens.dart';
import '../services/lembrete.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  List<Map<String, dynamic>> _lembretes = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _carregarLembretes();
  }

  Future<void> _carregarLembretes() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final lembretes = await LembreteService().getLembretesDoUsuario();

      final agora = DateTime.now();

      // Filtra lembretes não expirados
      final lembretesValidos = <Map<String, dynamic>>[];

      for (var lembrete in lembretes) {
        final rawData = lembrete['data'];
        DateTime data;

        if (rawData is Timestamp) {
          data = rawData.toDate();
        } else if (rawData is String) {
          data = DateTime.tryParse(rawData) ?? agora;
        } else {
          data = agora;
        }

        if (data.isBefore(agora)) {
          // Deleta expirados e ignora
          final id = lembrete['id'] as String?;
          if (id != null) {
            await LembreteService().deletarLembrete(id);
          }
        } else {
          lembretesValidos.add(lembrete);
        }
      }

      setState(() {
        _lembretes = lembretesValidos;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _isLoading = false;
      });
    }
  }

  Future<void> _deletarLembreteNaTela(String id) async {
    try {
      await LembreteService().deletarLembrete(id);
      setState(() {
        _lembretes.removeWhere((lembrete) => lembrete['id'] == id);
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao deletar lembrete: $e')));
    }
  }

  String _tempoDecorrido(DateTime data) {
    final agora = DateTime.now();
    final hoje = DateTime(agora.year, agora.month, agora.day);
    final dataBase = DateTime(data.year, data.month, data.day);
    final diferenca = dataBase.difference(hoje).inDays;

    final horaFormatada = DateFormat('HH:mm').format(data);

    if (diferenca == 0) {
      return 'Hoje às $horaFormatada';
    } else if (diferenca == 1) {
      return 'Amanhã às $horaFormatada';
    } else {
      final dataFormatada = DateFormat('dd/MM/yyyy').format(data);
      return '$dataFormatada às $horaFormatada';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (_error != null) {
      return Scaffold(body: Center(child: Text('Erro: $_error')));
    }

    if (_lembretes.isEmpty) {
      return const Scaffold(
        body: Center(child: Text('Nenhum lembrete encontrado.')),
      );
    }

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
        child: RefreshIndicator(
          onRefresh: _carregarLembretes,
          child: ListView.separated(
            itemCount: _lembretes.length,
            separatorBuilder: (_, __) => SizedBox(height: 16.h),
            itemBuilder: (context, index) {
              final lembrete = _lembretes[index];
              final titulo = lembrete['titulo'] ?? 'Sem título';
              final descricao = lembrete['descricao'] ?? 'Evento pendente';
              final bool importante = lembrete['importante'] ?? false;
              final id = lembrete['id'] as String?;

              DateTime data = DateTime.now();
              final rawData = lembrete['data'];
              if (rawData is Timestamp) {
                data = rawData.toDate();
              } else if (rawData is String) {
                data = DateTime.tryParse(rawData) ?? DateTime.now();
              }

              final tempo = _tempoDecorrido(data);

              return Dismissible(
                key: Key(id ?? index.toString()),
                direction: DismissDirection.endToStart,
                background: Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  color: Colors.red,
                  child: const Icon(Icons.delete, color: Colors.white),
                ),
                onDismissed: (_) {
                  if (id != null) {
                    _deletarLembreteNaTela(id);
                  }
                },
                child: NotificacaoItem(
                  titulo: titulo,
                  descricao: descricao,
                  tempo: tempo,
                  importante: importante,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
