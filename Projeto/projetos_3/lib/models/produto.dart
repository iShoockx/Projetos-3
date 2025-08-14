class Produto {
  final String id;
  final String nome;
  final int quantidade;

  Produto({
    required this.id,
    required this.nome,
    required this.quantidade,
  });

  factory Produto.fromMap(Map<String, dynamic> map) {
    return Produto(
      id: map['id'],
      nome: map['nome'],
      quantidade: map['quantidade'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': nome,
      'quantidade': quantidade,
    };
  }
}
