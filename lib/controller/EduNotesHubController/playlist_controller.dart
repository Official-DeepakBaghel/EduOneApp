import 'package:get/get.dart';
import 'package:eduone/model/EduNotesHubModel/note_model.dart';
import 'package:eduone/model/EduNotesHubModel/playlist_model.dart';
import 'package:eduone/view/edunotes_hub/utils/dummy_data.dart';

class PlaylistController extends GetxController {
  var playlists = <Playlist>[].obs;

  @override
  void onInit() {
    super.onInit();
    playlists.assignAll(DummyData.playlists);
  }

  void createPlaylist(String name) {
    String id = DateTime.now().millisecondsSinceEpoch.toString();
    playlists.add(Playlist(id: id, name: name, notes: []));
  }

  void addNoteToPlaylist(String playlistId, Note note) {
    int index = playlists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      if (!playlists[index].notes.any((n) => n.id == note.id)) {
        playlists[index].notes.add(note);
        playlists.refresh();
      }
    }
  }

  void removeNoteFromPlaylist(String playlistId, String noteId) {
    int index = playlists.indexWhere((p) => p.id == playlistId);
    if (index != -1) {
      playlists[index].notes.removeWhere((n) => n.id == noteId);
      playlists.refresh();
    }
  }
}
