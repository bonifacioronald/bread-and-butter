import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/colors.dart' as custom_colors;
import '../providers/user_provider.dart';

class MainBudgetCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double remainingBudget = Provider.of<UserProvider>(context).remainingBudget;
    DateTime todayDate = DateTime.now();
    int lastDateOfTheMonth =
        DateTime(todayDate.year, todayDate.month + 1, 0).day;
    String formattedFinalDate =
        '$lastDateOfTheMonth/${todayDate.month}/${todayDate.year}';

    return Container(
      padding: EdgeInsets.all(20),
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/card_background.png'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(16),
          color: custom_colors.darkGray),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Remaining budget',
            style:
                TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
          ),
          Text(
            'RM${remainingBudget.toString()}',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w600, fontSize: 30),
          ),
          Text(
            'until $formattedFinalDate',
            style:
                TextStyle(color: Colors.white.withOpacity(0.7), fontSize: 14),
          ),
        ],
      ),
    );
  }
}
