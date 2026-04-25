import 'dart:ui';
import 'package:eduone/controller/Auth/AuthController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController idController = TextEditingController();

  final Authcontroller _authController = Get.put(Authcontroller());

  bool _isLoading = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    idController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin(String role) async {
    if (idController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.trim().isEmpty) {
      Get.snackbar(
        'Missing Fields',
        'Please fill in all fields',
        backgroundColor: Colors.red.withValues(alpha: 0.8),
        colorText: Colors.white,
      );
      return;
    }

    setState(() => _isLoading = true);

    if (role == 'student') {
      await _authController.studentLogin(
        emailController.text.trim(),
        passwordController.text.trim(),
        idController.text.trim(),
      );
    } else {
      await _authController.teacherLogin(
        emailController.text.trim(),
        passwordController.text.trim(),
        idController.text.trim(),
      );
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {'role': 'student'};
    final String role = args['role'] ?? 'student';
    final Size size = MediaQuery.sizeOf(context);

    return Scaffold(
      backgroundColor: Colors.black,
      resizeToAvoidBottomInset: true,
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
              child: Container(color: Colors.black.withValues(alpha: 0.3)),
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
                        color: Colors.white.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.1),
                          width: 1.5,
                        ),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.white.withValues(alpha: 0.1),
                            Colors.white.withValues(alpha: 0.05),
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
                              color: Color(0xFFFAF2A0),
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
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 16,
                            ),
                          ),

                          const SizedBox(height: 30),

                          // ID Field
                          _buildTextField(
                            controller: idController,
                            hintText: role == 'student'
                                ? "Student ID.."
                                : "Teacher ID..",
                            icon: role == 'student'
                                ? Icons.school
                                : Icons.psychology,
                            size: size,
                          ),
                          const SizedBox(height: 20),

                          // Email Field
                          _buildTextField(
                            controller: emailController,
                            hintText: "Email..",
                            icon: Icons.email,
                            size: size,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20),

                          // Password Field
                          _buildTextField(
                            controller: passwordController,
                            hintText: "Password",
                            icon: Icons.lock,
                            size: size,
                            obscureText: true,
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
                                onPressed: _isLoading
                                    ? null
                                    : () => _handleLogin(role),
                                child: _isLoading
                                    ? const SizedBox(
                                        height: 24,
                                        width: 24,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2.5,
                                        ),
                                      )
                                    : const Text(
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

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required Size size,
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      height: size.height * 0.06,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(size.width * 0.075),
        border: Border.all(color: const Color(0xFF673AB7), width: 1.5),
        color: Colors.white.withValues(alpha: 0.05),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: size.width * 0.05),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: const TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(icon, color: const Color(0xFFFAF2A0)),
            hintStyle: const TextStyle(color: Colors.white70),
            border: InputBorder.none,
            filled: false,
          ),
        ),
      ),
    );
  }
}
