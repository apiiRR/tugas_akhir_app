part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class ProfileEventUpdatePhoto extends ProfileEvent {
  ProfileEventUpdatePhoto(this.photo);

  final String photo;
}

class ProfileEventUpdate extends ProfileEvent {
  ProfileEventUpdate(this.email, this.name, this.phoneNumber);

  final String name;
  final String email;
  final String phoneNumber;
}

class ProfileEventUpdatePassword extends ProfileEvent {
  ProfileEventUpdatePassword(this.password);

  final String password;
}
