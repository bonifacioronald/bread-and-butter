import 'package:flutter/material.dart';
import 'dart:async';

import 'package:provider/provider.dart';
import 'package:draggable_bottom_sheet/draggable_bottom_sheet.dart';

import '../models/colors.dart' as custom_colors;
import '../navigation.dart';
import '../providers/transaction_provider.dart';
import '../providers/user_provider.dart';
import '../screens/setting_screen.dart';
import '../widgets/recent_transaction_sheet.dart';
import '../widgets/main_menu_action_button.dart';
import '../widgets/main_budget_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //Get BottomNavBar from GlobalKey to access onTap
  BottomNavigationBar get navigationBar {
    return NavigationState.globalKey.currentWidget as BottomNavigationBar;
  }

  //Check For Data Loading
  bool timerHasStrarted = false;
  void startLoading() {
    timerHasStrarted = true;
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (TransactionProvider.isLoading == false) {
        setState(() {
          timer.cancel();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double totalSpending = Provider.of<UserProvider>(context).monthlyBudget -
        Provider.of<UserProvider>(context).remainingBudget;

    if (TransactionProvider.isLoading == true && timerHasStrarted == false) {
      startLoading();
    }

    return Container(
      color: custom_colors.backgroundPrimaryBlack,
      width: double.infinity,
      height: double.infinity,
      child: TransactionProvider.isLoading
          ? Center(
              child: CircularProgressIndicator(
                  color: custom_colors.secondaryAccentGreen),
            )
          : RefreshIndicator(
              color: custom_colors.secondaryAccentGreen,
              onRefresh: () async {
                return Future<void>.delayed(
                  Duration(seconds: 1),
                  (() {
                    Provider.of<TransactionProvider>(context, listen: false)
                        .updateTransactionData();
                    Provider.of<UserProvider>(context, listen: false)
                        .updateUserData();
                  }),
                );
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: [
                        MainBudgetCard(),
                        SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: DraggableBottomSheet(
                      minExtent: 110,
                      barrierColor: Colors.transparent,
                      curve: Curves.easeIn,
                      expansionExtent: 0.5,
                      onDragging: (pos) {},
                      previewWidget: RecentTransactionsCard(),
                      expandedWidget: ExpandedRecentTransactionsCard(),
                      backgroundWidget: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  child: MainMenuActionButton(
                                    'Insight',
                                    custom_colors.secondaryAccentGreen,
                                    Icons.bar_chart,
                                  ),
                                  onTap: () {
                                    navigationBar.onTap!(1);
                                  },
                                ),
                                GestureDetector(
                                  child: MainMenuActionButton(
                                      'Adjust',
                                      custom_colors.greenAccentVariation,
                                      Icons.settings),
                                  onTap: (() => Navigator.of(context)
                                      .pushNamed(SettingScreen.routeName)),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 60,
                            ),
                            Text(
                              'Total Spending',
                              style: TextStyle(
                                  color: Colors.white.withOpacity(0.8),
                                  fontSize: 16),
                            ),
                            SizedBox(height: 30),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'RM$totalSpending',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 26,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  '${(totalSpending / Provider.of<UserProvider>(context).monthlyBudget * 100).toStringAsFixed(2)}% Used',
                                  style: TextStyle(
                                      color: custom_colors.secondaryAccentGreen,
                                      fontSize: 16),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
