class TaskModel {
  final int? id;
  final String title;
  final String description;
  final String date;
  final bool isDone;

  TaskModel({this.id, required this.title, required this.description, required this.date, this.isDone = false});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'date': date,
      'isDone': isDone ? 1 : 0,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      date: map['date'],
      isDone: map['isDone'] == 1,
    );
  }
}