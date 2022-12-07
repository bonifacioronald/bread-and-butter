import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/colors.dart' as custom_colors;
import '../providers/user_provider.dart';

class RemainingBudgetBar extends StatelessWidget {
  const RemainingBudgetBar({super.key});

  @override
  Widget build(BuildContext context) {
    double barWidth = Provider.of<UserProvider>(context).remainingBudget /
        Provider.of<UserProvider>(context).monthlyBudget;

    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: Stack(
        children: [
          Container(
            height: 10,
            width: double.infinity,
            color: custom_colors.lightGrayNavBar.withOpacity(0.7),
          ),
          FractionallySizedBox(
            widthFactor: barWidth,
            child: Container(
              height: 10,
              color: custom_colors.secondaryAccentGreen,
            ),
          ),
        ],
      ),
    );
  }
}
