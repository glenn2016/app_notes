import 'dart:convert';

import 'package:app_notes/models/note.dart';
import 'package:http/http.dart' as http;


class NoteService {
  final String apiUrl = "http://192.168.1.14:8080/api/v1";
  bool verif = false;

  Future<List<NoteM>>? getNotes() async {
    var response = await http.get(Uri.parse("$apiUrl/notes"));
    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);
      List<NoteM> notes =
          body.map((dynamic item) => NoteM.fromJson(item)).toList();
      return notes;
    } else {
      throw "Impossible de récupérer la liste des notes.";
    }
  }

  Future<NoteM> getNoteById(int id) async {
    var response = await http.get(Uri.parse("$apiUrl/note/$id"));
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      NoteM note = NoteM.fromJson(body);
      return note;
    } else {
      throw "Impossible de récupérer la note.";
    }
  }

  Future<NoteM> createNote(NoteM note) async {
    final response = await http.post(
      Uri.parse("$apiUrl/notes"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(note.toJson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      NoteM note = NoteM.fromJson(body);
      verif = true;
      return note;
    } else {
      throw "Impossible de créer la note.";
    }
  }


  Future<NoteM> updateNote(int? id, NoteM note) async {
    final response = await http.put(
      Uri.parse("$apiUrl/notes/$id"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(note.toJson()),
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> body = jsonDecode(response.body);
      NoteM note = NoteM.fromJson(body);
      return note;
    } else {
      throw "Impossible de mettre à jour la note.";
    }
  }

  Future<void> deleteNote(int id) async {
    final response = await http.delete(Uri.parse("$apiUrl/notes/$id"));
    if (response.statusCode != 204) {
      throw "Impossible de supprimer la note.";
    }
  }
}
