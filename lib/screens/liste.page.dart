// import 'package:app_notes/bloc/theme.cubit.dart';
// import 'package:app_notes/models/note.dart';
// import 'package:app_notes/routes.dart';
// import 'package:app_notes/services/note.service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class ListePage extends StatelessWidget {
//   final NoteService noteService = NoteService();

//   ListePage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ThemeCubit, ThemeData>(
//       builder: (context, theme) {
//         return Scaffold(
//           appBar: AppBar(
//             actions: [
//               IconButton(
//                 onPressed: () => Navigator.pushNamed(context, Routes.HOME_PAGE),
//                 icon: const Icon(Icons.home),
//               ),
//             ],
//             title: Text(
//               "Mes notes",
//               style: theme.textTheme.headlineMedium,
//             ),
//             backgroundColor: theme.primaryColor,
//           ),
//           body: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 begin: Alignment.topCenter,
//                 end: Alignment.bottomCenter,
//                 colors: [
//                   theme.primaryColor,
//                   theme.hintColor,
//                   theme.canvasColor,
//                 ],
//               ),
//             ),
//             child: FutureBuilder<List<NoteM>>(
//               future: noteService.getNotes(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }
//                 if (!snapshot.hasData) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 final notes = snapshot.data!;

//                 return ListView.builder(
//                   itemCount: notes.length,
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       onTap: () {
//                         // TODO: Navigate to note detail page
//                       },
//                       child: Card(
//                         elevation: 3.0,
//                         margin: const EdgeInsets.symmetric(
//                             horizontal: 10.0, vertical: 6.0),
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20.0, vertical: 10.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: [
//                               Text(
//                                 'J\'ai eu  ${notes[index].note} en  ${notes[index].matiere}',
//                                 style: const TextStyle(fontSize: 18.0),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   Navigator.pushNamed(
//                                     context,
//                                     Routes.UPDATE_PAGE,
//                                     arguments: notes[index],
//                                   );
//                                 },
//                                 icon: Icon(
//                                   Icons.edit,
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                               ),
//                               IconButton(
//                                 onPressed: () {
//                                   noteService.deleteNote(notes[index].id as int);
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                       const SnackBar(
//                                           content: Text(
//                                               'La note a été supprimée')));
//                                 },
//                                 icon: Icon(
//                                   Icons.delete,
//                                   color: Theme.of(context).primaryColor,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 );
//               },
//             ),
//           ),
//           floatingActionButton: FloatingActionButton(
//             backgroundColor: Theme.of(context).primaryColor,
//             onPressed: () {
//               Navigator.pushNamed(context, Routes.AJOUT_PAGE);
//             },
//             child: const Icon(
//               Icons.add,
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
