import 'package:cloud_firestore/cloud_firestore.dart';
import '../cache/user_cache.dart';

/// Serviço responsável por gerenciar os lembretes dos usuários no Firestore.
///
/// Essa classe encapsula as operações de **CRUD** sobre a coleção `Lembretes`,
/// garantindo que todas as ações sejam vinculadas ao `userID` armazenado
/// no [UserCache].  
///
/// ### Funcionalidades:
/// - Criar novos lembretes.
/// - Listar lembretes do usuário logado (ordenados por data).
/// - Deletar lembretes pelo ID.
class LembreteService {
  /// Referência para a coleção de lembretes no Firestore.
  final CollectionReference lembretesCollection =
      FirebaseFirestore.instance.collection('Lembretes');

  /// Adiciona um novo lembrete para o usuário logado.
  ///
  /// - [titulo]: Título do lembrete.
  /// - [descricao]: Descrição ou detalhes adicionais.
  /// - [dataHora]: Data e hora do lembrete.
  /// - [isImportant]: Define se o lembrete é marcado como importante.
  ///
  /// Lança uma [Exception] caso não consiga recuperar o `userID` do cache.
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

      await lembretesCollection.add({
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

  /// Retorna todos os lembretes do usuário logado.
  ///
  /// O retorno é uma lista de `Map<String, dynamic>` contendo os campos do
  /// lembrete e também o campo `id` (que corresponde ao ID do documento).
  ///
  /// A lista é ordenada manualmente pela data, exibindo primeiro os lembretes
  /// mais recentes.
  ///
  /// Lança uma [Exception] caso o usuário não seja encontrado no cache.
  Future<List<Map<String, dynamic>>> getLembretesDoUsuario() async {
    try {
      final userId = await UserCache.getUid();
      if (userId == null) {
        throw Exception('Usuário não encontrado no cache.');
      }

      final query = await lembretesCollection
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

  /// Deleta um lembrete pelo seu [id].
  ///
  /// - [id]: ID do documento do lembrete no Firestore.
  ///
  /// Caso o `id` seja `null` ou vazio, lança uma [Exception].
  Future<void> deletarLembrete(String? id) async {
    try {
      if (id == null || id.isEmpty) {
        throw Exception('ID do lembrete é inválido');
      }
      await lembretesCollection.doc(id).delete();
    } catch (e) {
      throw Exception('Erro ao deletar lembrete: $e');
    }
  }
}
