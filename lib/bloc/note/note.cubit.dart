// import 'package:app_notes/bloc/note/note.dart';
// import 'package:app_notes/bloc/note/note.state.dart';
// import 'package:app_notes/repository/firebase/note.repository.dart';
// import 'package:bloc/bloc.dart';
// import 'package:flutter/material.dart';


// class NoteCubit extends Cubit<NoteState> {
//   NoteCubit({required this.noteRepository}) : super(NoteInitial());

//   final NoteRepository noteRepository;

//   Future<void> addNote({
//     required String matiere,
//     required String note,
//   }) async {
//     try {
//       emit(NoteLoading());
//       await noteRepository.addNote(
//         matiere: matiere,
//         note: note,
//       );
//       emit(NoteAdded());
//     } catch (e) {
//       emit(const NoteError(message: 'Failed to add note'));
//     }
//   }

//   Future<void> deleteNote(String noteId) async {
//     try {
//       emit(NoteLoading());
//       await noteRepository.deleteNote(noteId);
//       emit(NoteDeleted());
//     } catch (e) {
//       emit(const NoteError(message: 'Failed to delete note'));
//     }
//   }

//   Future<void> updateNote({
//     required String noteId,
//     required String matiere,
//     required String note,
//   }) async {
//     try {
//       emit(NoteLoading());
//       await noteRepository.updateNote(
//         noteId: noteId,
//         matiere: matiere,
//         note: note,
//       );
//       emit(NoteUpdated());
//     } catch (e) {
//       emit(const NoteError(message: 'Failed to update note'));
//     }
//   }

//   Stream<List<Note>> getNotes() async* {
//     emit(NoteLoading());
//     try {
//       final notes = noteRepository.getNotes();
//       emit(NoteListLoaded(notes: notes));
//     } catch (e) {
//       emit(NoteError(message: e.toString()));
//     }
//   }
// }


 