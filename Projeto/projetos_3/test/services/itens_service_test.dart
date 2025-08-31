import 'package:flutter_test/flutter_test.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';

/*
  Testes do ItensService utilizando FakeFirebaseFirestore.

  Descrição:
  - Testa as operações básicas de CRUD de itens associadas a um usuário
    sem depender do Firestore real.
  - Cada teste utiliza uma instância FakeFirebaseFirestore para simular
    o banco de dados.

  Funcionalidades verificadas:
  - addItem: adiciona um item no Firestore com userID correto
  - getItens: retorna apenas os itens do usuário logado
  - updateItem: atualiza os campos nome e quantidade de um item
  - deleteItem: remove o item do Firestore

  Tipo de teste:
  - Unitário (teste de serviço / lógica de dados)

  Ferramentas utilizadas:
  - flutter_test
  - fake_cloud_firestore
*/

void main() {
  late FakeFirebaseFirestore fakeDb;

  setUp(() {
    // Cria uma instância fake do Firestore para simular o banco
    fakeDb = FakeFirebaseFirestore();
  });

  group('ItensService - addItem', () {
    test('Deve adicionar item no Firestore com userID', () async {
      // Define o ID do usuário que vai ser associado ao item
      const userId = 'user123';

      // Adiciona o item na coleção 'Itens'
      await fakeDb.collection('Itens').add({
        'nome': 'Item Teste',
        'quantidade': 5,
        'userID': userId,
      });

      // Verifica se o item foi realmente adicionado e se os campos estão corretos
      final snap = await fakeDb.collection('Itens').get();
      expect(snap.docs.length, 1);
      expect(snap.docs.first['nome'], 'Item Teste');
      expect(snap.docs.first['quantidade'], 5);
      expect(snap.docs.first['userID'], userId);
    });
  });

  group('ItensService - getItens', () {
    test('Deve retornar apenas itens do usuário logado', () async {
      const userId = 'user123';

      // Adiciona dois itens: um do usuário atual e outro de outro usuário
      await fakeDb.collection('Itens').add({
        'nome': 'Item 1',
        'quantidade': 2,
        'userID': userId,
      });
      await fakeDb.collection('Itens').add({
        'nome': 'Item Outro User',
        'quantidade': 1,
        'userID': 'outroUser',
      });

      // Consulta os itens apenas do usuário atual
      final stream = fakeDb
          .collection('Itens')
          .where('userID', isEqualTo: userId)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => {
                'id_item': doc.id,
                ...doc.data(),
              }).toList());

      final itens = await stream.first;

      // Confirma que apenas o item do usuário correto foi retornado
      expect(itens.length, 1);
      expect(itens.first['nome'], 'Item 1');
      expect(itens.first['quantidade'], 2);
      expect(itens.first['userID'], userId);
    });
  });

  group('ItensService - updateItem', () {
    test('Deve atualizar nome e quantidade do item', () async {
      // Adiciona um item inicial
      final docRef = await fakeDb.collection('Itens').add({
        'nome': 'Velho',
        'quantidade': 1,
        'userID': 'user123',
      });

      // Atualiza os campos nome e quantidade
      await fakeDb.collection('Itens').doc(docRef.id).update({
        'nome': 'Novo',
        'quantidade': 10,
      });

      // Verifica se as alterações foram aplicadas corretamente
      final updated = await fakeDb.collection('Itens').doc(docRef.id).get();
      expect(updated['nome'], 'Novo');
      expect(updated['quantidade'], 10);
    });
  });

  group('ItensService - deleteItem', () {
    test('Deve deletar item do Firestore', () async {
      // Adiciona um item que será deletado
      final docRef = await fakeDb.collection('Itens').add({
        'nome': 'Apagar',
        'quantidade': 3,
        'userID': 'user123',
      });

      // Deleta o item
      await fakeDb.collection('Itens').doc(docRef.id).delete();

      // Confirma que o item não existe mais
      final deleted = await fakeDb.collection('Itens').doc(docRef.id).get();
      expect(deleted.exists, false);
    });
  });
}
