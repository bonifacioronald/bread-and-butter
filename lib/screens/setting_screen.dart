import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/colors.dart' as custom_colors;
import '../widgets/setting_option_row.dart';
import '../providers/transaction_provider.dart';
import '../providers/user_provider.dart';

class SettingScreen extends StatelessWidget {
  static const routeName = '/setting';

  //Open Google Sheet
  _launchURLApp() async {
    const url =
        'https://docs.google.com/spreadsheets/d/1fRTjTy0E8J8szUENoMCf5HRjKcLnQm96qHR6fizjGn8/edit#gid=0';
    try {
      launch(url);
    } catch (e) {
      throw e;
    }
  }

  final _textControllerMonthlyBudget = TextEditingController();
  final _textControllerInitialBalance = TextEditingController();

  final _newSettingAppliedSnackbar = SnackBar(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: EdgeInsets.all(20),
      backgroundColor: custom_colors.secondaryAccentGreen,
      behavior: SnackBarBehavior.floating,
      elevation: 40,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8))),
      content: const Text(
        'Successfuly edited settings!',
        style: TextStyle(color: Colors.white),
      ));

  @override
  Widget build(BuildContext context) {
    void applyNewSetting() {
      Provider.of<UserProvider>(context, listen: false).monthlyBudget =
          double.parse(_textControllerMonthlyBudget.text);

      Provider.of<UserProvider>(context, listen: false).initialBalance =
          double.parse(_textControllerInitialBalance.text);
      Provider.of<UserProvider>(context, listen: false).updateUserData();
      Provider.of<TransactionProvider>(context, listen: false)
          .updateTransactionData();
      print(Provider.of<UserProvider>(context, listen: false).monthlyBudget);
      ScaffoldMessenger.of(context).showSnackBar(_newSettingAppliedSnackbar);
    }

    void editSetting() {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            elevation: 20,
            backgroundColor: custom_colors.lightGrayNavBar,
            title: Text(
              'Adjust Settings',
              style: TextStyle(
                  color: custom_colors.secondaryAccentGreen,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            titlePadding: EdgeInsets.all(20),
            contentPadding: EdgeInsets.symmetric(horizontal: 20),
            actionsPadding: EdgeInsets.all(20),
            content: Container(
              height: 160,
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: _textControllerMonthlyBudget,
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
                        hintText: 'New monthly budget...',
                        hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                            fontSize: 16)),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextField(
                    controller: _textControllerInitialBalance,
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
                        hintText: 'New initial balance...',
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
                    'Apply',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                  onPressed: (() {
                    applyNewSetting();
                    Navigator.of(context).pop();
                  }),
                ),
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: custom_colors.darkGray,
        elevation: 0,
        titleSpacing: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: custom_colors.backgroundPrimaryBlack,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              height: 100,
              width: double.infinity,
              color: custom_colors.darkGray,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacer(),
                  Text(
                    'Settings',
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'GENERAL',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.white.withOpacity(0.5),
                              fontWeight: FontWeight.w600),
                        ),
                        Spacer(),
                        GestureDetector(
                          onTap: editSetting,
                          child: Container(
                            child: Row(
                              children: [
                                Icon(
                                  Icons.edit,
                                  color: custom_colors.secondaryAccentGreen,
                                ),
                                SizedBox(
                                  width: 8,
                                ),
                                Text(
                                  'Edit',
                                  style: TextStyle(
                                      color: custom_colors.secondaryAccentGreen,
                                      fontSize: 16),
                                )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SettingOptionRow(
                      Icons.attach_money_rounded,
                      'Monthly Budget',
                    ),
                    SettingOptionRow(
                      Icons.account_balance_rounded,
                      'Initial Balance',
                    ),
                    SettingOptionRow(
                      Icons.currency_exchange_outlined,
                      'Currency',
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'DATABASE',
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white.withOpacity(0.5),
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: (() => _launchURLApp()),
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        height: 50,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: custom_colors.secondaryAccentGreen),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              'Open Spreadsheet',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                            Icon(
                              Icons.open_in_new_rounded,
                              color: Colors.white,
                            )
                          ],
                        ),
                      ),
                    ),
                    Spacer(),
                    Container(
                      width: double.infinity,
                      child: Text(
                        'Bread&Butter v.1.0.0\nBonifacio Ronald @ 2022',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: custom_colors.darkGray, fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
