import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'controllers/note_controller.dart';
import 'controllers/playlist_controller.dart';
import 'controllers/main_navbar_controller.dart';

import 'screens/main_navbar/main_navbar.dart';
import 'utils/app_theme.dart';

void main() {
  // Injecting controllers for global state
  Get.put(NoteController());
  Get.put(PlaylistController());
  Get.put(MainNavBarController());

  runApp(const StudentNotesApp());
}

class StudentNotesApp extends StatelessWidget {
  const StudentNotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Student Notes Hub',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system, // Automatically toggles based on system
      initialRoute: '/home',
      getPages: [GetPage(name: '/home', page: () => const MainNavBar())],
    );
  }
}
