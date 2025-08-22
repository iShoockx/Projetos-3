class Produto {
  final String id;

  final String nome;
  final int quantidade;
  final String userID;

  Produto({
    required this.id,
    required this.nome,
    required this.quantidade,
    required this.userID,
  });

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      quantidade: map['quantidade'],
      userID: map['userID'] ?? '', // Adicionando userID como campo opcional
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'quantidade': quantidade,
      'userID': userID, // Incluindo userID no mapa
    };
  }
}
