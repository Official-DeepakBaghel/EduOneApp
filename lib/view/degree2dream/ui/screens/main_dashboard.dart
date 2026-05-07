import 'package:animate_do/animate_do.dart';
import 'package:eduone/view/degree2dream/core/constants/app_colors.dart';
import 'package:eduone/view/degree2dream/core/controllers/navigation_controller.dart';
import 'package:eduone/view/degree2dream/ui/screens/explore_screen.dart';
import 'package:eduone/view/degree2dream/ui/screens/chat_list_screen.dart';
import 'package:eduone/view/degree2dream/ui/screens/home_screen.dart';
import 'package:eduone/view/degree2dream/ui/screens/mentor_home_screen.dart';
import 'package:eduone/view/degree2dream/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

class MainDashboard extends StatelessWidget {
  const MainDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(Degree2DreamNavigationController());

    final List<Widget> studentScreens = [
      const HomeScreen(),
      const ExploreScreen(),
      const ChatListScreen(),
      const ProfileScreen(),
    ];

    final List<Widget> mentorScreens = [
      const MentorHomeScreen(),
      const ChatListScreen(), // Mentors also have chats
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Obx(() {
            final role = controller.userRole.value;
            final screens = role == 'student' ? studentScreens : mentorScreens;
            // Ensure index is within bounds when switching roles
            final index = controller.currentIndex.value >= screens.length
                ? 0
                : controller.currentIndex.value;
            return screens[index];
          }),
          _buildBottomNav(controller),
        ],
      ),
    );
  }

  Widget _buildBottomNav(Degree2DreamNavigationController controller) {
    return Positioned(
      bottom: 20,
      left: 24,
      right: 24,
      child: FadeInUp(
        duration: const Duration(milliseconds: 1000),
        child: Container(
          height: 80,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.9),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white.withOpacity(0.1)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 30,
                offset: const Offset(0, 15),
              ),
            ],
          ),
          child: Obx(() {
            final role = controller.userRole.value;
            if (role == 'student') {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildNavItem(Iconsax.home_1_copy, "Home", 0, controller),
                  _buildNavItem(
                    Iconsax.discover_1_copy,
                    "Explore",
                    1,
                    controller,
                  ),
                  _buildNavItem(Iconsax.message_2_copy, "Chats", 2, controller),
                  _buildNavItem(Iconsax.user_copy, "Profile", 3, controller),
                ],
              );
            } else {
              // teacher role
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    Iconsax.home_1_copy,
                    "Dashboard",
                    0,
                    controller,
                  ),
                  _buildNavItem(Iconsax.message_2_copy, "Chats", 1, controller),
                  _buildNavItem(Iconsax.user_copy, "Profile", 2, controller),
                ],
              );
            }
          }),
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData icon,
    String label,
    int index,
    Degree2DreamNavigationController controller,
  ) {
    return Obx(() {
      final isActive = controller.currentIndex.value == index;
      return GestureDetector(
        onTap: () => controller.changeIndex(index),
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: isActive ? AppColors.primary : AppColors.textMuted,
              size: 26,
            ),
            if (isActive)
              Container(
                margin: const EdgeInsets.only(top: 4),
                width: 4,
                height: 4,
                decoration: const BoxDecoration(
                  color: AppColors.primary,
                  shape: BoxShape.circle,
                ),
              ),
          ],
        ),
      );
    });
  }
}
