

class Servico {
  String id;
  String workerID;
  String clientID;
  String listaID;
  String title;
  String description;
  String date;
  String time;
  String status;
  
  Servico({
    required this.id,
    required this.workerID,
    required this.clientID,
    required this.listaID,
    required this.title,
    required this.description,
    required this.date,
    required this.time,
    required this.status,
  });

  Servico.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        workerID = map['workerID'],
        clientID = map['clientID'],
        listaID = map['listaID'],
        title = map['title'],
        description = map['description'],
        date = map['date'],
        time = map['time'],
        status = map['status'];
  
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'workerID': workerID,
      'clientID': clientID,
      'listaID': listaID,
      'title': title,
      'description': description,
      'date': date,
      'time': time,
      'status': status,
    };
  }
}