import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:eduone/model/LocalDB/local_db.dart';

import 'package:eduone/view/collage_bunk_detector/bottumNavBar.dart' as bunk;
import 'package:eduone/view/degree2dream/ui/screens/main_dashboard.dart'
    as degree;
import 'package:eduone/view/edunotes_hub/screens/main_navbar/main_navbar.dart'
    as notes;
import 'package:eduone/controller/EduNotesHubController/note_controller.dart';
import 'package:eduone/controller/EduNotesHubController/playlist_controller.dart';
import 'package:eduone/controller/EduNotesHubController/main_navbar_controller.dart';

import 'view/auth/loginscreen.dart';
import 'view/edunotificationscreen.dart';

import 'view/auth/verificationscreen.dart';
import 'view/auth/splash_screen.dart';
import 'view/auth/role_selection_screen.dart';
import 'view/elibrary/library_home_screen.dart';

class EduOneApp extends StatelessWidget {
  const EduOneApp({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => NoteController());
    Get.lazyPut(() => PlaylistController());
    Get.lazyPut(() => MainNavBarController());

    return GetMaterialApp(
      title: 'EduOne Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF673AB7),
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF673AB7),
          brightness: Brightness.dark,
        ),
        textTheme: GoogleFonts.outfitTextTheme(),
      ),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/role_selection': (context) => const RoleSelectionScreen(),
        '/login': (context) => const Loginscreen(),
        '/verificationscreen': (context) => VerificationScreen(),
        '/platform_home': (context) => const EduOneHome(),
        '/bottomnavbarscreen': (context) => const bunk.Bottomnavbarscreen(),
        '/home': (context) => const notes.MainNavBar(),
        '/elibrary': (context) => LibraryHomeScreen(),
      },
    );
  }
}

class EduOneHome extends StatelessWidget {
  const EduOneHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar.large(
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'EduOne',
                style: GoogleFonts.outfit(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  shadows: [
                    const Shadow(
                      color: Colors.black45,
                      blurRadius: 10,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'assets/images/eduone_hero.png',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF673AB7), Color(0xFF9C27B0)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const EduNotificationScreen(),
                    ),
                  );
                },
              ),
              PopupMenuButton<String>(
                offset: const Offset(0, 48),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: const Color(0xFF1E1035),
                onSelected: (value) {
                  if (value == 'logout') {
                    LocalDB.deleteToken();
                    Get.offAllNamed('/role_selection');
                  } else if (value == 'profile') {
                    // TODO: Navigate to profile screen
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Profile coming soon!')),
                    );
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'profile',
                    child: Row(
                      children: const [
                        Icon(
                          Icons.person_outline,
                          color: Color(0xFFFAF2A0),
                          size: 20,
                        ),
                        SizedBox(width: 10),
                        Text('Profile', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                  ),
                  const PopupMenuDivider(),
                  PopupMenuItem(
                    value: 'logout',
                    child: Row(
                      children: const [
                        Icon(Icons.logout, color: Colors.redAccent, size: 20),
                        SizedBox(width: 10),
                        Text(
                          'Logout',
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      ],
                    ),
                  ),
                ],
                child: const CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white, size: 20),
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Your Ecosystem',
                    style: GoogleFonts.outfit(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Select an app to continue',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.85,
              ),
              delegate: SliverChildListDelegate([
                _buildAppTile(
                  context,
                  'Bunk Detector',
                  'Attendance Manager',
                  Icons.analytics_rounded,
                  const Color(0xFF2196F3),
                  () => Get.to(() => const bunk.Bottomnavbarscreen()),
                ),
                _buildAppTile(
                  context,
                  'Degree2Dream',
                  'Career Discovery',
                  Icons.rocket_launch_rounded,
                  const Color(0xFFE91E63),
                  () => Get.to(() => const degree.MainDashboard()),
                ),
                _buildAppTile(
                  context,
                  'Notes Hub',
                  'Study Resources',
                  Icons.menu_book_rounded,
                  const Color(0xFFFF9800),
                  () => Get.to(() => const notes.MainNavBar()),
                ),
                _buildAppTile(
                  context,
                  'eLibrary',
                  'Digital Archive',
                  Icons.local_library_rounded,
                  const Color(0xFF4CAF50),
                  () => Get.toNamed('/elibrary'),
                ),
              ]),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  color: Theme.of(
                    context,
                  ).colorScheme.primaryContainer.withOpacity(0.3),
                  border: Border.all(
                    color: Theme.of(
                      context,
                    ).colorScheme.primary.withOpacity(0.1),
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'One Account, Many Apps',
                            style: GoogleFonts.outfit(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Switch between apps instantly without re-logging.',
                            style: TextStyle(fontSize: 13),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.sync_rounded,
                      size: 32,
                      color: Color(0xFF673AB7),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 40)),
        ],
      ),
    );
  }

  Widget _buildAppTile(
    BuildContext context,
    String title,
    String subtitle,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: Theme.of(
              context,
            ).colorScheme.outlineVariant.withOpacity(0.5),
          ),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 32),
            ),
            const SizedBox(height: 16),
            Text(
              title,
              textAlign: TextAlign.center,
              style: GoogleFonts.outfit(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('eLibrary is coming soon!')));
  }
}
