import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/colors.dart' as custom_colors;

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({super.key});

  _launchURLApp() async {
    const url =
        'https://docs.google.com/spreadsheets/d/1fRTjTy0E8J8szUENoMCf5HRjKcLnQm96qHR6fizjGn8/edit#gid=0';
    try {
      launch(url);
    } catch (e) {
      throw e;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      titleSpacing: 20,
      backgroundColor: custom_colors.backgroundPrimaryBlack,
      elevation: 0,
      title: Row(
        children: [
          Container(
            width: 30,
            child: Image.asset(
              'assets/images/app_logo.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          SizedBox(
            width: 12,
          ),
          Text(
            'Bread&Butter',
            style: TextStyle(
                fontSize: 20, fontWeight: FontWeight.w600, color: Colors.white),
          ),
        ],
      ),
      actions: [
        Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              child: Icon(
                Icons.open_in_new_rounded,
                color: Colors.white,
              ),
              onTap: () {
                _launchURLApp();
              },
            ))
      ],
    );
  }
}
