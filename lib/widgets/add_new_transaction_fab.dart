import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';

import '../models/colors.dart' as custom_colors;
import '../providers/gsheets_api_provider.dart';
import '../providers/transaction_provider.dart';
import '../providers/user_provider.dart';

class AddNewTransactionFab extends StatelessWidget {
  final _textControllerAmount = TextEditingController();
  final _textControllerTitle = TextEditingController();

  String expenseOrIncome = 'expense';

  final _transactionAddedSnackBar = SnackBar(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(20),
      backgroundColor: custom_colors.secondaryAccentGreen,
      behavior: SnackBarBehavior.floating,
      elevation: 40,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      content: const Text(
        'Successfuly added a new transaction!',
        style: TextStyle(color: Colors.white),
      ));

  @override
  Widget build(BuildContext context) {
    void enterTransaction() {
      GsheetsApiProvider.insert(_textControllerTitle.text,
              _textControllerAmount.text, expenseOrIncome)
          .then((value) {
        Provider.of<TransactionProvider>(context, listen: false)
            .updateTransactionData();
        Provider.of<UserProvider>(context, listen: false).updateUserData();
        ScaffoldMessenger.of(context).showSnackBar(_transactionAddedSnackBar);
        _textControllerAmount.clear();
        _textControllerTitle.clear();
      });
    }

    void newTransaction() {
      showDialog(
          context: context,
          builder: (_) {
            return AlertDialog(
              elevation: 20,
              backgroundColor: custom_colors.lightGrayNavBar,
              title: Text(
                'New Transaction',
                style: TextStyle(
                    color: custom_colors.secondaryAccentGreen,
                    fontSize: 20,
                    fontWeight: FontWeight.w600),
              ),
              titlePadding: EdgeInsets.all(20),
              contentPadding: EdgeInsets.symmetric(horizontal: 20),
              actionsPadding: EdgeInsets.all(20),
              content: Container(
                height: 250,
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: (() {
                                setState(() {
                                  expenseOrIncome = 'expense';
                                });
                              }),
                              child: Container(
                                height: 50,
                                width: 120,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: expenseOrIncome == 'expense'
                                            ? Colors.transparent
                                            : Colors.white.withOpacity(0.1)),
                                    color: expenseOrIncome == 'expense'
                                        ? custom_colors.secondaryAccentGreen
                                        : custom_colors.lightGrayNavBar,
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(8),
                                        bottomLeft: Radius.circular(8))),
                                child: Center(
                                  child: Text(
                                    'Expense',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: expenseOrIncome == 'expense'
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.5),
                                        fontWeight: expenseOrIncome == 'expense'
                                            ? FontWeight.w600
                                            : FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  expenseOrIncome = 'income';
                                });
                              },
                              child: Container(
                                height: 50,
                                width: 120,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 2,
                                        color: expenseOrIncome == 'income'
                                            ? Colors.transparent
                                            : Colors.white.withOpacity(0.1)),
                                    color: expenseOrIncome == 'income'
                                        ? custom_colors.secondaryAccentGreen
                                        : custom_colors.lightGrayNavBar,
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8))),
                                child: Center(
                                  child: Text(
                                    'Income',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: expenseOrIncome == 'income'
                                            ? Colors.white
                                            : Colors.white.withOpacity(0.5),
                                        fontWeight: expenseOrIncome == 'income'
                                            ? FontWeight.w600
                                            : FontWeight.normal),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    TextField(
                      controller: _textControllerAmount,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: custom_colors.secondaryAccentGreen,
                                  width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 2)),
                          hintText: 'Enter amount..',
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 16)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextField(
                      controller: _textControllerTitle,
                      style: TextStyle(fontSize: 16, color: Colors.white),
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: custom_colors.secondaryAccentGreen,
                                  width: 2)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.white.withOpacity(0.1),
                                  width: 2)),
                          hintText: 'Specify details..',
                          hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 16)),
                    ),
                  ],
                ),
              ),
              actions: [
                SizedBox(
                  width: 90,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.white)),
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontSize: 16,
                          color: custom_colors.secondaryAccentGreen),
                    ),
                    onPressed: (() {
                      Navigator.of(context).pop();
                    }),
                  ),
                ),
                SizedBox(
                  width: 90,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            custom_colors.secondaryAccentGreen)),
                    child: Text(
                      'Enter',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                    onPressed: (() {
                      if ((expenseOrIncome == 'expense' &&
                              double.parse(_textControllerAmount.text) <=
                                  Provider.of<UserProvider>(context,
                                          listen: false)
                                      .remainingBudget &&
                              _textControllerTitle.text.isNotEmpty) ||
                          expenseOrIncome == 'income') {
                        enterTransaction();
                        Navigator.of(context).pop();
                      } else {
                        showDialog(
                            context: context,
                            builder: (_) {
                              return AlertDialog(
                                insetPadding: EdgeInsets.all(20),
                                backgroundColor: custom_colors.darkGray,
                                content: Text(
                                  'Please enter a valid input!',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              );
                            });
                      }
                    }),
                  ),
                )
              ],
            );
          });
    }

    return Container(
      height: 70,
      width: 70,
      child: FloatingActionButton(
        backgroundColor: custom_colors.lightGrayNavBar,
        onPressed: () {
          if (TransactionProvider.isLoading == false) {
            newTransaction();
          }
        },
        child: Icon(
          Icons.add_rounded,
          size: 40,
          color: Colors.white,
        ),
      ),
    );
  }
}
