import 'package:eduone/model/EduNotesHubModel/note_model.dart';

class Playlist {
  final String id;
  final String name;
  final List<Note> notes;

  Playlist({required this.id, required this.name, this.notes = const []});
}
