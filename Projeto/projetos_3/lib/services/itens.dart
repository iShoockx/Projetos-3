import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetos_3/cache/user_cache.dart';

final db = FirebaseFirestore.instance;

// /// CREATE
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


/// READ
Stream<List<Map<String, dynamic>>> getItens() {
  return db.collection('Itens').snapshots().map(
    (snapshot) => snapshot.docs.map(
      (doc) => {
        'id_item': doc.id,         // <-- aqui pega o id aleatório do Firebase
        ...doc.data(),        // <-- aqui espalha os outros campos do doc
      },
    ).toList(),
  );
}

/// UPDATE
Future<void> updateItem(String id, String novoNome, int novaQuantidade) async {
  await db.collection('Itens').doc(id).update({
    'nome': novoNome,
    'quantidade': novaQuantidade,
  });
}

/// DELETE
Future<void> deleteItem(String id) async {
  await db.collection('Itens').doc(id).delete();
}

