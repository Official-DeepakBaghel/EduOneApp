import 'package:eduone/view/edunotes_hub/screens/bookmark/bookmark_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eduone/controller/EduNotesHubController/main_navbar_controller.dart';
import '../home/home_screen.dart';

import '../upload/upload_screen.dart';
import '../playlist/playlist_screen.dart';
import '../profile/profile_screen.dart';
import '../../utils/app_colors.dart';

class MainNavBar extends StatelessWidget {
  const MainNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainNavBarController>();

    final List<Widget> screens = [
      const HomeScreen(),
      const BookmarkScreen(),
      const UploadScreen(),
      const PlaylistScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: Obx(
        () => AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: screens[controller.selectedIndex.value],
        ),
      ),
      bottomNavigationBar: Obx(
        () => Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                spreadRadius: 2,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: NavigationBar(
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) => controller.changeIndex(index),
            height: 70,
            backgroundColor: Theme.of(context).cardTheme.color,
            indicatorColor: AppColors.primary.withOpacity(0.1),
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home_outlined),
                selectedIcon: Icon(Icons.home, color: AppColors.primary),
                label: 'Home',
              ),
              NavigationDestination(
                icon: Icon(Icons.bookmark_border),
                selectedIcon: Icon(Icons.bookmark, color: AppColors.primary),
                label: 'Bookmarks',
              ),
              NavigationDestination(
                icon: Icon(Icons.add_circle_outline, size: 30),
                selectedIcon: Icon(
                  Icons.add_circle,
                  size: 30,
                  color: AppColors.primary,
                ),
                label: 'Upload',
              ),
              NavigationDestination(
                icon: Icon(Icons.playlist_play),
                selectedIcon: Icon(
                  Icons.playlist_play,
                  color: AppColors.primary,
                ),
                label: 'Playlists',
              ),
              NavigationDestination(
                icon: Icon(Icons.person_outline),
                selectedIcon: Icon(Icons.person, color: AppColors.primary),
                label: 'Profile',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
