import 'package:flutter/material.dart';

import '../constants.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white,
              Color(0xFFF8F8EE),
            ],
          ),
        ),
        child: Center(
          child: Text(
            "Error occured. Please restart the application.",
            style: TextStyle(color: MainBackgroundColor),
          ),
        ),
      ),
    );
  }
}
