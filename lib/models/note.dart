class NoteM {
  int? id;
  String? matiere;
  String? note;

  NoteM({ this.id, this.matiere, this.note});

  factory NoteM.fromJson(Map<String, dynamic> json) {
    return NoteM(
      id: json['id'],
      matiere: json['matiere'],
      note: json['note'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'matiere': matiere,
    'note': note,
  };

  
}
