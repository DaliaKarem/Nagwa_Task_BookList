import 'dart:async';
import 'package:booklist/core/appColors.dart';
import 'package:flutter/material.dart';
import 'features/HomePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // After 3 seconds, navigate to BookList
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Solid background color if you like
      backgroundColor: appColor.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/logo.png',
              width: 200,
              height: 200,
              fit: BoxFit.contain,
            ),
            Text("Book List",style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: appColor.textColor),)
          ],
        ),
      ),
    );
  }
}

