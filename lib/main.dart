import 'package:budget_tracking_app/navigation.dart';
import 'package:budget_tracking_app/providers/transaction_provider.dart';
import 'package:budget_tracking_app/providers/user_provider.dart';
import 'package:budget_tracking_app/screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/gsheets_api_provider.dart';

void main() {
  GsheetsApiProvider.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: GsheetsApiProvider(),
        ),
        ChangeNotifierProvider.value(
          value: TransactionProvider(),
        ),
        ChangeNotifierProvider.value(
          value: UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bread&Butter',
        theme: ThemeData(fontFamily: 'Inter'),
        home: Navigation(),
        routes: {SettingScreen.routeName: (context) => SettingScreen()},
      ),
    );
  }
}
