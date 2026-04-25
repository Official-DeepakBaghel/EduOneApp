import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eduone/controller/EduNotesHubController/playlist_controller.dart';
import 'package:eduone/model/EduNotesHubModel/note_model.dart';
import 'package:eduone/model/EduNotesHubModel/playlist_model.dart';
import '../../utils/app_colors.dart';
import '../note_details/note_details_screen.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<PlaylistController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Playlists'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _showCreateDialog(context, controller),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.playlists.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.playlist_play, size: 80, color: AppColors.textSecondary),
                SizedBox(height: 16),
                Text('No playlists yet', style: TextStyle(color: AppColors.textSecondary, fontSize: 18)),
              ],
            ),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: controller.playlists.length,
          itemBuilder: (context, index) {
            final playlist = controller.playlists[index];
            return _PlaylistCard(playlist: playlist, controller: controller);
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateDialog(context, controller),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('New Playlist'),
      ),
    );
  }

  void _showCreateDialog(BuildContext context, PlaylistController controller) {
    final nameController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Create Playlist', style: TextStyle(fontWeight: FontWeight.bold)),
        content: TextField(
          controller: nameController,
          autofocus: true,
          decoration: const InputDecoration(hintText: 'Enter playlist name'),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (nameController.text.trim().isNotEmpty) {
                controller.createPlaylist(nameController.text.trim());
                Get.back();
                Get.snackbar('Created', 'Playlist "${nameController.text.trim()}" created!');
              }
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}

class _PlaylistCard extends StatelessWidget {
  final Playlist playlist;
  final PlaylistController controller;

  const _PlaylistCard({required this.playlist, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ExpansionTile(
        leading: Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Icon(Icons.playlist_play, color: AppColors.primary),
        ),
        title: Text(playlist.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('${playlist.notes.length} notes', style: const TextStyle(color: AppColors.textSecondary)),
        children: playlist.notes.isEmpty
            ? [
                const Padding(
                  padding: EdgeInsets.all(16),
                  child: Text('No notes in this playlist yet.', style: TextStyle(color: AppColors.textSecondary)),
                )
              ]
            : playlist.notes.map((note) => _NoteListTile(note: note, playlistId: playlist.id, controller: controller)).toList(),
      ),
    );
  }
}

class _NoteListTile extends StatelessWidget {
  final Note note;
  final String playlistId;
  final PlaylistController controller;

  const _NoteListTile({required this.note, required this.playlistId, required this.controller});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: Image.network(note.previewUrl, width: 48, height: 48, fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => Container(
                  width: 48, height: 48,
                  color: AppColors.primary.withOpacity(0.1),
                  child: const Icon(Icons.description, color: AppColors.primary),
                )),
      ),
      title: Text(note.title, maxLines: 1, overflow: TextOverflow.ellipsis),
      subtitle: Text(note.subject, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)),
      trailing: IconButton(
        icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
        onPressed: () {
          controller.removeNoteFromPlaylist(playlistId, note.id);
          Get.snackbar('Removed', '${note.title} removed from playlist.');
        },
      ),
      onTap: () => Get.to(() => NoteDetailsScreen(note: note)),
    );
  }
}
