import 'package:eduone/model/LocalDB/local_db.dart';
import 'package:get/get.dart';
import '../../model/ElibraryModel/book_model.dart';
import '../../model/ElibraryModel/issue_record_model.dart';

class LibraryController extends GetxController {
  var books = <Book>[].obs;
  var issueRecords = <IssueRecord>[].obs;
  var isLoading = false.obs;
  var userRole = 'student'.obs; // Default role

  // Filters
  var searchController = "".obs;
  var filterCourse = "".obs;
  var filterSemester = "".obs;

  @override
  void onInit() {
    super.onInit();
    _loadRole();
    loadMockBooks();
  }

  Future<void> _loadRole() async {
    final savedRole = await LocalDB.getRole();
    if (savedRole != null) {
      userRole.value = savedRole;
    }
  }

  void setRole(String role) {
    userRole.value = role;
  }

  void loadMockBooks() {
    books.assignAll([
      Book(
        id: '1',
        bookNumber: 'CS001',
        title: 'Introduction to Algorithms',
        author: 'Cormen, Leiserson, Rivest, Stein',
        category: 'Computer Science',
        coverUrl: 'https://images.unsplash.com/photo-1532012197267-da84d127e765?auto=format&fit=crop&q=80&w=200',
        description: 'A comprehensive guide to modern algorithms.',
      ),
      Book(
        id: '2',
        bookNumber: 'PH001',
        title: 'Quantum Physics for Beginners',
        author: 'Carl Pratt',
        category: 'Science',
        coverUrl: 'https://images.unsplash.com/photo-1516414447565-b14be0adf13e?auto=format&fit=crop&q=80&w=200',
        description: 'Explore the fascinating world of quantum mechanics.',
      ),
      Book(
        id: '3',
        bookNumber: 'EC001',
        title: 'Macroeconomics: Principles and Policy',
        author: 'William J. Baumol',
        category: 'Economics',
        coverUrl: 'https://images.unsplash.com/photo-1454165833767-027ffea9e778?auto=format&fit=crop&q=80&w=200',
        description: 'Understanding global economic trends and policies.',
      ),
    ]);
  }

  void addBook(Book book) {
    books.add(book);
  }

  void updateBook(Book updatedBook) {
    int index = books.indexWhere((b) => b.id == updatedBook.id);
    if (index != -1) {
      books[index] = updatedBook;
    }
  }

  void deleteBook(String id) {
    books.removeWhere((b) => b.id == id);
  }

  void issueBook(IssueRecord record) {
    issueRecords.add(record);
    // Update book status
    int index = books.indexWhere((b) => b.id == record.bookId);
    if (index != -1) {
      books[index] = books[index].copyWith(isAvailable: false);
    }
  }

  void returnBook(String recordId) {
    int recordIndex = issueRecords.indexWhere((r) => r.id == recordId);
    if (recordIndex != -1) {
      final record = issueRecords[recordIndex];
      issueRecords[recordIndex] = record.copyWith(
        isReturned: true,
        returnDate: DateTime.now(),
      );

      // Update book status
      int bookIndex = books.indexWhere((b) => b.id == record.bookId);
      if (bookIndex != -1) {
        books[bookIndex] = books[bookIndex].copyWith(isAvailable: true);
      }
    }
  }

  void deleteIssueRecord(String recordId) {
    final record = issueRecords.firstWhere((r) => r.id == recordId);
    if (!record.isReturned) {
      // If it wasn't returned, make book available again
      int bookIndex = books.indexWhere((b) => b.id == record.bookId);
      if (bookIndex != -1) {
        books[bookIndex] = books[bookIndex].copyWith(isAvailable: true);
      }
    }
    issueRecords.removeWhere((r) => r.id == recordId);
  }

  List<Book> get filteredBooks {
    if (searchController.value.isEmpty) return books;
    return books.where((book) {
      return book.title.toLowerCase().contains(searchController.value.toLowerCase()) ||
          book.author.toLowerCase().contains(searchController.value.toLowerCase()) ||
          book.bookNumber.toLowerCase().contains(searchController.value.toLowerCase());
    }).toList();
  }

  List<IssueRecord> get filteredRecords {
    return issueRecords.where((record) {
      bool matchesSearch = record.studentName.toLowerCase().contains(searchController.value.toLowerCase()) ||
          record.bookName.toLowerCase().contains(searchController.value.toLowerCase());
      bool matchesCourse = filterCourse.value.isEmpty || record.course == filterCourse.value;
      bool matchesSemester = filterSemester.value.isEmpty || record.semesterYear == filterSemester.value;

      return matchesSearch && matchesCourse && matchesSemester;
    }).toList();
  }
}
