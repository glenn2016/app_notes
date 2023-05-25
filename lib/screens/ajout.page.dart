// import 'package:app_notes/bloc/theme.cubit.dart';
// import 'package:app_notes/models/note.dart';
// import 'package:app_notes/repository/firebase/note.repository.dart';
// import 'package:app_notes/routes.dart';
// import 'package:app_notes/services/note.service.dart';
// import 'package:app_notes/widgets/utils.widget.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class AjoutPage extends StatefulWidget {
//   AjoutPage({Key? key}) : super(key: key);

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<AjoutPage> {
//   final matiereController = TextEditingController();
//   final noteController = TextEditingController();

//   void clearText() {
//     matiereController.clear();
//     noteController.clear();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeCubit, ThemeData>(
//       builder: (context, currentTheme) {
//         return Scaffold(
//           extendBodyBehindAppBar: true,
//           appBar: AppBar(
//             actions: [
//               IconButton(
//                 onPressed: () => Navigator.pushNamed(context, Routes.HOME_PAGE),
//                 icon: const Icon(Icons.home),
//               ),
//             ],
//             backgroundColor: currentTheme.primaryColor,
//             elevation: 0,
//             title: const Text(
//               "Ajout de notes",
//               style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//             ),
//           ),
//           body: Container(
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height,
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   currentTheme.primaryColor,
//                   currentTheme.hintColor,
//                   currentTheme.canvasColor,
//                 ],
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//               ),
//             ),
//             child: SingleChildScrollView(
//               child: Padding(
//                 padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
//                 child: Column(
//                   children: <Widget>[
//                     const SizedBox(height: 20),
//                     reusableTextField(
//                       "Entrer la matiere",
//                       Icons.ad_units,
//                       false,
//                       matiereController,
//                     ),
//                     const SizedBox(height: 20),
//                     reusableTextField(
//                       "Enter la note",
//                       Icons.fact_check,
//                       false,
//                       noteController,
//                     ),
//                     const SizedBox(height: 20),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: [
//                         SizedBox(
//                           width: 150, // Ajout de la largeur de 200
//                           child: firebaseUIButton(
//                             context,
//                             'Enregistrer',
//                             () async {
//                               String matiere = matiereController.text;
//                               String note = noteController.text;
//                               NoteM newNote = NoteM(
//                                 matiere: matiere,
//                                 note: note,
//                               );
//                               await NoteService().createNote(newNote);
//                               bool result = NoteService().verif;
//                               clearText();
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   backgroundColor: Colors.green,
//                                   behavior: SnackBarBehavior.floating,
//                                   content: result
//                                       ? const Text('Note enregistrée')
//                                       : const Text(
//                                           'Note non enregistrée',
//                                           selectionColor: Colors.red,
//                                         ),
//                                   duration: const Duration(seconds: 3),
//                                 ),
//                               );
//                             },
//                           ),
//                         ),
//                         SizedBox(
//                           width: 150,
//                           child: firebaseUIButton(
//                             context,
//                             'Annuler',
//                             clearText,
//                           ),
//                         ),
//                       ],
//                     )
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
