import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:daily_quotes/screens/loading_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Text(
        'Daily Quotes',
        style: TextStyle(
          fontSize: 50,
          fontWeight: FontWeight.bold,
        ),
      ),
      duration: 3000,
      splashTransition: SplashTransition.rotationTransition,
      backgroundColor: Colors.amberAccent,
      nextScreen: LoadingScreen(),
    );
  }
}
