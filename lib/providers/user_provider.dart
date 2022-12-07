import 'package:flutter/material.dart';
import '../providers/transaction_provider.dart';

class UserProvider with ChangeNotifier {
  double monthlyBudget = 3600;
  double initialBalance = 3560;
  String currency = 'RM';

  double get remainingBudget {
    return monthlyBudget - TransactionProvider.totalSpending;
  }

  void updateUserData() {
    notifyListeners();
  }
}
