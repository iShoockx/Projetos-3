class Servico {
  final DateTime data;       // armazena a data
  final DateTime horaInicio; // armazena hora como DateTime
  final DateTime horaFim;    // armazena hora como DateTime

  Servico({
    required this.data,
    required this.horaInicio,
    required this.horaFim,
  });

  factory Servico.fromMap(Map<String, dynamic> map) {
    return Servico(
      data: DateTime.parse(map['data']),
      horaInicio: DateTime.parse("1970-01-01 ${map['hora_inicio']}"),
      horaFim: DateTime.parse("1970-01-01 ${map['hora_fim']}"),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'data': data.toIso8601String().split('T')[0], // só a data
      'hora_inicio': "${horaInicio.hour.toString().padLeft(2,'0')}:${horaInicio.minute.toString().padLeft(2,'0')}:${horaInicio.second.toString().padLeft(2,'0')}",
      'hora_fim': "${horaFim.hour.toString().padLeft(2,'0')}:${horaFim.minute.toString().padLeft(2,'0')}:${horaFim.second.toString().padLeft(2,'0')}",
    };
  }
}
