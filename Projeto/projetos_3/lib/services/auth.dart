import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../models/usuario.dart';

/// Serviço responsável pela autenticação de usuários
/// e persistência do perfil no Firestore.
///
/// Esse service encapsula:
/// - Autenticação via [FirebaseAuth].
/// - Criação e atualização de documentos do usuário no [FirebaseFirestore].
/// - Conversão do usuário autenticado para o modelo [AppUser].
///
/// ### Principais responsabilidades:
/// - Criar novos usuários com e-mail/senha.
/// - Fazer login e logout.
/// - Expor um stream reativa para mudanças no estado de autenticação.
/// - Manter os perfis sincronizados entre Auth e Firestore.
class AuthService {
  /// Constrói um [AuthService] opcionalmente recebendo
  /// instâncias customizadas de [FirebaseAuth] e [FirebaseFirestore].
  AuthService({fb_auth.FirebaseAuth? auth, FirebaseFirestore? db})
      : _auth = auth ?? fb_auth.FirebaseAuth.instance,
        _db = db ?? FirebaseFirestore.instance;

  final fb_auth.FirebaseAuth _auth;
  final FirebaseFirestore _db;

  /// Stream reativa que emite [AppUser] sempre que houver
  /// mudança no estado de autenticação.
  ///
  /// Retorna `null` quando o usuário estiver deslogado.
  Stream<AppUser?> get userChanges =>
      _auth.authStateChanges().asyncMap(_userFromFirebase);

  /// Converte um [fb_auth.User] para [AppUser].
  ///
  /// Se o documento ainda não existir no Firestore, cria um perfil
  /// básico com os dados mínimos (nome, e-mail, data de criação).
  Future<AppUser?> _userFromFirebase(fb_auth.User? user) async {
    if (user == null) return null;
    final ref = _db
        .collection('users')
        .doc(user.uid)
        .withConverter<AppUser>(
          fromFirestore: (snap, _) => AppUser.fromFirestore(snap),
          toFirestore: (appUser, _) => appUser.toMap(),
        );

    final doc = await ref.get();
    if (doc.exists) {
      return doc.data();
    }

    /// Cria um perfil básico caso não exista no Firestore.
    final appUser = AppUser(
      id: user.uid,
      name: user.displayName ?? (user.email?.split('@').first ?? 'Usuário'),
      email: user.email,
      role: UserRole.cliente,
      createdAt: DateTime.now(),
    );

    await ref.set(appUser, SetOptions(merge: true));
    await ref.update({'createdAt': FieldValue.serverTimestamp()});

    return appUser;
  }

  /// Cria um novo usuário com e-mail e senha no FirebaseAuth.
  ///
  /// Também salva o perfil correspondente no Firestore.
  ///
  /// Retorna o [AppUser] criado.
  Future<AppUser> signUp({
    required String name,
    required String email,
    required String password,
    String? celular,
    UserRole role = UserRole.cliente,
  }) async {
    final cred = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    await cred.user!.updateDisplayName(name);

    final appUser = AppUser(
      id: cred.user!.uid,
      name: name,
      email: email,
      celular: celular,
      role: role,
      createdAt: DateTime.now(),
    );

    final ref = _db.collection('users').doc(appUser.id);
    await ref.set(appUser.toMap(), SetOptions(merge: true));
    await ref.set({
      'createdAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));

    return appUser;
  }

  /// Realiza login com e-mail e senha.
  ///
  /// Retorna o [AppUser] correspondente.
  /// Lança [Exception] caso não seja possível carregar o perfil.
  Future<AppUser> signIn({
    required String email,
    required String password,
  }) async {
    final cred = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    final appUser = await _userFromFirebase(cred.user);
    if (appUser == null) {
      throw Exception('Falha ao carregar o perfil do usuário.');
    }
    return appUser;
  }

  /// Realiza logout do usuário autenticado.
  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Atualiza os dados do perfil no Firestore e também o displayName no FirebaseAuth.
  ///
  /// - [name]: nome obrigatório do usuário.
  /// - [celular]: número de celular opcional.
  /// - [role]: função do usuário opcional.
  ///
  /// Lança [Exception] caso não exista um usuário autenticado.
  Future<void> updateProfile({
    required String name,
    String? celular,
    UserRole? role,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Não autenticado.');

    await user.updateDisplayName(name);

    final data = <String, dynamic>{'name': name};
    if (celular != null) data['celular'] = celular;
    if (role != null) data['role'] = role.name;

    await _db
        .collection('users')
        .doc(user.uid)
        .set(data, SetOptions(merge: true));
  }

  /// Retorna o [AppUser] atual ou `null` se não houver usuário autenticado.
  Future<AppUser?> get currentUser async {
    final user = _auth.currentUser;
    if (user == null) return null;

    final doc = await _db
        .collection('users')
        .doc(user.uid)
        .withConverter<AppUser>(
          fromFirestore: (snap, _) => AppUser.fromFirestore(snap),
          toFirestore: (appUser, _) => appUser.toMap(),
        )
        .get();

    return doc.data();
  }

  /// Atualiza o e-mail do usuário tanto no Firestore quanto no FirebaseAuth.
  ///
  /// > OBS: o `user.updateEmail(email)` foi comentado aqui, mas
  /// em produção você pode reativar caso queira refletir
  /// a alteração também no [FirebaseAuth].
  Future<void> updateEmail(String email) async {
    final user = _auth.currentUser;
    if (user == null) throw Exception('Não autenticado.');

    // await user.updateEmail(email);

    await _db.collection('users').doc(user.uid).set({
      'email': email,
    }, SetOptions(merge: true));
  }

  /// Retorna diretamente o usuário autenticado no [FirebaseAuth],
  /// ou `null` caso não haja sessão ativa.
  fb_auth.User? get firebaseUser => _auth.currentUser;
}
