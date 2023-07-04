import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/model/attedance_model.dart';
import '../../../domain/model/leave_model.dart';
import '../../../domain/model/profile_model.dart';

abstract class FirestoreInterface {
  Stream<QuerySnapshot<AttedanceModel>> streamCurrentAttedance();
  Stream<QuerySnapshot<AttedanceModel>> streamAttedance();
    Stream<QuerySnapshot<LeaveModel>> streamLeave();
  Stream<DocumentSnapshot<ProfileModel>> streamCurrentProfile();
}
