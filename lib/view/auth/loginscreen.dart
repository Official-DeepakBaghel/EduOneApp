import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loginscreen extends StatelessWidget {
  const Loginscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {'role': 'student'};
    final String role = args['role'] ?? 'student';
    Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: false,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/eduone_auth_bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: Colors.black.withOpacity(0.3)),
            ),

            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 25,
                  vertical: 80,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 40,
                        horizontal: 20,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1.5,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withOpacity(0.1),
                            Colors.white.withOpacity(0.05),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Logo
                          Hero(
                            tag: 'app_logo',
                            child: Image.asset(
                              'assets/images/eduone_logo_gold.png',
                              height: 140,
                            ),
                          ),
                          const SizedBox(height: 12),

                          Text(
                            role == 'student'
                                ? "Student Login"
                                : "Teacher Login",
                            style: const TextStyle(
                              color: Color(0xFFFAF2A0), // Gold
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                              shadows: [
                                Shadow(
                                  color: Colors.black45,
                                  blurRadius: 10,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Log in to your ecosystem',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 30),

                          // ID Field
                          Container(
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                size.width * 0.075,
                              ),
                              border: Border.all(
                                color: const Color(0xFF673AB7),
                                width: 1.5,
                              ),
                              color: Colors.white.withOpacity(0.05),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: size.width * 0.05),
                              child: TextField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: role == 'student'
                                      ? "Student ID.."
                                      : "Teacher ID..",
                                  prefixIcon: Icon(
                                    role == 'student'
                                        ? Icons.school
                                        : Icons.psychology,
                                    color: const Color(0xFFFAF2A0),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                  border: InputBorder.none,
                                  filled: false,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          //email field
                          Container(
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                size.width * 0.075,
                              ),
                              border: Border.all(
                                color: const Color(0xFF673AB7),
                                width: 1.5,
                              ),
                              color: Colors.white.withOpacity(0.05),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: size.width * 0.05),
                              child: TextField(
                                style: const TextStyle(color: Colors.white),
                                decoration: InputDecoration(
                                  hintText: "Email..",
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: const Color(0xFFFAF2A0),
                                  ),
                                  hintStyle: const TextStyle(
                                    color: Colors.white70,
                                  ),
                                  border: InputBorder.none,
                                  filled: false,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // Password Field
                          Container(
                            height: size.height * 0.06,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                size.width * 0.075,
                              ),
                              border: Border.all(
                                color: const Color(0xFF673AB7),
                                width: 1.5,
                              ),
                              color: Colors.white.withOpacity(0.05),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: size.width * 0.05),
                              child: TextField(
                                obscureText: true,
                                style: const TextStyle(color: Colors.white),
                                decoration: const InputDecoration(
                                  hintText: "Password",
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Color(0xFFFAF2A0),
                                  ),
                                  hintStyle: TextStyle(color: Colors.white70),
                                  border: InputBorder.none,
                                  filled: false,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),

                          // Login Button
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                size.width * 0.075,
                              ),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF673AB7), Color(0xFF9C27B0)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: SizedBox(
                              height: 54,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                      size.width * 0.075,
                                    ),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    '/platform_home',
                                  );
                                },
                                child: const Text(
                                  "Login Now",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
