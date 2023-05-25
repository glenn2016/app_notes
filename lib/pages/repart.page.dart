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

class RepartPage extends StatelessWidget {
  final NoteRepository noteRepository = NoteRepository();

  RepartPage({Key? key}) : super(key: key);

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
            title: const Text(
              'Répartition des notes',
              style: TextStyle(fontSize: 20),
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FutureBuilder<int>(
                  future: getPrivateNoteCount(userId),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      int notePrivateCount = snapshot.data ?? 0;
                      return _buildCard1(
                          'Nombre de notes privées', notePrivateCount);
                    }
                  },
                ),
                FutureBuilder<int>(
                  future: getPublicNoteCount(userId),
                  builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      int notePublicCount = snapshot.data ?? 0;
                      return _buildCard1(
                          'Nombre de notes publiques', notePublicCount);
                    }
                  },
                ),
                FutureBuilder<double>(
                  future: getPrivateNoteAverage(userId),
                  builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      double moyenneNotesPrivees = snapshot.data ?? 0;
                      return _buildCard(
                          'Moyenne des notes privees', moyenneNotesPrivees);
                    }
                  },
                ),
                FutureBuilder<double>(
                  future: getPublicNoteAverage(userId),
                  builder: (BuildContext context, AsyncSnapshot<double> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      double moyenneNotesPubliques = snapshot.data ?? 0;
                      return _buildCard(
                          'Moyenne des notes publiques', moyenneNotesPubliques);
                    }
                  },
                ),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            onPressed: () {
              Navigator.pushNamed(context, Routes.AJOUT_PAGE);
            },
            child: const Icon(Icons.add),
          ),
        );
      },
    );
  }

  Widget _buildCard(String title, double count) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

    Widget _buildCard1(String title, int count) {
    return Card(
      elevation: 3.0,
      margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18.0),
            ),
            Text(
              count.toString(),
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
