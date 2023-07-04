part of 'leave_bloc.dart';

abstract class LeaveState {}

class LeaveInitial extends LeaveState {}

class LeaveLoading extends LeaveState {}

class LeaveComplete extends LeaveState {}

class LeaveError extends LeaveState {
  LeaveError(this.message);

  final String message;
}
