class Note {
  String? title;
  String? note;
  String? date;
  int? color;
  String? id;
  String? userId;

  Note({this.title, this.date, this.note, this.color, this.id, this.userId});

  Note.fromJson(Map<String, dynamic> json) {
    title = json['title'].toString();
    date = json['date'].toString();
    note = json['note'].toString();
    id = json['id'].toString();
    userId = json['userid'].toString();
    color = int.parse(json['color']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['date'] = date;
    data['note'] = note;
    data['id'] = id;
    data['userid'] = userId;
    data['color'] = color;

    return data;
  }
}
