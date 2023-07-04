import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:tugas_akhir_project/domain/model/leave_model.dart';

part 'leave_event.dart';
part 'leave_state.dart';

class LeaveBloc extends Bloc<LeaveEvent, LeaveState> {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<String> uploadFile(PlatformFile? pickedFile) async {
    DateTime now = DateTime.now();
    late String urlPhoto;
    if (pickedFile != null) {
      final path = 'leaves/${pickedFile.name + now.toIso8601String()}';
      final file = File(pickedFile.path!);

      try {
        final ref = FirebaseStorage.instance.ref().child(path);
        final uploadTask = ref.putData(file.readAsBytesSync());

        final snapshot = await uploadTask.whenComplete(() {});

        final urlDownload = await snapshot.ref.getDownloadURL();
        print("Download LINK : $urlDownload");
        urlPhoto = urlDownload;
      } on FirebaseException catch (e) {
        print(e.message);
      }
    }

    return urlPhoto;
  }

  LeaveBloc() : super(LeaveInitial()) {
    on<LeaveEventAdd>((event, emit) async {
      try {
        emit(LeaveLoading());

        String? urlDocument;
        String uid = auth.currentUser!.uid;
        DateTime now = DateTime.now();

        CollectionReference<Map<String, dynamic>> colLeave =
            firestore.collection("leaves");

        if (event.document != null) {
          urlDocument = await uploadFile(event.document);
        }

        final LeaveModel dataLeave = LeaveModel(
            type: event.type,
            startLeave: event.startLeave,
            endLeave: event.endLeave,
            document: urlDocument,
            note: event.note,
            createdAt: now,
            userId: uid);
        await colLeave.add(dataLeave.toJson());

        emit(LeaveComplete());
      } on FirebaseException catch (e) {
        emit(LeaveError(e.message ?? "Leave failed"));
      } catch (e) {
        emit(LeaveError("Leave failed"));
      }
    });
  }
}
