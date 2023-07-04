part of 'attedance_bloc.dart';

abstract class AttedanceEvent {}

class AttedanceEventClock extends AttedanceEvent {
  AttedanceEventClock(this.photo);

  final String photo;
}
