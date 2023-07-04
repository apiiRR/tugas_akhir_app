part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileStateInitial extends ProfileState {}

class ProfileStateLoading extends ProfileState {}

class ProfileStateComplete extends ProfileState {}

class ProfileStateError extends ProfileState {
  ProfileStateError(this.message);

  final String message;
}
