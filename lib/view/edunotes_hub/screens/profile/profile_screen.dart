import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/note_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/note_card.dart';
import '../note_details/note_details_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final noteController = Get.find<NoteController>();
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // Sliver AppBar with gradient header
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [AppColors.primary, Color(0xFF9C27B0)],
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const CircleAvatar(
                      radius: 44,
                      backgroundColor: Colors.white24,
                      child: Icon(Icons.person, size: 50, color: Colors.white),
                    ),
                    const SizedBox(height: 12),
                    const Text('Deepak Sharma', style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 4),
                    const Text('B.Tech • Computer Science', style: TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(isDark ? Icons.light_mode : Icons.dark_mode, color: Colors.white),
                onPressed: () {
                  Get.changeThemeMode(isDark ? ThemeMode.light : ThemeMode.dark);
                },
              ),
            ],
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Stats row
                  Obx(() => Row(
                    children: [
                      _StatCard(label: 'Notes', value: '${noteController.notes.length}', icon: Icons.description),
                      const SizedBox(width: 12),
                      _StatCard(label: 'Bookmarks', value: '${noteController.bookmarkedNotes.length}', icon: Icons.bookmark),
                      const SizedBox(width: 12),
                      const _StatCard(label: 'Uploads', value: '3', icon: Icons.upload),
                    ],
                  )),
                  const SizedBox(height: 28),

                  // Profile info section
                  _SectionHeader('Account Info'),
                  const SizedBox(height: 12),
                  _InfoTile(icon: Icons.email_outlined, label: 'deepak@student.edu'),
                  _InfoTile(icon: Icons.school_outlined, label: 'University of Science & Tech'),
                  _InfoTile(icon: Icons.badge_outlined, label: 'Student ID: CS20240042'),
                  const SizedBox(height: 28),

                  // Uploaded notes
                  _SectionHeader('My Uploaded Notes'),
                  const SizedBox(height: 12),
                  Obx(() => ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: noteController.notes.take(3).length,
                    itemBuilder: (context, index) {
                      final note = noteController.notes[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: NoteCard(
                          note: note,
                          onTap: () => Get.to(() => NoteDetailsScreen(note: note)),
                        ),
                      );
                    },
                  )),
                  const SizedBox(height: 28),

                  // Settings / actions
                  _SectionHeader('Settings'),
                  const SizedBox(height: 12),
                  _SettingsTile(icon: Icons.notifications_outlined, label: 'Notifications', onTap: () {}),
                  _SettingsTile(icon: Icons.lock_outline, label: 'Change Password', onTap: () {}),
                  _SettingsTile(icon: Icons.language_outlined, label: 'Language', onTap: () {}),
                  _SettingsTile(
                    icon: Icons.logout,
                    label: 'Logout',
                    color: Colors.red,
                    onTap: () => Get.back(),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;

  const _StatCard({required this.label, required this.value, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Theme.of(context).cardTheme.color,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Column(
          children: [
            Icon(icon, color: AppColors.primary, size: 22),
            const SizedBox(height: 8),
            Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader(this.title);

  @override
  Widget build(BuildContext context) {
    return Text(title, style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold));
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  const _InfoTile({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: 12),
          Text(label, style: const TextStyle(fontSize: 15)),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color? color;

  const _SettingsTile({required this.icon, required this.label, required this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    final c = color ?? Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 1,
      child: ListTile(
        leading: Icon(icon, color: c),
        title: Text(label, style: TextStyle(color: c)),
        trailing: const Icon(Icons.chevron_right, size: 20),
        onTap: onTap,
      ),
    );
  }
}
