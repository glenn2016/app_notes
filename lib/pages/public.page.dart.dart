import 'package:app_notes/bloc/note/note.dart';
import 'package:app_notes/bloc/theme.cubit.dart';
import 'package:app_notes/functions/note_en_cours_count.dart';
import 'package:app_notes/functions/note_pas_en_cours_count.dart';
import 'package:app_notes/functions/note_private_count.dart';
import 'package:app_notes/functions/note_public_count.dart';
import 'package:app_notes/repository/firebase/note.repository.dart';
import 'package:app_notes/routes.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PublicPage extends StatelessWidget {
  final NoteRepository noteRepository = NoteRepository();

  PublicPage({Key? key}) : super(key: key);
  User? currentUser = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    String userId = currentUser!.uid;
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, theme) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, Routes.HOME_PAGE),
                icon: const Icon(Icons.home),
              ),
            ],
            title: const Row(
              children: [
                // FutureBuilder<int>(
                //   future: getPrivateNoteCount(userId),
                //   builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       // Affiche un indicateur de chargement si la future est en cours de résolution
                //       return const CircularProgressIndicator();
                //     } else if (snapshot.hasError) {
                //       // Gère les erreurs si la future échoue
                //       return Text('Erreur: ${snapshot.error}');
                //     } else {
                //       // Affiche la valeur de noteCount une fois la future résolue
                //       int noteCount = snapshot.data ?? 0;
                //       return Text(
                //         noteCount.toString(),
                //         style: const TextStyle(fontSize: 16),
                //       );
                //     }
                //   },
                // )
              ],
            ),
            backgroundColor: theme.primaryColor,
          ),
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  theme.primaryColor,
                  theme.hintColor,
                  theme.canvasColor,
                ],
              ),
            ),
            child: StreamBuilder<List<Note>>(
              stream: noteRepository.getPublicNotes(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final notes = snapshot.data!;

                return ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        // TODO: Navigate to note detail page
                      },
                      child: Card(
                        elevation: 3.0,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 6.0),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20.0, vertical: 10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'J\'ai eu  ${notes[index].note} en  ${notes[index].matiere}',
                                style: const TextStyle(fontSize: 18.0),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.UPDATE_PAGE,
                                    arguments: notes[index],
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  noteRepository.deleteNote(notes[index].id);
                                  updatePrivateNoteCount(userId);
                                  updatePublicNoteCount(userId);
                                  updatePrivateNoteAverage(userId);
                                  updatePublicNoteAverage(userId);
                                },
                                icon: Icon(
                                  Icons.delete,
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.pushNamed(context, Routes.AJOUT_PAGE);
            },
            child: const Icon(
              Icons.add,
            ),
          ),
        );
      },
    );
  }
}
