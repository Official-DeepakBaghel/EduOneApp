import 'dart:convert';

import 'package:eduone/model/Auth/studentLoginModel.dart';
import 'package:eduone/model/Auth/teacherLoginModel.dart';
import 'package:http/http.dart' as http;

class Repo {
  final String baseUrl = "https://wxdwgnvr-5000.inc1.devtunnels.ms";

  final String token = "";

  Future<StudentLoginModel> studentLogin({
    required String email,
    required String password,
    required String id,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/api/auth/login"),
        body: jsonEncode({"email": email, "password": password, "id": id}),
        headers: {"Content-Type": "application/json"},
      );
      return StudentLoginModel.fromJson(jsonDecode(response.body));
    } catch (e) {
      return StudentLoginModel(
        message: e.toString(),
        token: "",
        user: StudentUser(id: "", email: "", role: ""),
      );
    }
  }

  Future<Teacherloginmodel> teacherLogin({
    required String email,
    required String password,
    required String id,
  }) async {
    try {
      var response = await http.post(
        Uri.parse("$baseUrl/api/auth/login"),
        body: jsonEncode({"email": email, "password": password, "id": id}),
        headers: {"Content-Type": "application/json"},
      );
      return Teacherloginmodel.fromJson(jsonDecode(response.body));
    } catch (e) {
      return Teacherloginmodel(
        message: e.toString(),
        token: "",
        user: TeacherUser(id: "", email: "", role: ""),
      );
    }
  }
}
