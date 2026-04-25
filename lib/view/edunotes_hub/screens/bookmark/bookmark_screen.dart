import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eduone/controller/EduNotesHubController/note_controller.dart';
import '../../utils/app_colors.dart';
import '../../widgets/note_card.dart';
import '../note_details/note_details_screen.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NoteController>();

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarks')),
      body: Obx(() {
        final bookmarks = controller.bookmarkedNotes;
        if (bookmarks.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.bookmark_border,
                  size: 80,
                  color: AppColors.textSecondary,
                ),
                SizedBox(height: 16),
                Text(
                  'No bookmarks yet',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Tap the bookmark icon on any note to save it here.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bookmarks.length,
          itemBuilder: (context, index) {
            final note = bookmarks[index];
            return Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: NoteCard(
                note: note,
                onTap: () => Get.to(() => NoteDetailsScreen(note: note)),
              ),
            );
          },
        );
      }),
    );
  }
}
