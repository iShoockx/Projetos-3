import 'package:cloud_firestore/cloud_firestore.dart';
import '../cache/user_cache.dart';

class LembreteService {
  final CollectionReference _lembretesCollection = FirebaseFirestore.instance
      .collection('Lembretes');

  /// Adiciona um lembrete com título, data/hora e userID do cache
  Future<void> adicionarLembrete(
    String titulo,
    String descricao,
    DateTime dataHora,
    bool isImportant,
  ) async {
    try {
      final userId = await UserCache.getUid();
      if (userId == null) {
        throw Exception('Usuário não encontrado no cache.');
      }

      await _lembretesCollection.add({
        'titulo': titulo,
        'descricao': descricao,
        'data': Timestamp.fromDate(dataHora),
        'userID': userId,
        'importante': isImportant,
      });
    } catch (e) {
      throw Exception('Erro ao adicionar lembrete: $e');
    }
  }

  /// Resgata todos os lembretes feitos por um usuário (ordenados por data decrescente, sem índice)
  Future<List<Map<String, dynamic>>> getLembretesDoUsuario() async {
    try {
      final userId = await UserCache.getUid();
      if (userId == null) {
        throw Exception('Usuário não encontrado no cache.');
      }

      final query = await _lembretesCollection
          .where('userID', isEqualTo: userId)
          .get();

      final lembretes = query.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id; // adiciona o ID do documento
        return data;
      }).toList();

      // Ordena manualmente por data (mais recente primeiro)
      lembretes.sort((a, b) {
        final dataA = (a['data'] as Timestamp).toDate();
        final dataB = (b['data'] as Timestamp).toDate();
        return dataB.compareTo(dataA);
      });

      return lembretes;
    } catch (e) {
      throw Exception('Erro ao buscar lembretes: $e');
    }
  }

  /// Deleta um lembrete pelo ID
  Future<void> deletarLembrete(String id) async {
    try {
      await _lembretesCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Erro ao deletar lembrete: $e');
    }
  }
}
