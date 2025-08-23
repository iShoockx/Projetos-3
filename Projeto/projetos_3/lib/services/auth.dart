// lib/services/auth.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as fb_auth;

import '../models/usuario.dart';

/// Serviço de autenticação + persistência do perfil no Firestore.
class AuthService {
  AuthService({fb_auth.FirebaseAuth? auth, FirebaseFirestore? db})
    : _auth = auth ?? fb_auth.FirebaseAuth.instance,
      _db = db ?? FirebaseFirestore.instance;

  final fb_auth.FirebaseAuth _auth;
  final FirebaseFirestore _db;

  /// Stream reativa com o AppUser (ou null se deslogado).
  Stream<AppUser?> get userChanges =>
      _auth.authStateChanges().asyncMap(_userFromFirebase);

  /// Retorna o AppUser a partir do FirebaseAuth.User,
  /// criando o doc no Firestore se não existir.
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

    // Cria um perfil básico
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

  /// Cadastro com e-mail/senha.
  /// Cria o usuário no FirebaseAuth e salva/atualiza o perfil no Firestore.
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

  /// Login com e-mail/senha.
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

  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Atualiza campos do perfil no Firestore (e displayName no Auth).
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

  /// Retorna AppUser atual ou null se não auteticado
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
  Future<void> updateEmail(String email) async {
      final user = _auth.currentUser;
      if (user == null) throw Exception('Não autenticado.');

      // await user.updateEmail(email);

      await _db.collection('users').doc(user.uid).set({
        'email': email,
      }, SetOptions(merge: true));
    }
  fb_auth.User? get firebaseUser => _auth.currentUser;
}


