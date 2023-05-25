
import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String id;
  final String matiere;
  final String note;

  const Note({
    required this.id,
    required this.matiere,
    required this.note,
  });

  @override
  List<Object> get props => [id, matiere, note];

  @override
  String toString() => 'Note { id: $id, matiere: $matiere, note: $note }';
}
