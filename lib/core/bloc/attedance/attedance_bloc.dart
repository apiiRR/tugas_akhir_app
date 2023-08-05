import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../../../domain/model/attedance_model.dart';
import '../../../domain/model/leave_model.dart';
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

        bool isLeave = await checkLeave();
        if (isLeave == true) {
          emit(AttedanceError("Absent failed because you are leave"));
          return;
        }

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
    int status = 1;

    CollectionReference<Map<String, dynamic>> colPresence =
        firestore.collection("attedances");

    Map<String, dynamic> setting = await dataSetting();
    TimeOfDay timeSetting = TimeOfDay(
        hour: int.parse(setting["checkIn"].toString().substring(0, 2)),
        minute: int.parse(setting["checkIn"].toString().substring(3, 5)));

    DateTime dateTimeNow = DateTime(now.hour, now.minute);
    DateTime dateTimeSetting = DateTime(timeSetting.hour, timeSetting.minute);

    if (dateTimeNow.isAfter(dateTimeSetting) == true) {
      status = 2;
    }

    final dataToday = await colPresence
        .where("userId", isEqualTo: uid)
        .where("date", isEqualTo: todayDoc)
        .get();

    if (dataToday.docs.isEmpty) {
      final AttedanceModel dataClockIn = AttedanceModel(
          checkIn: Check(time: now, photo: photo),
          checkOut: null,
          status: status,
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

  Future<bool> checkLeave() async {
    String uid = auth.currentUser!.uid;
    DateTime now = DateTime.now();
    DateTime todayDoc = DateTime(now.year, now.month, now.day);
    bool result = false;

    CollectionReference<Map<String, dynamic>> colPresence =
        firestore.collection("leaves");

    final dataToday = await colPresence.where("userId", isEqualTo: uid).get();

    for (var data in dataToday.docs) {
      Map<String, dynamic> resultData = data.data();
      LeaveModel dataLeave = LeaveModel.fromJson(resultData);

      int duration = dataLeave.endLeave.difference(dataLeave.startLeave).inDays;
      int today = todayDoc.difference(dataLeave.startLeave).inDays;

      if (todayDoc == dataLeave.startLeave) {
        result = true;
      } else if (todayDoc == dataLeave.endLeave) {
        result = true;
      } else if (today <= duration) {
        result = true;
      }
    }

    return result;
  }
}
