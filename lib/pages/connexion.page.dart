import 'package:app_notes/pages/forget.pwd.page.dart';
import 'package:app_notes/pages/home.page.dart';
import 'package:app_notes/pages/inscription.page.dart';
import 'package:app_notes/repository/firebase/authentification.repository.dart';
import 'package:app_notes/repository/google.auth.dart';
import 'package:app_notes/widgets/utils.widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_notes/bloc/theme.cubit.dart';

class ConnexionPage extends StatefulWidget {
  const ConnexionPage({Key? key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<ConnexionPage> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  final FirebaseService _firebaseService = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, currentTheme) {
        return Scaffold(
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.fromLTRB(
                  20,
                  MediaQuery.of(context).size.height * 0.2,
                  20,
                  0,
                ),
                child: Column(
                  children: <Widget>[
                    InkWell(
                       onTap: () => Service().googleSignin(context),
                      child: logoWidget("assets/images/search.png"),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    reusableTextField(
                      "Nom d'utilisateur",
                      Icons.person_outline,
                      false,
                      _emailTextController,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    reusableTextField(
                      "Mot de passe",
                      Icons.lock_outline,
                      true,
                      _passwordTextController,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    forgetPassword(context),
                    firebaseUIButton(context, "Se connecter", () async {
                      if (_emailTextController.text.isEmpty ||
                          _passwordTextController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.red,
                            behavior: SnackBarBehavior.floating,
                            content: Text("Tous les champs sont obligatoires"),
                            duration: Duration(seconds: 3),
                          ),
                        );
                      } else {
                        try {
                          await _firebaseService.signIn(
                              _emailTextController.text,
                              _passwordTextController.text);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ),
                          );
                        } on FirebaseAuthException catch (error) {
                          print(error);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                              content:
                                  Text("Email et/ou mot de passe incorrect"),
                              duration: Duration(seconds: 3),
                            ),
                          );
                          print("Error ${error.toString()}");
                        }
                      }
                    }),
                    signUpOption()
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Besoin d'uncompte?",
            style: TextStyle(color: Colors.white70)),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const InsscriptionPage(),
              ),
            );
          },
          child: const Text(
            " S'inscrire",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget forgetPassword(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 35,
      alignment: Alignment.bottomRight,
      child: TextButton(
        child: const Text(
          "mot de passe oublié?",
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.right,
        ),
        onPressed: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ResetPassword())),
      ),
    );
  }
}
