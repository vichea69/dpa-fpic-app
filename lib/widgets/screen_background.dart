import 'package:flutter/material.dart';

/// Reusable background matching `MainScreen` gradient.
class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.white,
                  Color.fromARGB(177, 248, 248, 238),
                ],
              ),
            ),
        child: child,
      ),
    );
  }
}
