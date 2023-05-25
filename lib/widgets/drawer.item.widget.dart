import 'package:flutter/material.dart';

class DrawerItemWidget extends StatelessWidget {
  final String title;
  final IconData leadingIcon;
  final Function onAction;

  const DrawerItemWidget(
      {super.key,
      required this.title,
      required this.leadingIcon,
      required this.onAction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall,    
      ),
      leading: Icon(leadingIcon, color: Theme.of(context).primaryColor),
      trailing:
          Icon(Icons.arrow_forward, color: Theme.of(context).primaryColor),
      onTap: () => onAction(),
    );
  }
}
