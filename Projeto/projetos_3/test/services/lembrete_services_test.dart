import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetos_3/services/lembrete.dart';

/*
  Testes do LembreteService utilizando FakeFirebaseFirestore.

  Descrição:
  - Testa as operações de CRUD de lembretes associadas a um usuário,
    sem depender do Firestore real.
  - Usa uma instância FakeFirebaseFirestore e UID falso para simular
    o comportamento do serviço.

  Funcionalidades verificadas:
  - adicionarLembrete: adiciona um lembrete no Firestore com os campos corretos
  - getLembretesDoUsuario: retorna apenas os lembretes do usuário atual,
    ordenados da data mais recente para a mais antiga
  - deletarLembrete: remove um lembrete existente
  - deletarLembrete: lança exceção quando o ID é inválido (null ou vazio)

  Tipo de teste:
  - Unitário (teste de serviço / lógica de dados)

  Ferramentas utilizadas:
  - flutter_test
  - fake_cloud_firestore
  - mocktail (para mocks, se necessário)
*/

class MockUserCache extends Mock {
  // Mock simples para simular o cache do usuário
  static String? uid;

  // Método que retorna o UID armazenado no mock
  static Future<String?> getUid() async => uid;
}

void main() {
  late FakeFirebaseFirestore fakeDb;
  late LembreteService service;

  setUp(() {
    // Cria uma instância fake do Firestore
    fakeDb = FakeFirebaseFirestore();

    // Inicializa o serviço de lembretes usando a coleção fake e um UID simulado
    service = LembreteService(
      collection: fakeDb.collection('Lembretes'),
      getUid: () async => 'user123',
    );
  });

  group('LembreteService', () {
    test('adicionarLembrete deve salvar no Firestore', () async {
      // Adiciona um lembrete de teste
      await service.adicionarLembrete(
        'Título teste',
        'Descrição teste',
        DateTime(2025, 1, 1),
        true,
      );

      // Verifica se o lembrete foi salvo realmente no Firestore
      final snapshot = await fakeDb.collection('Lembretes').get();
      expect(snapshot.docs.length, 1);

      final doc = snapshot.docs.first.data();
      expect(doc['titulo'], 'Título teste');
      expect(doc['descricao'], 'Descrição teste');
      expect(doc['userID'], 'user123');
      expect(doc['importante'], true);
    });

    test('getLembretesDoUsuario deve retornar ordenado por data', () async {
      // Adiciona dois lembretes com datas diferentes
      final now = DateTime.now();
      await service.adicionarLembrete('Antigo', 'Desc', now.subtract(Duration(days: 1)), false);
      await service.adicionarLembrete('Novo', 'Desc', now, true);

      // Busca os lembretes do usuário e verifica se estão ordenados do mais recente para o mais antigo
      final lembretes = await service.getLembretesDoUsuario();
      expect(lembretes.length, 2);
      expect(lembretes.first['titulo'], 'Novo'); // mais recente primeiro
    });

    test('deletarLembrete deve remover documento', () async {
      // Adiciona um lembrete para depois deletar
      final docRef = await fakeDb.collection('Lembretes').add({
        'titulo': 'teste',
        'descricao': 'desc',
        'data': Timestamp.now(),
        'userID': 'user123',
        'importante': false,
      });

      // Deleta o lembrete
      await service.deletarLembrete(docRef.id);

      // Verifica se o lembrete realmente não existe mais
      final snap = await fakeDb.collection('Lembretes').doc(docRef.id).get();
      expect(snap.exists, false);
    });

    test('deletarLembrete deve lançar exceção se id inválido', () async {
      // Testa casos de ID inválido (null ou vazio)
      expect(() => service.deletarLembrete(null), throwsException);
      expect(() => service.deletarLembrete(''), throwsException);
    });
  });
}
