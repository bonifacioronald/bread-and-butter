import 'package:budget_tracking_app/providers/transaction_provider.dart';
import 'package:budget_tracking_app/providers/user_provider.dart';
import 'package:budget_tracking_app/screens/home_screen.dart';
import 'package:budget_tracking_app/screens/insight_screen.dart';
import 'package:budget_tracking_app/widgets/custom_appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/add_new_transaction_fab.dart';
import './models/colors.dart' as custom_colors;

class Navigation extends StatefulWidget {
  @override
  State<Navigation> createState() => NavigationState();
}

class NavigationState extends State<Navigation> {
  static GlobalKey<NavigationState> globalKey =
      new GlobalKey<NavigationState>();
  int currentIndex = 0;
  List<Widget> screens = [HomeScreen(), InsightScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(56), child: CustomAppBar()),
      floatingActionButton: AddNewTransactionFab(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        height: 70,
        color: custom_colors.darkGray,
        child: BottomNavigationBar(
          key: globalKey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: custom_colors.lightGrayNavBar,
          currentIndex: currentIndex,
          onTap: (int newIndex) {
            if (TransactionProvider.isLoading == false) {
              setState(() {
                currentIndex = newIndex;
              });
            }
          },
          items: [
            BottomNavigationBarItem(
                label: '',
                icon: Icon(
                  Icons.home_rounded,
                  color: currentIndex == 0
                      ? custom_colors.secondaryAccentGreen
                      : Colors.white.withOpacity(0.5),
                  size: 28,
                )),
            BottomNavigationBarItem(
                label: '',
                icon: Icon(Icons.bar_chart_rounded,
                    color: currentIndex == 1
                        ? custom_colors.secondaryAccentGreen
                        : Colors.white.withOpacity(0.5),
                    size: 28)),
          ],
        ),
      ),
    );
  }
}
