/// Modelagem da Produto para armazenamento no banco
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
      id: map['id_item']?.toString() ?? '', // Garantindo que id seja uma String
      nome: map['nome']?.toString() ?? '',
      quantidade: (map['quantidade'] is int)
        ? map['quantidade']
        : int.tryParse(map['quantidade']?.toString() ?? '0') ?? 0,
      userID: map['userID']?.toString() ?? '', // Adicionando userID como campo opcional
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
