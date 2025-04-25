import 'dart:async';
import 'package:booklist/core/appColors.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/DeviceUtils.dart';
import 'HomePage.dart';

import 'dart:async';
import 'package:flutter/material.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), _navigateToHome);
  }

  void _navigateToHome() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isLandscape = constraints.maxWidth > constraints.maxHeight;

          return Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Image.asset(
                  'images/logo.png',
                  fit: isLandscape ? BoxFit.fitHeight : BoxFit.fitWidth,
                  alignment: Alignment.center,
                ),
              ),

              // Responsive Content
              Positioned(
                bottom: DeviceUtils.isMobile(context) ? 20 : 40,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    if (isLandscape)
                      const SizedBox(height: 20),
                    const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Loading...',
                      style: TextStyle(
                        fontSize: DeviceUtils.responsiveFontSize(context, baseSize: 18),
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
