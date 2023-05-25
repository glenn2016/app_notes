import 'package:app_notes/bloc/theme.cubit.dart';
import 'package:app_notes/functions/note_en_cours_count.dart';
import 'package:app_notes/functions/note_pas_en_cours_count.dart';
import 'package:app_notes/functions/note_private_count.dart';
import 'package:app_notes/functions/note_public_count.dart';
import 'package:app_notes/repository/firebase/note.repository.dart';
import 'package:app_notes/routes.dart';
import 'package:app_notes/widgets/utils.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
// import 'package:multiselect/multiselect.dart';

class AjoutPage extends StatefulWidget {
  AjoutPage({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<AjoutPage> {
  final matiereController = TextEditingController();
  final noteController = TextEditingController();
  // final List<String> matiereOptions = [
  //   'JavaScript',
  //   'Java',
  //   'Php',
  //   'Angular',
  //   'Flutter',
  //   'Symfony',
  // ];

  String? selectedMatiere; // Ajout d'une variable pour stocker la matiere sélectionnée

  User? currentUser = FirebaseAuth.instance.currentUser;

  void clearText() {
    matiereController.clear();
    noteController.clear();
  }

  bool isPublic = false;
  bool isPrivate = false;

  @override
  Widget build(BuildContext context) {
    String userId = currentUser!.uid;
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, currentTheme) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () =>
                    Navigator.pushNamed(context, Routes.HOME_PAGE),
                icon: const Icon(Icons.home),
              ),
            ],
            backgroundColor: currentTheme.primaryColor,
            elevation: 0,
            title: const Text(
              "Ajout de notes",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  currentTheme.primaryColor,
                  currentTheme.hintColor,
                  currentTheme.canvasColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                
                    const SizedBox(height: 20),
                    reusableTextField(
                      "Enter la note",
                      Icons.fact_check,
                      false,
                      noteController,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Checkbox(
                          value: isPublic,
                          onChanged: (value) {
                            setState(() {
                              isPublic = value!;
                              if (isPublic) {
                                isPrivate = false;
                              }
                            });
                          },
                        ),
                        Text(isPublic ? 'Public (coché)' : 'Public'),
                        Checkbox(
                          value: isPrivate,
                          onChanged: (value) {
                            setState(() {
                              isPrivate = value!;
                              if (isPrivate) {
                                isPublic = false;
                              }
                            });
                          },
                        ),
                        Text(isPrivate ? 'Privé (coché)' : 'Privé'),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 150,
                          child: firebaseUIButton(
                            context,
                            'Enregistrer',
                            () async {
                              String matiere = selectedMatiere ?? '';
                              String note = noteController.text;

                              bool result = await NoteRepository().addNote(
                                matiere: matiere,
                                note: note,
                                isPublic: isPublic,
                                isPrivate: isPrivate,
                              );
                              updatePrivateNoteCount(userId);
                              updatePublicNoteCount(userId);
                              updatePublicNoteAverage(userId);
                              updatePrivateNoteAverage(userId);
                              clearText();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.green,
                                  behavior: SnackBarBehavior.floating,
                                  content: result
                                      ? const Text('Note enregistrée')
                                      : const Text(
                                          'Note non enregistrée',
                                          selectionColor: Colors.red,
                                        ),
                                  duration: const Duration(seconds: 3),
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: firebaseUIButton(
                            context,
                            'Annuler',
                            clearText,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
