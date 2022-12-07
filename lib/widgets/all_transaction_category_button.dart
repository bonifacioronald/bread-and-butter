import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/colors.dart' as custom_colors;
import '../providers/transaction_provider.dart';

class transactionCategoryButton extends StatelessWidget {
  final String text;
  transactionCategoryButton(this.text);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        children: [
          Text(
            text,
            style: TextStyle(
                color: Provider.of<TransactionProvider>(context)
                            .selectedAllTransactionCategory ==
                        text.toLowerCase()
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
                fontSize: 16,
                fontWeight: Provider.of<TransactionProvider>(context)
                            .selectedAllTransactionCategory ==
                        text
                    ? FontWeight.w600
                    : FontWeight.normal),
          ),
          SizedBox(
            height: 6,
          ),
          Container(
            height: 4,
            width: 4,
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Provider.of<TransactionProvider>(context)
                            .selectedAllTransactionCategory ==
                        text.toLowerCase()
                    ? custom_colors.secondaryAccentGreen
                    : Colors.transparent),
          )
        ],
      ),
    );
  }
}
