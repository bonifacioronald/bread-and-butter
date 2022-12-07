import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../models/colors.dart' as custom_colors;
import '../models/transaction.dart';
import '../widgets/all_transaction_category_button.dart';
import '../providers/transaction_provider.dart';

class AllTransactionCard extends StatefulWidget {
  @override
  State<AllTransactionCard> createState() => AllTransactionCardState();
}

class AllTransactionCardState extends State<AllTransactionCard> {
  @override
  Widget build(BuildContext context) {
    List<DateTime> distinctDateList =
        Provider.of<TransactionProvider>(context).distinctDateList;
    List<Transaction> transactionList =
        Provider.of<TransactionProvider>(context).transactionList;

    return ClipRRect(
      borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40), topRight: Radius.circular(40)),
      child: Container(
        padding: EdgeInsets.only(top: 30, left: 20, right: 20),
        width: double.infinity,
        height: double.infinity,
        color: custom_colors.darkGray,
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.only(left: 20),
                width: double.infinity,
                height: 30,
                child: Row(
                  children: [
                    GestureDetector(
                      child: transactionCategoryButton('All'),
                      onTap: () {
                        setState(() {
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .switchTransactionCategory('all');
                        });
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: transactionCategoryButton('Income'),
                      onTap: () {
                        setState(() {
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .switchTransactionCategory('income');
                        });
                      },
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      child: transactionCategoryButton('Expense'),
                      onTap: () {
                        setState(() {
                          Provider.of<TransactionProvider>(context,
                                  listen: false)
                              .switchTransactionCategory('expense');
                        });
                      },
                    ),
                  ],
                )),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 20, right: 20, left: 20),
                decoration: BoxDecoration(
                  color: custom_colors.darkGrayVariation,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20)),
                ),
                child: distinctDateList.isEmpty
                    ? Center(
                        child: Text(
                          'No Recent Transactions\nFor This Month',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.2)),
                          textAlign: TextAlign.center,
                        ),
                      )
                    : ListView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: distinctDateList.length,
                        itemBuilder: (_, i) {
                          return Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      DateFormat('dd MMM')
                                          .format(distinctDateList[i]),
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white.withOpacity(0.4)),
                                    ),
                                    Column(
                                      children: transactionList.map((tx) {
                                        //If Category == All
                                        if (Provider.of<TransactionProvider>(
                                                    context,
                                                    listen: false)
                                                .selectedAllTransactionCategory ==
                                            'all') {
                                          if (tx.date == distinctDateList[i]) {
                                            return Container(
                                              height: 50,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    tx.title,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    tx.expsenseOrIncome ==
                                                            'expense'
                                                        ? '-${tx.amount.toString()}'
                                                        : '+${tx.amount.toString()}',
                                                    style: TextStyle(
                                                        color: tx.expsenseOrIncome ==
                                                                'expense'
                                                            ? Colors.white
                                                            : custom_colors
                                                                .secondaryAccentGreen,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }
                                        //If Category != All
                                        else {
                                          if (tx.date == distinctDateList[i] &&
                                              tx.expsenseOrIncome ==
                                                  Provider.of<TransactionProvider>(
                                                          context,
                                                          listen: false)
                                                      .selectedAllTransactionCategory) {
                                            return Container(
                                              height: 50,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    tx.title,
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                    ),
                                                  ),
                                                  Text(
                                                    tx.expsenseOrIncome ==
                                                            'expense'
                                                        ? '-${tx.amount.toString()}'
                                                        : '+${tx.amount.toString()}',
                                                    style: TextStyle(
                                                        color: tx.expsenseOrIncome ==
                                                                'expense'
                                                            ? Colors.white
                                                            : custom_colors
                                                                .secondaryAccentGreen,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ],
                                              ),
                                            );
                                          } else {
                                            return Container();
                                          }
                                        }
                                      }).toList(),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                            ],
                          );
                        },
                      ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
