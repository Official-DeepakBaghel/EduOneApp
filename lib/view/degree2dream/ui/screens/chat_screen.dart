import 'package:animate_do/animate_do.dart';
import 'package:eduone/view/degree2dream/core/constants/app_colors.dart';
import 'package:eduone/model/Degree2DreamModel/mentor_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'dart:ui';

class ChatScreen extends StatelessWidget {
  final Mentor mentor;

  const ChatScreen({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.textPrimary, size: 20),
        ),
        titleSpacing: 0,
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(mentor.imageUrl),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                      color: AppColors.accent,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.background, width: 2),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  mentor.name,
                  style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Online",
                  style: TextStyle(color: AppColors.accent.withOpacity(0.8), fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.video_copy, color: AppColors.textPrimary, size: 22)),
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.call_copy, color: AppColors.textPrimary, size: 22)),
          const SizedBox(width: 8),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(color: Colors.white.withOpacity(0.05), height: 1),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
              children: [
                _buildDateSeparator("Today"),
                _buildMessage("Hi Alex! How can I help you today?", false, "10:30 AM"),
                _buildMessage("Hello Sarah! I'm looking for advice on Flutter development and career paths in Tech.", true, "10:31 AM"),
                _buildMessage("That's great! Flutter is a fantastic choice. Have you worked with any state management yet?", false, "10:32 AM"),
                _buildMessage("I've used GetX briefly but I want to learn BLoC as well.", true, "10:33 AM"),
                _buildMessage("Good plan. Let's schedule a session to dive deeper into architecture.", false, "10:34 AM"),
              ],
            ),
          ),
          _buildChatInput(),
        ],
      ),
    );
  }

  Widget _buildDateSeparator(String date) {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Text(
          date,
          style: TextStyle(color: AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildMessage(String text, bool isSender, String time) {
    return FadeInUp(
      duration: const Duration(milliseconds: 400),
      child: Align(
        alignment: isSender ? Alignment.centerRight : Alignment.centerLeft,
        child: Column(
          crossAxisAlignment: isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 4),
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                gradient: isSender ? AppColors.primaryGradient : null,
                color: isSender ? null : AppColors.surface,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(24),
                  topRight: const Radius.circular(24),
                  bottomLeft: isSender ? const Radius.circular(24) : Radius.zero,
                  bottomRight: isSender ? Radius.zero : const Radius.circular(24),
                ),
                boxShadow: [
                  if (isSender)
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                ],
              ),
              constraints: BoxConstraints(maxWidth: Get.width * 0.75),
              child: Text(
                text,
                style: const TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20, left: 4, right: 4),
              child: Text(
                time,
                style: TextStyle(color: AppColors.textMuted, fontSize: 10),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatInput() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40, top: 16),
      decoration: BoxDecoration(
        color: AppColors.background,
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.05))),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: Colors.white.withOpacity(0.05)),
            ),
            child: const Icon(Iconsax.add_copy, color: AppColors.textPrimary, size: 22),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              height: 55,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: const TextField(
                style: TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: "Type a message...",
                  hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 14),
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              gradient: AppColors.primaryGradient,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Icon(Iconsax.send_1_copy, color: Colors.white, size: 22),
          ),
        ],
      ),
    );
  }
}

