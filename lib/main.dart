import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'core/bloc/bloc.dart';
import 'core/bloc/leave/leave_bloc.dart';
import 'firebase_options.dart';
import 'injector.dart';
import 'presentation/routes/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => locator<AuthBloc>()),
          BlocProvider(create: (context) => locator<AttedanceBloc>()),
          BlocProvider(create: (context) => locator<ProfileBloc>()),
          BlocProvider(create: (context) => locator<LeaveBloc>()),
        ],
        child: ResponsiveSizer(builder: (context, orientation, screenType) {
          return MaterialApp.router(
            debugShowCheckedModeBanner: false,
            title: 'Attedance App',
            // routerConfig: router,
            routeInformationParser: router.routeInformationParser,
            routerDelegate: router.routerDelegate,
            routeInformationProvider: router.routeInformationProvider,
          );
        }));
  }
}
