import 'dart:io';

class ProfileImageState {
  final File? imageFile;
  ProfileImageState({this.imageFile});

  ProfileImageState copyWith({File? imageFile}) {
    return ProfileImageState(imageFile: imageFile ?? this.imageFile);
  }
}
