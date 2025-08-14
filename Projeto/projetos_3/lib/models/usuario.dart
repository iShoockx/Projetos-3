enum UserRole { cliente, funcionario, admin }

UserRole userRoleFromString(String value) {
  return UserRole.values.firstWhere(
    (e) => e.name == value,
    orElse: () => UserRole.cliente, // valor padrão
  );
}

String userRoleToString(UserRole role) => role.name;

class User { // Campos tabela
  final String id;
  final String name;
  final String password;
  final String? email; // ? sinal para indicar que o campo é opcional
  final String? celular;
  final UserRole role;
  final DateTime createdAt;

  User({ // Construtor
    required this.id,
    required this.name,
    required this.password,
    this.email,
    this.celular,
    required this.role,
    required this.createdAt,
  });

  factory User.fromMap(Map<String, dynamic> map) { // Método para criar um objeto User a partir de um Map
    return User(
      id: map['id'],
      name: map['name'],
      password: map['password'],
      email: map['email'],
      celular: map['celular'],
      role: userRoleFromString(map['role']),
      createdAt: DateTime.parse(map['created_at']),
    );
  }

  Map<String, dynamic> toMap() { // Método para converter o objeto User em um Map
    return {
      'id': id,
      'name': name,
      'password': password,
      'email': email,
      'celular': celular,
      'role': userRoleToString(role),
      'created_at': createdAt.toIso8601String(),
    };
  }
}
