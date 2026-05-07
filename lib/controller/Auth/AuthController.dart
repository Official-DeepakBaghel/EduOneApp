import 'package:eduone/model/LocalDB/local_db.dart';
import 'package:eduone/model/Repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Authcontroller extends GetxController {
  final Repo _repo = Repo();

  Future<void> studentLogin(String email, String password, String id) async {
    final response = await _repo.studentLogin(
      email: email,
      password: password,
      id: id,
    );
    if (response.message == "Login Successfully") {
      // Save Token and Role
      await LocalDB.saveToken(response.token);
      await LocalDB.saveRole('student');
      Get.offAllNamed("/platform_home");
    } else {
      Get.snackbar(
        "Login Failed",
        response.message.isNotEmpty ? response.message : "Student Not Found",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }

  Future<void> teacherLogin(String email, String password, String id) async {
    final response = await _repo.teacherLogin(
      email: email,
      password: password,
      id: id,
    );
    if (response.message == "Login Successfully") {
      // Save Token and Role
      await LocalDB.saveToken(response.token);
      await LocalDB.saveRole('teacher');
      Get.offAllNamed("/platform_home");
    } else {
      Get.snackbar(
        "Login Failed",
        response.message.isNotEmpty ? response.message : "Teacher Not Found",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
    }
  }
}
