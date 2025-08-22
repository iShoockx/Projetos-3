// import 'package:cloud_firestore/cloud_firestore.dart';

// final db = FirebaseFirestore.instance;

// // /// CREATE
// Future<void> addItem(String nome, int quantidade) async {
//   await db.collection('Itens').add({
//     'nome': nome,
//    'quantidade': quantidade,
//    'id':id
//    });
// }


// /// READ
// Stream<List<Map<String, dynamic>>> getUsers() {
//   return db.collection('Itens').snapshots().map((snapshot) =>
//     snapshot.docs.map((doc) => doc.data()).toList(),
//   );
// }

// /// UPDATE
// Future<void> updateUser(String id, String novoNome) async {
//   await db.collection('Itens').doc(id).update({'nome': novoNome});
// }

// /// DELETE
// Future<void> deleteUser(String id) async {
//   await db.collection('Itens').doc(id).delete();
// }

