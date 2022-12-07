import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/colors.dart' as custom_colors;
import '../providers/transaction_provider.dart';

class InsightExpenseIncomeDisplay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double totalIncome =
        Provider.of<TransactionProvider>(context).totalMonthlyIncomeToDate;
    double totalExpense =
        Provider.of<TransactionProvider>(context).totalMonthlyExpenseToDate;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: custom_colors.secondaryAccentGreen),
              child: Icon(
                Icons.arrow_upward_rounded,
                color: Colors.white,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  totalIncome.toString(),
                  style: TextStyle(
                      fontSize: 24,
                      color: custom_colors.secondaryAccentGreen,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Total Income',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 16),
                )
              ],
            )
          ],
        ),
        Row(
          children: [
            Container(
              height: 40,
              width: 40,
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: Colors.white),
              child: Icon(
                Icons.arrow_downward_rounded,
                color: custom_colors.secondaryAccentGreen,
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  totalExpense.toString(),
                  style: TextStyle(
                      fontSize: 24,
                      color: custom_colors.secondaryAccentGreen,
                      fontWeight: FontWeight.w600),
                ),
                Text(
                  'Total Expense',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.5), fontSize: 16),
                )
              ],
            )
          ],
        ),
      ],
    );
  }
}
