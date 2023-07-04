part of 'attedance_bloc.dart';

abstract class AttedanceState {}

class AttedanceInitial extends AttedanceState {}

class AttedanceLoading extends AttedanceState {}

class AttedanceComplete extends AttedanceState {}

class AttedanceError extends AttedanceState {
  AttedanceError(this.message);

  final String message;
}
