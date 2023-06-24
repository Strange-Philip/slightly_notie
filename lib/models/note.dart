class Note {
  String? title;
  String? note;
  String? date;
  int? color;

  Note({
    this.title,
    this.date,
    this.note,
    this.color,
  });

  Note.fromJson(Map<String, dynamic> json) {
    title = json['title'].toString();
    date = json['date'].toString();
    note = json['note'].toString();
    color = json['color'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['date'] = date;
    data['note'] = note;
    data['color'] = color;

    return data;
  }
}
