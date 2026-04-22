import 'package:get/get.dart';
import '../models/note_model.dart';
import '../utils/dummy_data.dart';

class NoteController extends GetxController {
  var notes = <Note>[].obs;
  var trendingNotes = <Note>[].obs;
  var filteredNotes = <Note>[].obs;
  var searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    notes.assignAll(DummyData.notes);
    trendingNotes.assignAll(notes.where((n) => n.views > 800).toList());
    filteredNotes.assignAll(notes);
  }

  void searchNotes(String query) {
    searchText.value = query;
    if (query.isEmpty) {
      filteredNotes.assignAll(notes);
    } else {
      filteredNotes.assignAll(notes.where((note) =>
          note.title.toLowerCase().contains(query.toLowerCase()) ||
          note.subject.toLowerCase().contains(query.toLowerCase())));
    }
  }

  void filterBySubject(String subject) {
    if (subject == 'All') {
      filteredNotes.assignAll(notes);
    } else {
      filteredNotes.assignAll(notes.where((note) => note.subject == subject));
    }
  }

  void toggleLike(Note note) {
    note.isLiked = !note.isLiked;
    if (note.isLiked) {
      note.likes++;
    } else {
      note.likes--;
    }
    notes.refresh();
  }

  void toggleBookmark(Note note) {
    note.isBookmarked = !note.isBookmarked;
    notes.refresh();
  }

  List<Note> get bookmarkedNotes => notes.where((n) => n.isBookmarked).toList();
}
