import 'package:app_notes/bloc/theme.cubit.dart';
import 'package:app_notes/routes.dart';
import 'package:app_notes/widgets/drawer.menu.widget.dart';
import 'package:app_notes/widgets/utils.widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeData>(
      builder: (context, state) {
        return Scaffold(
          drawer: const MainDrawer(),
          appBar: AppBar(
             actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, Routes.SIGN_IN_SCREEN),
            icon: const Icon(Icons.logout),
          ),
        ],
            title: Text(
              "Home page",
              style: state.textTheme.headlineMedium,
            ),
            backgroundColor: state.primaryColor,
          ),
          body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  state.primaryColor,
                  state.hintColor,
                  state.canvasColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
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
                    logoWidget("assets/images/reeb.png"),
                    const SizedBox(
                      height: 30,
                    ),
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
