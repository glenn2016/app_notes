import 'package:app_notes/bloc/theme.cubit.dart';
import 'package:app_notes/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RootPage extends StatelessWidget {
  const RootPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(builder: (contex, state) {
      return MaterialApp(
        theme: state,
        onGenerateRoute: Routes.generateRoute,
        initialRoute: Routes.SIGN_IN_SCREEN,
      );
    });
  }
}
