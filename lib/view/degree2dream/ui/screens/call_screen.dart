import 'package:animate_do/animate_do.dart';
import 'package:eduone/view/degree2dream/core/constants/app_colors.dart';
import 'package:eduone/view/degree2dream/data/models/mentor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class CallScreen extends StatefulWidget {
  final Mentor mentor;
  final bool isVideo;

  const CallScreen({super.key, required this.mentor, this.isVideo = true});

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  bool isMuted = false;
  bool isCameraOff = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          _buildMainVideo(),
          _buildUserVideo(),
          _buildTopBar(),
          _buildControlBar(),
        ],
      ),
    );
  }

  Widget _buildMainVideo() {
    return Positioned.fill(
      child: FadeIn(
        duration: const Duration(seconds: 1),
        child: Image.network(
          widget.mentor.imageUrl,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildUserVideo() {
    return Positioned(
      top: 100,
      right: 20,
      child: FadeInRight(
        child: Container(
          width: 120,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white24, width: 2),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 10,
                offset: const Offset(4, 4),
              )
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.network(
              "https://i.pravatar.cc/150?u=user",
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Positioned(
      top: 50,
      left: 20,
      right: 20,
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 60,
        borderRadius: 20,
        blur: 10,
        alignment: Alignment.center,
        border: 1,
        linearGradient: AppColors.glassGradient,
        borderGradient: AppColors.primaryGradient,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            children: [
              const Icon(Icons.lock, color: Colors.white70, size: 16),
              const SizedBox(width: 10),
              const Text("End-to-end encrypted", style: TextStyle(color: Colors.white, fontSize: 12)),
              const Spacer(),
              const CircleAvatar(radius: 4, backgroundColor: Colors.red),
              const SizedBox(width: 8),
              const Text("12:45", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlBar() {
    return Positioned(
      bottom: 50,
      left: 30,
      right: 30,
      child: FadeInUp(
        child: GlassmorphicContainer(
          width: double.infinity,
          height: 90,
          borderRadius: 45,
          blur: 15,
          alignment: Alignment.center,
          border: 1,
          linearGradient: AppColors.glassGradient,
          borderGradient: AppColors.primaryGradient,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(
                isMuted ? Iconsax.microphone_slash_copy : Iconsax.microphone_2_copy,
                isMuted ? Colors.red : Colors.white,
                () => setState(() => isMuted = !isMuted),
              ),
              _buildControlButton(
                isCameraOff ? Iconsax.video_slash_copy : Iconsax.video_copy,
                isCameraOff ? Colors.red : Colors.white,
                () => setState(() => isCameraOff = !isCameraOff),
              ),
              _buildControlButton(
                Iconsax.message_copy,
                Colors.white,
                () {},
              ),
              GestureDetector(
                onTap: () => Get.back(),
                child: Container(
                  padding: const EdgeInsets.all(18),
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red,
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      )
                    ],
                  ),
                  child: const Icon(Iconsax.call_remove_copy, color: Colors.white, size: 28),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildControlButton(IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: color, size: 24),
      ),
    );
  }
}

