/// Modelagem da NotificacaoUser para armazenamento no banco
class NotificacaoUser {
  //Campos tabela
  final int idUser;
  final int idNotificacao;

  //Construtor
  NotificacaoUser({required this.idUser, required this.idNotificacao});

  // Método para criar um objeto User a partir de um Map
  factory NotificacaoUser.formMap(Map<String, dynamic> map) {
    return NotificacaoUser(
      idUser: map['idUser'],
      idNotificacao: map['idNotificacao'],
    );
  }

  // Método para converter o objeto User em um Map
  Map<String, dynamic> toMap() {
    return {'idUser': idUser, 'idNotificacao': idNotificacao};
  }
}
