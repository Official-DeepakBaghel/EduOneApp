import 'package:animate_do/animate_do.dart';
import 'package:eduone/view/degree2dream/core/constants/app_colors.dart';
import 'package:eduone/model/Degree2DreamModel/mentor_model.dart';
import 'package:eduone/view/degree2dream/ui/screens/call_screen.dart';
import 'package:eduone/view/degree2dream/ui/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MentorDetailScreen extends StatelessWidget {
  final Mentor mentor;

  const MentorDetailScreen({super.key, required this.mentor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _buildHeroImage(),
          _buildBackArrow(),
          _buildContent(),
          _buildBottomAction(),
        ],
      ),
    );
  }

  Widget _buildHeroImage() {
    return Hero(
      tag: mentor.id,
      child: Image.network(
        mentor.imageUrl,
        height: 400,
        width: double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildBackArrow() {
    return Positioned(
      top: 50,
      left: 20,
      child: GestureDetector(
        onTap: () => Get.back(),
        child: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  Widget _buildContent() {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
          decoration: const BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FadeInDown(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(mentor.name, style: Get.textTheme.headlineMedium),
                        Text(
                          "${mentor.role} at ${mentor.company}",
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.surface,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(Iconsax.heart_copy, color: Colors.red),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              _buildStatsRow(),
              const SizedBox(height: 25),
              Text("About Mentor", style: Get.textTheme.titleLarge),
              const SizedBox(height: 10),
              Text(
                mentor.bio,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 25),
              Text("Specialization", style: Get.textTheme.titleLarge),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: mentor.skills
                    .map((skill) => _buildSkillChip(skill))
                    .toList(),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        );
      },
    );
  }

  Widget _buildStatsRow() {
    return FadeInUp(
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(Iconsax.star_copy, "${mentor.rating} Rating"),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: _buildStatItem(
              Iconsax.user_copy,
              "${mentor.reviews} Reviews",
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: _buildStatItem(Iconsax.clock_copy, "5 Yrs Exp")),
        ],
      ),
    );
  }

  Widget _buildStatItem(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.05)),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 8),
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(String skill) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: AppColors.primary.withOpacity(0.3)),
      ),
      child: Text(
        skill,
        style: const TextStyle(
          color: AppColors.primary,
          fontWeight: FontWeight.bold,
          fontSize: 12,
        ),
      ),
    );
  }

  Widget _buildBottomAction() {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: FadeInUp(
        child: Container(
          padding: const EdgeInsets.only(
            left: 25,
            right: 25,
            bottom: 40,
            top: 20,
          ),
          decoration: BoxDecoration(
            color: AppColors.background,
            border: Border(top: BorderSide(color: Colors.white10)),
          ),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Hourly Rate",
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    "\$${mentor.hourlyRate.toInt()}",
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 30),
              ElevatedButton(
                onPressed: () => Get.to(() => ChatScreen(mentor: mentor)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.surface,
                  padding: const EdgeInsets.all(18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  side: const BorderSide(color: Colors.white10),
                ),
                child: const Icon(
                  Iconsax.message_text_copy,
                  color: Colors.white,
                  size: 24,
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: ElevatedButton(
                  onPressed: () =>
                      Get.to(() => CallScreen(mentor: mentor, isVideo: true)),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shadowColor: AppColors.primary.withOpacity(0.5),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Iconsax.video_copy, size: 20),
                      SizedBox(width: 10),
                      Text(
                        "Start Session",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
