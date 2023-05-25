import 'package:app_notes/bloc/image/image.cubit.dart';
import 'package:app_notes/bloc/theme.cubit.dart';
import 'package:app_notes/pages/root.page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NoteApp extends StatelessWidget {
  const NoteApp({super.key});

 
@override
  Widget  build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ProfileImageCubit()),
        BlocProvider(create: (_) => ThemeCubit()),
        //BlocProvider(create: (_) => NoteCubit(noteRepository: NoteRepository())),
      ],
      child: const RootPage(),
    );
  }
}


