import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../injector.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileStateInitial()) {
    FirebaseAuth auth = locator.get<FirebaseAuth>();
    FirebaseFirestore firestore = locator.get<FirebaseFirestore>();

    on<ProfileEventUpdate>((event, emit) async {
      try {
        emit(ProfileStateLoading());
        // fungsi untuk login
        String uid = auth.currentUser!.uid;
        DocumentReference<Map<String, dynamic>> colAccount =
            firestore.collection("accounts").doc(uid);

        await colAccount.update({
          "name": event.name,
          "email": event.email,
          "phone": event.phoneNumber
        });

        emit(ProfileStateComplete());
      } on FirebaseAuthException catch (e) {
        // Error dari Firebase Auth
        emit(ProfileStateError(e.message.toString()));
      } catch (e) {
        // Error general
        emit(ProfileStateError(e.toString()));
      }
    });

    on<ProfileEventUpdatePassword>((event, emit) async {
      try {
        emit(ProfileStateLoading());
        // fungsi untuk login
        final User? user = auth.currentUser;

        if (user == null) return;

        user.updatePassword(event.password);

        emit(ProfileStateComplete());
      } on FirebaseAuthException catch (e) {
        // Error dari Firebase Auth
        emit(ProfileStateError(e.message.toString()));
      } catch (e) {
        // Error general
        emit(ProfileStateError(e.toString()));
      }
    });

    on<ProfileEventUpdatePhoto>((event, emit) async {
      try {
        emit(ProfileStateLoading());
        // fungsi untuk login
        String uid = auth.currentUser!.uid;
        DocumentReference<Map<String, dynamic>> colAccount =
            firestore.collection("accounts").doc(uid);

        await colAccount.update({"photo": event.photo});

        emit(ProfileStateComplete());
      } on FirebaseAuthException catch (e) {
        // Error dari Firebase Auth
        emit(ProfileStateError(e.message.toString()));
      } catch (e) {
        // Error general
        emit(ProfileStateError(e.toString()));
      }
    });
  }
}
