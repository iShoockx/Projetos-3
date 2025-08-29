import 'package:cloud_firestore/cloud_firestore.dart';
import '../cache/user_cache.dart';

/// Instância global do Firestore para manipulação dos dados.
/// 
/// Evita a criação repetida de instâncias ao longo do app.
final db = FirebaseFirestore.instance;


/// CREATE — adiciona um novo item na coleção `Itens` do Firestore.
///
/// O item fica vinculado ao usuário atual, obtido a partir do [UserCache].
/// 
/// - Parâmetros:
///   - [nome]: Nome do item.
///   - [quantidade]: Quantidade inicial do item.
/// 
/// - Exceções:
///   - Lança [Exception] caso não encontre o usuário no cache.
///   - Lança [Exception] se ocorrer erro durante a escrita no Firestore.
Future<void> addItem(String nome, int quantidade) async {
  try {
    final userId = await UserCache.getUid();
    if (userId == null) {
      throw Exception('Usuário não encontrado no cache.');
    }
    await db.collection('Itens').add({
      'nome': nome,
      'quantidade': quantidade,
      'userID': userId, 
    });
  } catch (e) {
    throw Exception('Erro ao obter usuário do cache: $e');
  }
}


/// READ — retorna os itens vinculados ao usuário atual como um [Stream].
///
/// O stream é atualizado em tempo real conforme o Firestore sofre alterações.
/// 
/// Cada item retornado é um `Map<String, dynamic>` com as chaves:
/// - `'id_item'`: ID do documento no Firestore.
/// - `'nome'`: Nome do item.
/// - `'quantidade'`: Quantidade do item.
/// - `'userID'`: ID do usuário dono do item.
/// 
/// - Exceções:
///   - Lança [Exception] caso o usuário não esteja presente no cache.
Stream<List<Map<String, dynamic>>> getItens() async* {
  final userId = await UserCache.getUid();
  if (userId == null) {
    throw Exception('Usuário não encontrado no cache.');
  }

  yield* db
      .collection('Itens')
      .where('userID', isEqualTo: userId)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs.map(
          (doc) => {
            'id_item': doc.id,
            ...doc.data(),
          },
        ).toList(),
      );
}


/// UPDATE — atualiza o [nome] e a [quantidade] de um item específico.
///
/// - Parâmetros:
///   - [id]: ID do documento a ser atualizado.
///   - [novoNome]: Novo nome do item.
///   - [novaQuantidade]: Nova quantidade do item.
/// 
/// - Exceções:
///   - Pode lançar [FirebaseException] se o documento não existir ou a
///     conexão com o Firestore falhar.
Future<void> updateItem(String id, String novoNome, int novaQuantidade) async {
  await db.collection('Itens').doc(id).update({
    'nome': novoNome,
    'quantidade': novaQuantidade,
  });
}


/// DELETE — remove um item da coleção `Itens` pelo seu [id].
///
/// - Parâmetros:
///   - [id]: ID do documento a ser excluído.
/// 
/// - Exceções:
///   - Pode lançar [FirebaseException] se o documento não existir ou a
///     conexão com o Firestore falhar.
Future<void> deleteItem(String id) async {
  await db.collection('Itens').doc(id).delete();
}
