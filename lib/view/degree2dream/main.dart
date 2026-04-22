import 'package:eduone/view/degree2dream/core/theme/app_theme.dart';
import 'package:eduone/view/degree2dream/ui/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const CareerGuidanceApp());
}

class CareerGuidanceApp extends StatelessWidget {
  const CareerGuidanceApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Degree2Dream',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const HomeScreen(),
      defaultTransition: Transition.cupertino,
    );
  }
}

