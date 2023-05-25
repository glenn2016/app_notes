import 'package:app_notes/bloc/note/note.dart';
import 'package:app_notes/bloc/theme.cubit.dart';
import 'package:app_notes/repository/firebase/note.repository.dart';
import 'package:app_notes/routes.dart';
import 'package:app_notes/widgets/utils.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ModificationPage extends StatefulWidget {
  final Note note;

  ModificationPage({Key? key, required this.note}) : super(key: key);

  @override
  _ModificationPageState createState() => _ModificationPageState();
}

class _ModificationPageState extends State<ModificationPage> {
  late TextEditingController _matiereController;
  late TextEditingController _noteController;

  @override
  void initState() {
    super.initState();
    _matiereController = TextEditingController(text: widget.note.matiere);
    _noteController = TextEditingController(text: widget.note.note);
  }

  @override
  void dispose() {
    _matiereController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, currentTheme) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            actions: [
              IconButton(
                onPressed: () => Navigator.pushNamed(context, Routes.HOME_PAGE),
                icon: const Icon(Icons.home),
              ),
            ],
            backgroundColor: currentTheme.primaryColor,
            elevation: 0,
            title: const Text(
              "",
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
                    reusableTextField(
                      "",
                      Icons.ad_units,
                      false,
                      _matiereController,
                    ),
                    const SizedBox(height: 20),
                    reusableTextField(
                      "Enter la note",
                      Icons.fact_check,
                      false,
                      _noteController,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          width: 150,
                          child: firebaseUIButton(
                            context,
                            "Modifier",
                            () {
                              String matiere = _matiereController.text;
                              String note = _noteController.text;
                              NoteRepository().updateNote(
                                noteId: widget.note.id,
                                matiere: matiere,
                                note: note,
                              );
                              Navigator.pushNamed(context, Routes.LISTE_PAGE);
                            },
                          ),
                        ),
                        SizedBox(
                          width: 150,
                          child: firebaseUIButton(
                            context,
                            'Annuler',
                            () {
                              Navigator.pushNamed(context, Routes.LISTE_PAGE);
                            },
                          ),
                        )
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
