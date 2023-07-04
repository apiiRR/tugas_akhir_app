part of 'leave_bloc.dart';

abstract class LeaveEvent {}

class LeaveEventAdd extends LeaveEvent {
  LeaveEventAdd(
      this.type, this.startLeave, this.endLeave, this.document, this.note);

  final int type;
  final DateTime startLeave;
  final DateTime endLeave;
  final PlatformFile? document;
  final String? note;
}
