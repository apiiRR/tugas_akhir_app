import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../domain/model/attedance_model.dart';
import '../../method.dart';

part 'attedance_event.dart';
part 'attedance_state.dart';

class AttedanceBloc extends Bloc<AttedanceEvent, AttedanceState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  AttedanceBloc() : super(AttedanceInitial()) {
    on<AttedanceEventClock>((event, emit) async {
      try {
        emit(AttedanceLoading());
        bool inArea = await checkArea();
        if (inArea == false) {
          emit(
              AttedanceError("Absent failed because you are outside the area"));
          return;
        }

        XFile? image = await pickImage();
        if (image == null) {
          emit(AttedanceError("Absent failed because photo is not found"));
          return;
        }

        bool isFaceDetected = await detectFace(File(image.path));
        if (isFaceDetected == false) {
          emit(AttedanceError("Absent failed because face not detected"));
          return;
        }

        String imageString = await uploadFile(image);
        await clock(imageString);
        emit(AttedanceComplete());
      } on FirebaseException catch (e) {
        emit(AttedanceError(e.message ?? "Attedance failed"));
      } catch (e) {
        emit(AttedanceError("Attedance failed"));
      }
    });
  }

  Future<void> clock(String photo) async {
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
          checkIn: Check(time: now, photo: photo),
          checkOut: null,
          status: 1,
          userId: uid,
          date: todayDoc);
      await colPresence.add(dataClockIn.toJson());
    } else {
      final String docId = dataToday.docs.first.id;
      await colPresence.doc(docId).update({
        "checkOut": {"photo": photo, "time": now.toIso8601String()}
      });
    }
  }
}
