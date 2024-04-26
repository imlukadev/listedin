class Scheduling {
  int id;
  DateTime date;

  Scheduling(this.id, this.date);

  factory Scheduling.fromJSON(Map<String, dynamic> map) {
    return Scheduling(map['id'], DateTime.parse(map['date']));
  }
}
