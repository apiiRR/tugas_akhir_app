import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import '../../../domain/model/attedance_model.dart';

part 'attedance_event.dart';
part 'attedance_state.dart';

class AttedanceBloc extends Bloc<AttedanceEvent, AttedanceState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  AttedanceBloc() : super(AttedanceInitial()) {
    on<AttedanceEventClock>((event, emit) async {
      try {
        String uid = auth.currentUser!.uid;
        DateTime now = DateTime.now();
        String todayDoc = DateFormat.yMd().format(now).replaceAll("/", "-");

        CollectionReference<Map<String, dynamic>> colPresence =
            firestore.collection("attedances");

        final dataToday = await colPresence
            .where("userId", isEqualTo: uid)
            .where("date", isEqualTo: todayDoc)
            .get();

        if (dataToday.docs.isEmpty) {
          final AttedanceModel dataClockIn = AttedanceModel(
              checkIn: Check(time: now, photo: event.photo),
              checkOut: null,
              status: 1,
              userId: uid,
              date: todayDoc);
          await colPresence.add(dataClockIn.toJson());
        } else {
          final String docId = dataToday.docs.first.id;
          await colPresence.doc(docId).update({
            "checkOut": {"photo": event.photo, "time": now.toIso8601String()}
          });
        }
      } on FirebaseException catch (e) {
        emit(AttedanceError(e.message ?? "Attedance failed"));
      } catch (e) {
        emit(AttedanceError("Attedance failed"));
      }
    });
  }
}
