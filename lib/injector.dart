import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/bloc/bloc.dart';

GetIt locator = GetIt.instance;

void setupLocator() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  // SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

  // locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingletonAsync<SharedPreferences>(() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences;
  });
  locator.registerLazySingleton(() => auth);
  locator.registerLazySingleton(() => firestore);

  locator.registerLazySingleton<AuthBloc>(() => AuthBloc());
  locator.registerLazySingleton<AttedanceBloc>(() => AttedanceBloc());
  locator.registerLazySingleton<ProfileBloc>(() => ProfileBloc());
  locator.registerLazySingleton<LeaveBloc>(() => LeaveBloc());
}
