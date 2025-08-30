// Importa a biblioteca do Firebase Firestore para manipulação de dados na nuvem
import 'package:cloud_firestore/cloud_firestore.dart';
// Importa o cache de usuário, que contém métodos para recuperar o UID do usuário logado
import '../cache/user_cache.dart';

// Define um tipo para função que retorna o UID do usuário de forma assíncrona
typedef GetUidFn = Future<String?> Function();

/// Serviço responsável por gerenciar lembretes do usuário.
/// 
/// Este serviço encapsula operações de CRUD (criar, ler, deletar) 
/// de lembretes no Firestore, garantindo que cada lembrete esteja associado
/// a um usuário específico.
class LembreteService {
  /// Referência para a coleção 'Lembretes' no Firestore
  final CollectionReference lembretesCollection;

  /// Função usada para obter o UID do usuário atual
  final GetUidFn _getUid;

  /// Construtor do serviço
  /// 
  /// Permite a injeção de uma coleção customizada e função de UID para testes.
  /// Se não forem fornecidos, usa a coleção padrão 'Lembretes' e a função
  /// `UserCache.getUid`.
  LembreteService({CollectionReference? collection, GetUidFn? getUid})
      : lembretesCollection =
            collection ?? FirebaseFirestore.instance.collection('Lembretes'),
        _getUid = getUid ?? UserCache.getUid; // usa o método atual por padrão

  /// Adiciona um novo lembrete para o usuário atual
  /// 
  /// Parâmetros:
  /// - [titulo]: título do lembrete
  /// - [descricao]: descrição detalhada
  /// - [dataHora]: data e hora do lembrete
  /// - [isImportant]: indica se o lembrete é importante
  Future<void> adicionarLembrete(
    String titulo,
    String descricao,
    DateTime dataHora,
    bool isImportant,
  ) async {
    try {
      // Recupera o UID do usuário atual
      final userId = await _getUid();
      if (userId == null) {
        throw Exception('Usuário não encontrado no cache.');
      }

      // Adiciona o lembrete no Firestore com os campos fornecidos
      await lembretesCollection.add({
        'titulo': titulo,
        'descricao': descricao,
        'data': Timestamp.fromDate(dataHora),
        'userID': userId,
        'importante': isImportant,
      });
    } catch (e) {
      // Lança uma exceção caso ocorra algum erro
      throw Exception('Erro ao adicionar lembrete: $e');
    }
  }

  /// Recupera todos os lembretes do usuário atual
  /// 
  /// Retorna uma lista de mapas contendo os dados dos lembretes, ordenados
  /// da data mais recente para a mais antiga.
  Future<List<Map<String, dynamic>>> getLembretesDoUsuario() async {
    try {
      // Recupera o UID do usuário atual
      final userId = await _getUid();
      if (userId == null) {
        throw Exception('Usuário não encontrado no cache.');
      }

      // Consulta os lembretes no Firestore filtrando pelo UID do usuário
      final query = await lembretesCollection
          .where('userID', isEqualTo: userId)
          .get();

      // Mapeia os documentos para listas de mapas e adiciona o ID do documento
      final lembretes = query.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        data['id'] = doc.id;
        return data;
      }).toList();

      // Ordena os lembretes da data mais recente para a mais antiga
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

  /// Deleta um lembrete pelo seu ID
  /// 
  /// Parâmetros:
  /// - [id]: ID do lembrete a ser deletado
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
