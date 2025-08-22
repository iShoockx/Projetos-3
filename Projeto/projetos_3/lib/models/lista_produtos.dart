class ListaProdutos {
  final String listaID;
  final String userID;

  ListaProdutos({
    required this.listaID,
    required this.userID,
  });

  factory ListaProdutos.fromMap(Map<String, dynamic> map) {
    return ListaProdutos(
      listaID: map['listaID'],
      userID: map['userID'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'listaID': listaID,
      'userID': userID,
    };
  }
}