import 'package:flutter/material.dart';

import 'package:gsheets/gsheets.dart';
import 'package:intl/intl.dart';

import '../api/api_key.dart' as API_KEY;
import '../models/transaction.dart';
import '../providers/transaction_provider.dart';

class GsheetsApiProvider with ChangeNotifier {
  static const credentials = API_KEY.credentials;

  static const spreadsheetId = API_KEY.spreadsheetId;

  static final gsheets = GSheets(credentials);
  static Worksheet? worksheet;
  static bool isLoadingInsertingNewTx = false;
  static String worksheetMonth = DateFormat('MMMM yyyy').format(DateTime.now());

  static Future init() async {
    final ss = await gsheets.spreadsheet(spreadsheetId);
    worksheet = ss.worksheetByTitle(worksheetMonth);
    countRows();
  }

  static Future countRows() async {
    while ((await worksheet!.values.value(
            column: 1, row: TransactionProvider.numberOfTransactions + 1)) !=
        '') {
      TransactionProvider.numberOfTransactions++;
    }
    loadTransactions();
  }

  static Future loadTransactions() async {
    if (worksheet == null) return;

    for (int i = 1; i < TransactionProvider.numberOfTransactions; i++) {
      final String transactionDate =
          await worksheet!.values.value(column: 1, row: i + 1);
      final String transactionTitle =
          await worksheet!.values.value(column: 2, row: i + 1);
      final String transactionAmount =
          await worksheet!.values.value(column: 3, row: i + 1);
      final String transactionType =
          await worksheet!.values.value(column: 4, row: i + 1);

      if (TransactionProvider.LoadedTransactionList.length <
          TransactionProvider.numberOfTransactions) {
        TransactionProvider.LoadedTransactionList.add(
          Transaction(
              title: transactionTitle,
              amount: double.parse(transactionAmount),
              date: DateTime.parse(transactionDate),
              expsenseOrIncome: transactionType),
        );
      }
    }
    print(TransactionProvider.LoadedTransactionList);
    TransactionProvider.isLoading = false;
  }

  static Future insert(
      String title, String amount, String expenseOrIncome) async {
    if (worksheet == null) return;

    isLoadingInsertingNewTx = true;

    TransactionProvider.numberOfTransactions++;
    TransactionProvider.LoadedTransactionList.add(Transaction(
        title: title,
        amount: double.parse(amount),
        date: DateTime.parse(DateFormat('yyyy-MM-dd').format(DateTime.now())),
        expsenseOrIncome: expenseOrIncome));
    List<dynamic> newTransaction = [];
    newTransaction.add(DateFormat('yyyy-MM-dd').format(DateTime.now()));
    newTransaction.add(title);
    newTransaction.add(amount);
    newTransaction.add(expenseOrIncome);
    await worksheet!.values.appendRow(newTransaction);
  }
}
