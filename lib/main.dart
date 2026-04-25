import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:eduone/view/collage_bunk_detector/camera_globals.dart' as cb;
import 'eduone_platform.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize cameras for EduOne Platform
  try {
    cb.cameras = await availableCameras();
  } catch (e) {
    debugPrint("Error initializing cameras: $e");
    cb.cameras = [];
  }

  runApp(const EduOneApp());
}
