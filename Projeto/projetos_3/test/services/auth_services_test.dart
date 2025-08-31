import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;
import 'package:flutter_test/flutter_test.dart';
import 'package:projetos_3/services/auth.dart';

/*
  Testes do AuthService (registro de usuários).

  Descrição:
  - Testa a funcionalidade de criação de usuários (`signUp`) do AuthService
    sem depender do Firebase real.
  - Utiliza mocks e uma instância fake do Firestore (FakeFirebaseFirestore)
    para simular autenticação e armazenamento de dados.
  
  Estrutura utilizada:
  - MockFirebaseAuth: simula a autenticação FirebaseAuth
  - MockUserCredential e MockUser: simulam o retorno do FirebaseAuth
  - FakeFirebaseFirestore: simula o Firestore para salvar dados do usuário

  Funcionalidades verificadas:
  - Criação de usuário com email e senha
  - Salvamento do usuário no Firestore com campos corretos
  - Atualização do displayName no FirebaseAuth
  - Retorno correto do usuário criado (id, email, name)

  Tipo de teste:
  - Unitário (teste de serviço / lógica de negócio)
  
  Ferramentas utilizadas:
  - flutter_test
  - mocktail
  - fake_cloud_firestore
*/

class MockFirebaseAuth extends Mock implements fb_auth.FirebaseAuth {}
class MockUserCredential extends Mock implements fb_auth.UserCredential {}
class MockUser extends Mock implements fb_auth.User {}

void main() {
  late FakeFirebaseFirestore fakeDb;
  late MockFirebaseAuth mockAuth;
  late AuthService authService;

  setUp(() {
    fakeDb = FakeFirebaseFirestore();
    mockAuth = MockFirebaseAuth();
    authService = AuthService(auth: mockAuth, db: fakeDb);
  });

  test('Deve criar usuário no Firestore ao se registrar', () async {
    final fakeUser = MockUser();
    when(() => fakeUser.uid).thenReturn('123');
    when(() => fakeUser.email).thenReturn('teste@email.com');
    when(() => fakeUser.displayName).thenReturn(null);

    final mockCred = MockUserCredential();
    when(() => mockCred.user).thenReturn(fakeUser);

    // Mocka o createUserWithEmailAndPassword
    when(() => mockAuth.createUserWithEmailAndPassword(
      email: any(named: 'email'),
      password: any(named: 'password'),
    )).thenAnswer((_) async => mockCred);

    // Mocka o updateDisplayName
    when(() => fakeUser.updateDisplayName(any()))
        .thenAnswer((_) async {});

    // Act
    final user = await authService.signUp(
      name: 'Tester',
      email: 'teste@email.com',
      password: '123456',
    );

    // Assert no retorno
    expect(user.id, '123');
    expect(user.email, 'teste@email.com');
    expect(user.name, 'Tester');

    // Assert no Firestore
    final snap = await fakeDb.collection('users').doc(user.id).get();
    expect(snap.exists, true);
    expect(snap['email'], 'teste@email.com');
    expect(snap['name'], 'Tester'); // <- garante que salvou o nome

    // Verifica que chamou updateDisplayName no FirebaseAuth
    verify(() => fakeUser.updateDisplayName('Tester')).called(1);
  });
}