class Schedule {
  final String? id;
  final String scheduleName;
  final int day;
  final String startTime;
  final String endTime;
  final String note;

  Schedule(
      {this.id,
      required this.scheduleName,
      required this.day,
      required this.startTime,
      required this.endTime,
      required this.note});

  factory Schedule.fromMap(Map<String, dynamic> map){
    return Schedule(
      id: map['id'].toString(),
      scheduleName: map['scheduleName'],
      day: map['day'],
      startTime: map['startTime'],
      endTime: map['endTime'],
      note: map['note']
    );
  }

  Map<String, dynamic> toMap(){
    return{
      'id': id,
      'scheduleName': scheduleName,
      'day': day,
      'startTime': startTime,
      'endTime': endTime,
      'note': note
    };
  }
}
