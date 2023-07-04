import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tugas_akhir_project/presentation/screens/history_page/detail_history_page.dart';

import '../../domain/model/attedance_model.dart';
import '../../domain/model/leave_model.dart';
import '../../injector.dart';
import '../screens/add_leave_page/add_leave_page.dart';
import '../screens/leave_page/detail_leave_page.dart';
import '../screens/history_page/history_page.dart';
import '../screens/home_page/home_page.dart';
import '../screens/intro_page/intro_page.dart';
import '../screens/leave_page/leave_page.dart';
import '../screens/login_page/login_page.dart';
import '../screens/main_page/main_page.dart';
import '../screens/profile_page/profile_page.dart';
import '../screens/profile_page/update_password_page.dart';

export 'package:go_router/go_router.dart';
part 'route_name.dart';

final router = GoRouter(
  debugLogDiagnostics: true,
  // initialLocation: isLogin(),
  redirect: (context, state) async {
    SharedPreferences sharedPreferences =
        await locator.getAsync<SharedPreferences>();
    bool isFirstLaunch = sharedPreferences.getBool('first_launch') ?? true;

    FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      if (isFirstLaunch) {
        return "/intro";
      } else {
        return "/login";
      }
    } else {
      return null;
    }
  },
  routes: [
    ShellRoute(
        pageBuilder: (context, state, child) {
          return NoTransitionPage(child: MainPage(child: child));
        },
        routes: [
          GoRoute(
            path: '/',
            name: Routes.homePage,
            // builder: (context, state) => const HomePage(),
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomePage()),
          ),
          GoRoute(
            path: '/history',
            name: Routes.historyPage,
            // builder: (context, state) => const HistoryPage()
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HistoryPage()),
          ),
          GoRoute(
              path: '/leave',
              name: Routes.leavePage,
              // builder: (context, state) => const LeavePage()
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: LeavePage())),
        ]),
    GoRoute(
        path: '/login',
        name: Routes.loginPage,
        builder: (context, state) => LoginPage()),
    GoRoute(
        path: '/intro',
        name: Routes.introPage,
        builder: (context, state) => const IntroPage()),
    GoRoute(
        path: '/detailHistory',
        name: Routes.detailHistoryPage,
        pageBuilder: (context, state) => NoTransitionPage(
                child: DetailHistoryPage(
              data: state.extra as AttedanceModel,
            ))),
    GoRoute(
        path: '/detailLeave',
        name: Routes.detailLeavePage,
        pageBuilder: (context, state) => NoTransitionPage(
                child: DetailLeavePage(
              data: state.extra as LeaveModel,
            ))),
    GoRoute(
        path: '/profile',
        name: Routes.profilePage,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: ProfilePage()),
        routes: [
          GoRoute(
              path: 'changePassword',
              name: Routes.passwordPage,
              pageBuilder: (context, state) =>
                  NoTransitionPage(child: UpdatePasswordPage()))
        ]),
    GoRoute(
        path: '/addLeave',
        name: Routes.addLeavePage,
        pageBuilder: (context, state) =>
            NoTransitionPage(child: AddLeavePage())),
  ],
);

// String? isLogin() {
//   SharedPreferences sharedPreferences = locator<SharedPreferences>();
//   bool isFirstLaunch = sharedPreferences.getBool('first_launch') ?? true;

//   FirebaseAuth auth = FirebaseAuth.instance;

//   if (auth.currentUser == null) {
//     if (isFirstLaunch) {
//       return "/intro";
//     } else {
//       return "/login";
//     }
//   } else {
//     return null;
//   }
// }
