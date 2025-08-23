// import 'package:flutter_test/flutter_test.dart';
// import 'package:mocktail/mocktail.dart';
// import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:projetos_3/services/auth.dart';
// import 'package:projetos_3/models/usuario.dart';

// /// --- MOCKS --- ///
// class MockFirebaseAuth extends Mock implements fb_auth.FirebaseAuth {}

// class MockUserCredential extends Mock implements fb_auth.UserCredential {}

// class MockUser extends Mock implements fb_auth.User {}

// class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

// class MockDocumentReference<T> extends Mock implements DocumentReference<T> {}

// class MockCollectionReference<T> extends Mock
//     implements CollectionReference<T> {}

// class MockDocumentSnapshot<T> extends Mock implements DocumentSnapshot<T> {}

// void main() {
//   late MockFirebaseAuth mockAuth;
//   late MockFirebaseFirestore mockDb;
//   late AuthService authService;

//   setUp(() {
//     mockAuth = MockFirebaseAuth();
//     mockDb = MockFirebaseFirestore();
//     authService = AuthService(auth: mockAuth, db: mockDb);
//   });

//   group('AuthService', () {
//     test('signUp deve criar usuário e salvar no Firestore', () async {
//       final mockUser = MockUser();
//       final mockCred = MockUserCredential();

//       when(() => mockCred.user).thenReturn(mockUser);
//       when(() => mockUser.uid).thenReturn('123');
//       when(() => mockUser.updateDisplayName(any()))
//           .thenAnswer((_) async => {});

//       when(() => mockAuth.createUserWithEmailAndPassword(
//         email: any(named: 'email'),
//         password: any(named: 'password'),
//       )).thenAnswer((_) async => mockCred);

//       // Mock Firestore
//       final mockCollection = MockCollectionReference<Map<String, dynamic>>();
//       final mockDoc = MockDocumentReference<Map<String, dynamic>>();
//       when(() => mockDb.collection('users')).thenReturn(mockCollection);
//       when(() => mockCollection.doc(any())).thenReturn(mockDoc);
//       when(() => mockDoc.set(any(), any())).thenAnswer((_) async {});

//       final user = await authService.signUp(
//         name: 'Teste',
//         email: 'teste@email.com',
//         password: '123456',
//       );

//       expect(user.name, 'Teste');
//       expect(user.email, 'teste@email.com');
//       expect(user.id, '123');
//     });

//     test('signIn deve autenticar e retornar AppUser', () async {
//       final mockUser = MockUser();
//       final mockCred = MockUserCredential();

//       when(() => mockCred.user).thenReturn(mockUser);
//       when(() => mockUser.uid).thenReturn('123');

//       when(() => mockAuth.signInWithEmailAndPassword(
//         email: any(named: 'email'),
//         password: any(named: 'password'),
//       )).thenAnswer((_) async => mockCred);

//       // Mock Firestore
//       final mockCollection = MockCollectionReference<Map<String, dynamic>>();
//       final mockDoc = MockDocumentReference<Map<String, dynamic>>();
//       final mockSnapshot = MockDocumentSnapshot<Map<String, dynamic>>();

//       when(() => mockDb.collection('users')).thenReturn(mockCollection);
//       when(() => mockCollection.doc(any())).thenReturn(mockDoc);

//       // Simula o withConverter -> retorna o mesmo mockDoc mas tipado
//       when(() => mockDoc.withConverter<AppUser>(
//         fromFirestore: any(named: 'fromFirestore'),
//         toFirestore: any(named: 'toFirestore'),
//       )).thenReturn(mockDoc as DocumentReference<AppUser>);

//       when(() => mockDoc.get()).thenAnswer((_) async => mockSnapshot);
//       when(() => mockSnapshot.exists).thenReturn(true);

//       // Aqui simulamos o dado do Firestore que será convertido em AppUser
//       when(() => mockSnapshot.data()).thenReturn({
//         'id': '123',
//         'name': 'Teste',
//         'email': 'teste@email.com',
//         'role': 'cliente',
//         'createdAt': Timestamp.now(),
//       });

//       final user = await authService.signIn(
//         email: 'teste@email.com',
//         password: '123456',
//       );

//       expect(user.id, '123');
//       expect(user.name, 'Teste');
//     });

//     test('signOut deve chamar FirebaseAuth.signOut', () async {
//       when(() => mockAuth.signOut()).thenAnswer((_) async {});
//       await authService.signOut();
//       verify(() => mockAuth.signOut()).called(1);
//     });
//   });
// }
