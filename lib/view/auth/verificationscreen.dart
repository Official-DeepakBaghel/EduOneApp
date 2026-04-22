import 'timer.dart';
import 'package:flutter/material.dart';

class VerificationScreen extends StatelessWidget {
  final int length;
  final List<TextEditingController> controllers;
  final void Function(String code)? onCompleted;
  VerificationScreen({super.key, this.length = 6, this.onCompleted})
    : controllers = List.generate(6, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: const Color(0xFF121212),
      appBar: AppBar(
        toolbarHeight: 125,
        backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF673AB7), Color(0xFF4A148C)],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
            ),
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              SizedBox(height: size.height * 0.010),
              Text(
                'Verify Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 0.065,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: size.height * 0.007),
              Text(
                'OTP send to uiwork@gmail.com',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: size.width * 0.035,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        leadingWidth: 360,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.031),
            const Text(
              'Enter Otp',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4.8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(length, (index) {
                  return SizedBox(
                    width: 50,
                    child: TextField(
                      controller: controllers[index],
                      textAlign: TextAlign.center,
                      maxLength: 1,
                      keyboardType: TextInputType.number,
                      onChanged: (value) {
                        if (value.isNotEmpty && index < length - 1) {
                          FocusScope.of(context).nextFocus();
                        }
                        if (index == length - 1 && value.isNotEmpty) {
                          final otp = controllers.map((c) => c.text).join();
                          if (onCompleted != null) {
                            onCompleted!(otp);
                          }
                        }
                      },
                      decoration: const InputDecoration(
                        counterText: "",
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.pink, width: 2),
                        ),
                      ),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 30),
            TimerWidget(),
            const SizedBox(height: 50),
            Container(
              width: double.infinity,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * 0.075),
                border: Border.all(color: const Color(0xFF9C27B0), width: 1.5),
                gradient: LinearGradient(
                  colors: [Color(0xFF673AB7), Color(0xFF9C27B0)],
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                ),
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(size.width * 0.075),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, '/dashboard');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: size.height * 0.012,
                    horizontal: size.width * 0.04,
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(color: Colors.white),
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
