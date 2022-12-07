import 'package:flutter/material.dart';
import '../models/transaction.dart';

class TransactionProvider with ChangeNotifier {
  static int numberOfTransactions = 0;
  static List<Transaction> LoadedTransactionList = [];
  static bool isLoading = true;
  static String currentAllTransactionCategory = 'all';

  List<DateTime> get distinctDateList {
    List<DateTime> result = [];
    for (var tx in LoadedTransactionList) {
      result.add(tx.date);
    }
    List<DateTime> fetchedDistinctDates = result.toSet().toList();
    List<DateTime> reversedDistinctDates =
        new List.from(fetchedDistinctDates.reversed);
    return reversedDistinctDates;
  }

  double get totalMonthlyIncomeToDate {
    double result = 0;
    LoadedTransactionList.forEach((tx) {
      if (tx.expsenseOrIncome == 'income') {
        result += tx.amount;
      }
    });
    return result;
  }

  double get totalMonthlyExpenseToDate {
    double result = 0;
    LoadedTransactionList.forEach((tx) {
      if (tx.expsenseOrIncome == 'expense') {
        result += tx.amount;
      }
    });
    return result;
  }

  List<Transaction> get transactionList {
    return LoadedTransactionList;
  }

  static double get totalSpending {
    double result = 0;
    LoadedTransactionList.forEach((tx) {
      if (tx.expsenseOrIncome == 'expense') {
        result += tx.amount;
      } else if (tx.expsenseOrIncome == 'income') {
        result -= tx.amount;
      }
    });
    return result;
  }

  void updateTransactionData() {
    distinctDateList.toSet().toList();
    print(distinctDateList);
    notifyListeners();
  }

  String get selectedAllTransactionCategory {
    return currentAllTransactionCategory;
  }

  void switchTransactionCategory(String newCategory) {
    currentAllTransactionCategory = newCategory;
  }
}
