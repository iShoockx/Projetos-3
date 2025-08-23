// lib/models/usuario.dart
import 'package:cloud_firestore/cloud_firestore.dart';

/// Papéis possíveis do usuário na aplicação.
enum UserRole { cliente, funcionario, admin }

UserRole userRoleFromString(String value) {
  return UserRole.values.firstWhere(
    (e) => e.name == value,
    orElse: () => UserRole.cliente,
  );
}

String userRoleToString(UserRole role) => role.name;

class AppUser {
  final String id; // uid do Firebase Auth
  final String name;
  final String? email;
  final String? celular;
  final UserRole role;
  final DateTime createdAt;

   AppUser({
    required this.id,
    required this.name,
    this.email,
    this.celular,
    this.role = UserRole.cliente,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  AppUser copyWith({
    String? id,
    String? name,
    String? email,
    String? celular,
    UserRole? role,
    DateTime? createdAt,
  }) {
    return AppUser(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      celular: celular ?? this.celular,
      role: role ?? this.role,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'celular': celular,
      'role': role.name,
      // salve como Timestamp no Firestore
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory AppUser.fromMap(String id, Map<String, dynamic> map) {
    final rawCreated = map['createdAt'];
    DateTime created;
    if (rawCreated is Timestamp) {
      created = rawCreated.toDate();
    } else if (rawCreated is String) {
      created = DateTime.tryParse(rawCreated) ?? DateTime.now();
    } else {
      created = DateTime.now();
    }

    return AppUser(
      id: id,
      name: (map['name'] ?? '') as String,
      email: map['email'] as String?,
      celular: map['celular'] as String?,
      role: userRoleFromString((map['role'] ?? 'cliente') as String),
      createdAt: created,
    );
  }

  factory AppUser.fromFirestore(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? <String, dynamic>{};
    return AppUser.fromMap(doc.id, data);
  }
}
