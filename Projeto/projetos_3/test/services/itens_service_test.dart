// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:projetos_3/services/itens.dart'; // ajuste o import
// import 'package:projetos_3/cache/user_cache.dart';

// // Mock do FirebaseFirestore
// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// // Mock de CollectionReference
// class MockCollectionReference extends Mock implements CollectionReference<Map<String, dynamic>> {}

// // Mock de DocumentReference
// class MockDocumentReference extends Mock implements DocumentReference<Map<String, dynamic>> {}

// // Mock do UserCache
// class MockUserCache extends Mock implements UserCache {}

// void main() {
//   late MockFirebaseFirestore mockFirestore;
//   late MockCollectionReference mockCollection;
//   late MockDocumentReference mockDocument;
//   late MockUserCache mockUserCache;

//   setUp(() {
//     mockFirestore = MockFirebaseFirestore();
//     mockCollection = MockCollectionReference();
//     mockDocument = MockDocumentReference();
//     mockUserCache = MockUserCache();

//     // Redireciona a collection para o mock
//     // Substituir db por mockFirestore no seu service para testes
//   });

//   group('ItensService', () {
//     test('addItem lança erro se usuário não encontrado', () async {
//       when(() => UserCache.getUid()).thenAnswer((_) async => null);

//       expect(() => addItem('Item1', 5), throwsA(isA<Exception>()));
//     });

//     test('addItem chama collection.add corretamente', () async {
//       when(() => UserCache.getUid()).thenAnswer((_) async => 'user123');
//       when(() => mockFirestore.collection('Itens')).thenReturn(mockCollection);
//       when(() => mockCollection.add(any())).thenAnswer((_) async => mockDocument);

//       // Para usar mockFirestore você precisa passar ele pro service ou fazer injeção
//       // Aqui vamos apenas ilustrar
//     });

//     test('updateItem chama update corretamente', () async {
//       when(() => mockFirestore.collection('Itens')).thenReturn(mockCollection);
//       when(() => mockCollection.doc('doc123')).thenReturn(mockDocument);
//       when(() => mockDocument.update({
//             'nome': 'NovoNome',
//             'quantidade': 10,
//           })).thenAnswer((_) async {});

//       await updateItem('doc123', 'NovoNome', 10);

//       verify(() => mockDocument.update({
//             'nome': 'NovoNome',
//             'quantidade': 10,
//           })).called(1);
//     });

//     test('deleteItem chama delete corretamente', () async {
//       when(() => mockFirestore.collection('Itens')).thenReturn(mockCollection);
//       when(() => mockCollection.doc('doc123')).thenReturn(mockDocument);
//       when(() => mockDocument.delete()).thenAnswer((_) async {});

//       await deleteItem('doc123');

//       verify(() => mockDocument.delete()).called(1);
//     });

//     test('getItens lança erro se usuário não encontrado', () async {
//       when(() => UserCache.getUid()).thenAnswer((_) async => null);

//       expect(() => getItens().first, throwsA(isA<Exception>()));
//     });
//   });
// }
