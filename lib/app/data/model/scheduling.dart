class Scheduling {
  int id;
  DateTime date;

  Scheduling(this.id, this.date);

  factory Scheduling.fromJSON(Map<String, dynamic> map) {
    return Scheduling(map['id'], DateTime.parse(map['date']));
  }

  Map<String, dynamic> toJSON(){
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['date'] = date.toString();
    return data;
  }

}
