/// Modelagem da Notificacao para armazenamento no banco
class Notificacao {
    //Campos tabela
    final int id;
    final String mensagem;
    final bool importante;

    //Construtor
    Notificacao({
        required this.id,
        required this.mensagem,
        required this.importante,
    });

    // Método para criar um objeto User a partir de um Map
    factory Notificacao.formMap(Map<String, dynamic> map) {
        return Notificacao(
            id: map['id'],
            mensagem: map['mensagem'],
            importante: map['importante'],
        );
    }

    // Método para converter o objeto User em um Map
    Map<String, dynamic> toMap() {
        return {
            'id': id,
            'mensagem': mensagem,
            'importante': importante
        };
    }
}
