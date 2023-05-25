import 'package:app_notes/bloc/theme.cubit.dart';
import 'package:app_notes/pages/home.page.dart';
import 'package:app_notes/repository/firebase/authentification.repository.dart';
import 'package:app_notes/widgets/utils.widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InsscriptionPage extends StatefulWidget {
  const InsscriptionPage({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<InsscriptionPage> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();
  final TextEditingController _userNameTextController = TextEditingController();
  final FirebaseService _firebaseService = FirebaseService();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  String? _validateEmail(String? value) {
    final emailRegex = RegExp(r'^[\w-\.]+@+groupeisi\.com$');
    if (value == null || value.isEmpty) {
      return 'Veuillez entrer votre adresse email';
    } else if (!emailRegex.hasMatch(value)) {
      return 'Veuillez entrer une adresse email valide';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        return Theme(
          data: state,
          child: Scaffold(
            key: _scaffoldKey,
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: const Text(
                "Inscription",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                state.primaryColor,
                state.hintColor,
                state.canvasColor,
              ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 120, 20, 0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Nom d'utilisateur",
                          Icons.person_outline, false, _userNameTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField(
                        "Email",
                        Icons.email_outlined,
                        false,
                        _emailTextController,
                        validator: _validateEmail,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      reusableTextField("Mot de passe", Icons.lock_outlined,
                          true, _passwordTextController),
                      const SizedBox(
                        height: 20,
                      ),
                      firebaseUIButton(context, "S'incrire", () async {
                        String userName = _userNameTextController.text;
                        String email = _emailTextController.text;
                        String password = _passwordTextController.text;

                        // Validate inputs
                        if (userName.isEmpty ||
                            email.isEmpty ||
                            password.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                content:
                                    Text('Veuillez remplir tous les champs')),
                          );
                          return;
                        } else if (_validateEmail(email) != null) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                behavior: SnackBarBehavior.floating,
                                content: Text(
                                    'Veuillez entrer une adresse email valide')),
                          );
                          return;
                        }
                        try {
                          await _firebaseService.signUp(email, password, userName);
                          print("Created New Account");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()),
                          );
                        } catch (error) {
                          print("Error ${error.toString()}");
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
