import 'package:flutter/material.dart';

class Transaction {
  String title;
  double amount;
  String expsenseOrIncome;
  DateTime date;

  Transaction(
      {required this.title,
      required this.amount,
      required this.date,
      required this.expsenseOrIncome});
}
