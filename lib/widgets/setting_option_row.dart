import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class SettingOptionRow extends StatelessWidget {
  final IconData icon;
  final String text;
  SettingOptionRow(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    String currency =
        Provider.of<UserProvider>(context, listen: false).currency;
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
              ),
              SizedBox(
                width: 28,
              ),
              Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              Spacer(),
              Text(
                text == 'Monthly Budget'
                    ? Provider.of<UserProvider>(context)
                        .monthlyBudget
                        .toString()
                    : text == 'Initial Balance'
                        ? Provider.of<UserProvider>(context)
                            .initialBalance
                            .toString()
                        : currency,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600),
              )
            ],
          ),
          SizedBox(
            height: 4,
          ),
          Divider(
            color: Colors.white.withOpacity(0.3),
          )
        ],
      ),
    );
  }
}
