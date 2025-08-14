class HorarioExececao {
  //Campos tabela
  final int id;
  final int workerID;
  final DateTime data;       // armazena a data
  final DateTime horaInicio; // armazena hora como DateTime
  final DateTime horaFim;
  final String motivo;

  //Construtor
  HorarioExececao({
    required this.id,
    required this.workerID,
    required this.data,
    required this.horaInicio,
    required this.horaFim,
    required this.motivo,
  });

  // Método para criar um objeto User a partir de um Map
  factory HorarioExececao.formMap(Map<String, dynamic> map) {
    return HorarioExececao(
      id: map['id'],
      workerID: map['workerID'],
      data: DateTime.parse(map['data']),
      horaInicio: DateTime.parse("1970-01-01 ${map['hora_inicio']}"),
      horaFim: DateTime.parse("1970-01-01 ${map['hora_fim']}"),
      motivo: map['motivo'],
    );
  }

  // Método para converter o objeto User em um Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workerID': workerID,
      'data': data.toIso8601String().split('T')[0], // só a data
      'hora_inicio': "${horaInicio.hour.toString().padLeft(2,'0')}:${horaInicio.minute.toString().padLeft(2,'0')}:${horaInicio.second.toString().padLeft(2,'0')}",
      'hora_fim': "${horaFim.hour.toString().padLeft(2,'0')}:${horaFim.minute.toString().padLeft(2,'0')}:${horaFim.second.toString().padLeft(2,'0')}",
      'motivo': motivo,
    };
  }
}
