import 'package:app_notes/routes.dart';
import 'package:app_notes/widgets/drawer.item.widget.dart';
import 'package:app_notes/widgets/main.drawer.header.widget.dart';
import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    List<dynamic> menus = [
      {
        "title": "Home",
        "leadingIcon": Icons.home,
      },
      {
        "title": "Private notes",
        "leadingIcon": Icons.list,
      },
      {
        "title": "Public notes",
        "leadingIcon": Icons.list,
      },
      {
        "title": "Notes Répart",
        "leadingIcon": Icons.list,
      },
      {
        "title": "Ajouter",
        "leadingIcon": Icons.add_card,
      },
    ];
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          const MainDrawerHeader(),
          Expanded(
            child: ListView.separated(
              itemBuilder: (context, index) {
                return DrawerItemWidget(
                  title: menus[index]["title"],
                  leadingIcon: menus[index]["leadingIcon"],
                  onAction: () {
                    Navigator.pop(context);
                    switch (index) {
                      case 0:
                        Navigator.pushNamed(context, Routes.HOME_PAGE);
                        break;
                      case 1:
                        Navigator.pushNamed(context, Routes.LISTE_PAGE);
                        break;
                      case 2:
                        Navigator.pushNamed(context, Routes.PUBLIC_PAGE);
                        break;
                      case 3:
                        Navigator.pushNamed(context, Routes.REPART_PAGE);
                        break;
                      case 4:
                        Navigator.pushNamed(context, Routes.AJOUT_PAGE);
                        break;
                    }
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(
                  height: 6,
                );
              },
              itemCount: menus.length,
            ),
          )
        ],
      ),
    );
  }
}
