import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/colors.dart' as custom_colors;
import '../screens/setting_screen.dart';
import '../widgets/insight_expense_income_display.dart';
import '../providers/transaction_provider.dart';
import '../providers/user_provider.dart';
import '../widgets/all_transaction_card.dart';
import '../widgets/remaining_budget_bar.dart';

class InsightScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double remainingBudget = Provider.of<UserProvider>(context).remainingBudget;
    double monthlyLimit = Provider.of<UserProvider>(context).monthlyBudget;
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: custom_colors.backgroundPrimaryBlack,
      child: RefreshIndicator(
        color: custom_colors.secondaryAccentGreen,
        onRefresh: () async {
          return Future<void>.delayed(Duration(seconds: 1), (() {
            Provider.of<TransactionProvider>(context, listen: false)
                .updateTransactionData();
            Provider.of<UserProvider>(context, listen: false).updateUserData();
          }));
        },
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 40, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remaining budget',
                    style: TextStyle(
                        color: Colors.white.withOpacity(0.5), fontSize: 16),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'RM$remainingBudget',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 30),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        '/ RM$monthlyLimit',
                        style: TextStyle(
                            color: Colors.white.withOpacity(1), fontSize: 16),
                      ),
                      Spacer(),
                      GestureDetector(
                          onTap: ((() => Navigator.of(context)
                              .pushNamed(SettingScreen.routeName))),
                          child: Icon(
                            Icons.settings,
                            color: custom_colors.secondaryAccentGreen,
                          ))
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  RemainingBudgetBar(),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${(remainingBudget / monthlyLimit * 100).toStringAsFixed(2)}% left',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.5), fontSize: 16),
                      ),
                      Text(
                        'RM${(monthlyLimit - remainingBudget)} spent',
                        style: TextStyle(
                            color: Colors.white.withOpacity(0.4), fontSize: 16),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  InsightExpenseIncomeDisplay(),
                  SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
            Expanded(
              child: AllTransactionCard(),
            )
          ],
        ),
      ),
    );
  }
}
