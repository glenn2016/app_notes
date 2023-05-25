// ignore_for_file: constant_identifier_names

import 'package:app_notes/bloc/note/note.dart';
import 'package:app_notes/models/note.dart';
import 'package:app_notes/pages/ajout.page.dart';

import 'package:app_notes/pages/connexion.page.dart';
import 'package:app_notes/pages/home.page.dart';
import 'package:app_notes/pages/inscription.page.dart';
import 'package:app_notes/pages/liste.page.dart';
import 'package:app_notes/pages/public.page.dart.dart';
import 'package:app_notes/pages/repart.page.dart';
import 'package:app_notes/pages/update.page.dart';

import 'package:flutter/material.dart';

class Routes {
  static const String HOME_PAGE = '/';
  static const String SIGN_IN_SCREEN = '/connexion';
  static const String SIGN_UP_SCREEN = '/inscription';
  static const String LISTE_PAGE = '/liste';
  static const String AJOUT_PAGE = '/ajout';
  static const String UPDATE_PAGE = '/modifier';
  static const String PUBLIC_PAGE = '/liste2';
  static const String REPART_PAGE = '/repart';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case HOME_PAGE:
        return MaterialPageRoute(builder: (_) => const HomePage());
      case SIGN_IN_SCREEN:
        return MaterialPageRoute(builder: (_) => const ConnexionPage());
      case SIGN_UP_SCREEN:
        return MaterialPageRoute(builder: (_) => const InsscriptionPage());
      case LISTE_PAGE:
        return MaterialPageRoute(builder: (_) => ListePage());
      case AJOUT_PAGE:
        return MaterialPageRoute(builder: (_) => AjoutPage());
      case PUBLIC_PAGE:
        return MaterialPageRoute(builder: (_) => PublicPage());
      case REPART_PAGE:
        return MaterialPageRoute(builder: (_) => RepartPage());
      case UPDATE_PAGE:
        final note = settings.arguments as Note;
        return MaterialPageRoute(
            builder: (_) => ModificationPage(
                  note: note,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                    child: Text('No route defined for ${settings.name}'),
                  ),
                ));
    }
  }
}
