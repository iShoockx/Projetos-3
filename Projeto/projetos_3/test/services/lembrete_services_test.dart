import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:projetos_3/services/lembrete.dart'; 
import 'package:projetos_3/cache/user_cache.dart';

// Mocks
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}
class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}
class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}
class MockQuerySnapshot extends Mock implements QuerySnapshot<Map<String, dynamic>> {}
class MockQueryDocumentSnapshot extends Mock implements QueryDocumentSnapshot<Map<String, dynamic>> {}
class MockUserCache extends Mock implements UserCache {}

void main() {
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockCollection;
  late MockDocumentReference mockDocument;
  late MockUserCache mockUserCache;
  late LembreteService service;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockCollection = MockCollectionReference();
    mockDocument = MockDocumentReference();
    mockUserCache = MockUserCache();

    // Substituir o _lembretesCollection do service por mock
    service = LembreteService();
    // Aqui você precisa injetar mockCollection ou usar package como "get_it"
  });

  group('LembreteService', () {
    test('adicionarLembrete lança erro se usuário não encontrado', () async {
      when(() => UserCache.getUid()).thenAnswer((_) async => null);

      expect(
        () => service.adicionarLembrete(
          'Teste',
          'Descrição',
          DateTime.now(),
          false,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('deletarLembrete lança erro se ID inválido', () async {
      expect(
        () => service.deletarLembrete(null),
        throwsA(isA<Exception>()),
      );
      expect(
        () => service.deletarLembrete(''),
        throwsA(isA<Exception>()),
      );
    });

    test('getLembretesDoUsuario lança erro se usuário não encontrado', () async {
      when(() => UserCache.getUid()).thenAnswer((_) async => null);

      expect(() => service.getLembretesDoUsuario(), throwsA(isA<Exception>()));
    });

    test('adicionarLembrete chama collection.add corretamente', () async {
      when(() => UserCache.getUid()).thenAnswer((_) async => 'user123');

      final mockAdd = MockDocumentReference();
      when(() => service.lembretesCollection.add(any())).thenAnswer((_) async => mockAdd);

      await service.adicionarLembrete('Teste', 'Descrição', DateTime.now(), true);

      verify(() => service.lembretesCollection.add(any())).called(1);
    });

    test('deletarLembrete chama doc.delete corretamente', () async {
      when(() => service.lembretesCollection.doc('doc123')).thenReturn(mockDocument);
      when(() => mockDocument.delete()).thenAnswer((_) async {});

      await service.deletarLembrete('doc123');

      verify(() => mockDocument.delete()).called(1);
    });

    test('getLembretesDoUsuario retorna lista ordenada', () async {
      when(() => UserCache.getUid()).thenAnswer((_) async => 'user123');

      final mockDoc1 = MockQueryDocumentSnapshot();
      final mockDoc2 = MockQueryDocumentSnapshot();

      when(() => mockDoc1.id).thenReturn('1');
      when(() => mockDoc1.data()).thenReturn({'titulo': 'A', 'data': Timestamp.fromDate(DateTime(2025, 1, 2))});

      when(() => mockDoc2.id).thenReturn('2');
      when(() => mockDoc2.data()).thenReturn({'titulo': 'B', 'data': Timestamp.fromDate(DateTime(2025, 1, 1))});

      final mockSnapshot = MockQuerySnapshot();
      when(() => mockSnapshot.docs).thenReturn([mockDoc1, mockDoc2]);
      when(() => service.lembretesCollection.where('userID', isEqualTo: 'user123').get())
          .thenAnswer((_) async => mockSnapshot);

      final lembretes = await service.getLembretesDoUsuario();

      expect(lembretes.length, 2);
      expect(lembretes[0]['titulo'], 'A'); // mais recente primeiro
      expect(lembretes[1]['titulo'], 'B');
    });
  });
}
