import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/note_controller.dart';
import '../../widgets/note_card.dart';
import '../../utils/app_colors.dart';
import '../note_details/note_details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NoteController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Notes Hub'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            TextField(
              onChanged: (val) => controller.searchNotes(val),
              decoration: const InputDecoration(
                hintText: 'Search for subject, notes...',
                prefixIcon: Icon(Icons.search),
              ),
            ),
            const SizedBox(height: 24),

            // Trending Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '🔥 Trending Notes',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: const Text('See All')),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 270,
              child: Obx(
                () => ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: controller.trendingNotes.length,
                  itemBuilder: (context, index) {
                    final note = controller.trendingNotes[index];
                    return Padding(
                      padding: const EdgeInsets.only(right: 16),
                      child: NoteCard(
                        note: note,
                        width: 250,
                        onTap: () =>
                            Get.to(() => NoteDetailsScreen(note: note)),
                      ),
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Categories
            Text(
              '📚 Categories',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 48,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _CategoryChip(
                    label: 'All',
                    isSelected: true,
                    onTap: () => controller.filterBySubject('All'),
                  ),
                  _CategoryChip(
                    label: 'Computer Science',
                    onTap: () => controller.filterBySubject('Computer Science'),
                  ),
                  _CategoryChip(
                    label: 'Mathematics',
                    onTap: () => controller.filterBySubject('Mathematics'),
                  ),
                  _CategoryChip(
                    label: 'Mechanical',
                    onTap: () =>
                        controller.filterBySubject('Mechanical Engineering'),
                  ),
                  _CategoryChip(
                    label: 'Economics',
                    onTap: () => controller.filterBySubject('Economics'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // All Notes Feed
            Text(
              '✨ Latest Notes',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: controller.filteredNotes.length,
                itemBuilder: (context, index) {
                  final note = controller.filteredNotes[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: NoteCard(
                      note: note,
                      onTap: () => Get.to(() => NoteDetailsScreen(note: note)),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _CategoryChip({
    required this.label,
    this.isSelected = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary : Colors.white,
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              if (!isSelected)
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
            ],
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.textPrimary,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
