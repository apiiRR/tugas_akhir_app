import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

import 'package:tugas_akhir_project/domain/model/attedance_model.dart';

import '../../../domain/model/leave_model.dart';
import '../../../domain/model/profile_model.dart';
import 'firestore_interface.dart';

class FirestoreServices implements FirestoreInterface {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  DateTime now = DateTime.now();

  @override
  Stream<QuerySnapshot<AttedanceModel>> streamCurrentAttedance() async* {
    String uid = auth.currentUser!.uid;
    DateTime now = DateTime.now();
    String todayDoc = DateFormat.yMd().format(now).replaceAll("/", "-");

    Query<Map<String, dynamic>> colPresence = firestore
        .collection("attedances")
        .where("userId", isEqualTo: uid)
        .where("date", isEqualTo: todayDoc);

    yield* colPresence
        .withConverter(
            fromFirestore: (snapshot, _) =>
                AttedanceModel.fromJson(snapshot.data()!),
            toFirestore: (attedance, _) => attedance.toJson())
        .snapshots();
  }

  @override
  Stream<DocumentSnapshot<ProfileModel>> streamCurrentProfile() async* {
    String uid = auth.currentUser!.uid;

    DocumentReference<Map<String, dynamic>> colProfile =
        firestore.collection("accounts").doc(uid);

    yield* colProfile
        .withConverter(
            fromFirestore: (snapshot, _) =>
                ProfileModel.fromJson(snapshot.data()!),
            toFirestore: (attedance, _) => attedance.toJson())
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<AttedanceModel>> streamAttedance() async* {
    String uid = auth.currentUser!.uid;

    Query<Map<String, dynamic>> colPresence =
        firestore.collection("attedances").where("userId", isEqualTo: uid);

    yield* colPresence
        .withConverter(
            fromFirestore: (snapshot, _) =>
                AttedanceModel.fromJson(snapshot.data()!),
            toFirestore: (attedance, _) => attedance.toJson())
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<LeaveModel>> streamLeave() async* {
    String uid = auth.currentUser!.uid;

    Query<Map<String, dynamic>> colPresence =
        firestore.collection("leaves").where("userId", isEqualTo: uid);

    yield* colPresence
        .withConverter(
            fromFirestore: (snapshot, _) =>
                LeaveModel.fromJson(snapshot.data()!),
            toFirestore: (attedance, _) => attedance.toJson())
        .snapshots();
  }
}
