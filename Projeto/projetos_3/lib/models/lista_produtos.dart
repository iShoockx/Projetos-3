class ListaProdutos {
  final String listaID;
  final String produtoID;
  final int quantidade;

  ListaProdutos({
    required this.listaID,
    required this.produtoID,
    required this.quantidade,
  });

  factory ListaProdutos.fromMap(Map<String, dynamic> map) {
    return ListaProdutos(
      listaID: map['listaID'],
      produtoID: map['produtoID'],
      quantidade: map['quantidade'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'listaID': listaID,
      'produtoID': produtoID,
      'quantidade': quantidade,
    };
  }
}