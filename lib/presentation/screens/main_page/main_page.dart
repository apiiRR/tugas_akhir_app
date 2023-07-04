import 'package:flutter/material.dart';
import 'package:tugas_akhir_project/presentation/routes/router.dart';

import 'components/item_nav.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      // IndexedStack(
      //   index: _currentIndex,
      //   children: _pages,
      // ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ItemNav(
                    onPressed: () {
                      context.goNamed(Routes.homePage);
                    },
                    icon: "Home.svg",
                    index: 0,
                    isActive: GoRouter.of(context).location == '/',
                    label: "Home"),
                ItemNav(
                    onPressed: () {
                      context.goNamed(Routes.historyPage);
                    },
                    icon: "Dashboard.svg",
                    index: 1,
                    isActive: GoRouter.of(context).location == '/history',
                    label: "History"),
                ItemNav(
                    onPressed: () {
                      context.goNamed(Routes.leavePage);
                    },
                    icon: "Calendar.svg",
                    index: 2,
                    isActive: GoRouter.of(context).location == '/leave',
                    label: "Leave"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
