import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../models/note_model.dart';
import '../../controllers/note_controller.dart';
import '../../controllers/playlist_controller.dart';
import '../../utils/app_colors.dart';

class NoteDetailsScreen extends StatelessWidget {
  final Note note;

  const NoteDetailsScreen({super.key, required this.note});

  @override
  Widget build(BuildContext context) {
    final noteController = Get.find<NoteController>();
    final playlistController = Get.find<PlaylistController>();

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const CircleAvatar(
            backgroundColor: Colors.white,
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Preview Image Placeholder
            Hero(
              tag: note.id,
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 350,
                child: Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    Image.network(
                      note.previewUrl,
                      height: 350,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Text(
                        'PDF Preview Available',
                        style: TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          note.title,
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Obx(() {
                        // Observe the notes list to trigger rebuild when toggled
                        final currentNote = noteController.notes.firstWhere(
                          (n) => n.id == note.id,
                          orElse: () => note,
                        );
                        return IconButton(
                          icon: Icon(
                            currentNote.isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: AppColors.primary,
                          ),
                          onPressed: () => noteController.toggleBookmark(note),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '${note.subject} • ${note.course}',
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx(() {
                    final currentNote = noteController.notes.firstWhere(
                      (n) => n.id == note.id,
                      orElse: () => note,
                    );
                    return Row(
                      children: [
                        Expanded(
                          child: _StatTile(
                            icon: currentNote.isLiked
                                ? Icons.thumb_up
                                : Icons.thumb_up_alt_outlined,
                            label: '${currentNote.likes} Likes',
                            color: currentNote.isLiked
                                ? Colors.blue
                                : Colors.blueGrey,
                            onTap: () => noteController.toggleLike(currentNote),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: _StatTile(
                            icon: Icons.remove_red_eye_outlined,
                            label: '${currentNote.views} Views',
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    );
                  }),
                  const SizedBox(height: 30),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    note.description,
                    style: const TextStyle(
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {
                            Get.snackbar(
                              'Success',
                              'Note downloaded successfully!',
                            );
                          },
                          icon: const Icon(Icons.download_for_offline),
                          label: const Text('Download PDF'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      IconButton(
                        style: IconButton.styleFrom(
                          backgroundColor: AppColors.primary.withOpacity(0.1),
                          padding: const EdgeInsets.all(12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () => _showPlaylistDialog(
                          context,
                          playlistController,
                          note,
                        ),
                        icon: const Icon(
                          Icons.playlist_add,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPlaylistDialog(
    BuildContext context,
    PlaylistController controller,
    Note note,
  ) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Add to Playlist',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Obx(
              () => ListView.builder(
                shrinkWrap: true,
                itemCount: controller.playlists.length,
                itemBuilder: (context, index) {
                  final playlist = controller.playlists[index];
                  return ListTile(
                    leading: const Icon(
                      Icons.playlist_play,
                      color: AppColors.primary,
                    ),
                    title: Text(playlist.name),
                    onTap: () {
                      controller.addNoteToPlaylist(playlist.id, note);
                      Get.back();
                      Get.snackbar('Added', 'Note added to ${playlist.name}!');
                    },
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

class _StatTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback? onTap;

  const _StatTile({
    required this.icon,
    required this.label,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                label,
                style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
