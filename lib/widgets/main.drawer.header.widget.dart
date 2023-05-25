import 'dart:io';

import 'package:app_notes/bloc/image/image.cubit.dart';
import 'package:app_notes/bloc/theme.cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MainDrawerHeader extends StatelessWidget {
  const MainDrawerHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profileImageCubit = context.watch<ProfileImageCubit>();
    final imageFile = profileImageCubit.state.imageFile;
    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Theme.of(context).primaryColor],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: imageFile != null
                    ? FileImage(imageFile)
                    : const AssetImage("assets/images/ze.jpg") as ImageProvider<Object>?,
              ),
              IconButton(
                onPressed: () async {
                  Map<Permission, PermissionStatus> statuses = await [
                    Permission.storage,
                    Permission.camera,
                  ].request();
                  if (statuses[Permission.storage]!.isGranted &&
                      statuses[Permission.camera]!.isGranted) {
                    final imagePicker = ImagePicker();
                    final pickedFile =
                        await imagePicker.pickImage(source: ImageSource.gallery);
                    if (pickedFile != null) {
                      profileImageCubit.setImageFile(File(pickedFile.path));
                    }
                  } else {
                    print('no permission provided');
                  }
                },
                icon: const Icon(Icons.image),
              ),
            ],
          ),
          IconButton(
            onPressed: () => context.read<ThemeCubit>().switchTheme(),
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}
