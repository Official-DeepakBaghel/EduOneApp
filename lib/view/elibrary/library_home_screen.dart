import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'library_controller.dart';
import 'add_book_screen.dart';
import 'issue_book_screen.dart';
import 'issue_records_screen.dart';
import '../../model/ElibraryModel/book_model.dart';

class LibraryHomeScreen extends StatelessWidget {
  final LibraryController controller = Get.put(LibraryController());

  LibraryHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'E-Library',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                controller.setRole(
                  controller.userRole.value == 'student'
                      ? 'teacher'
                      : 'student',
                );
              },
              icon: Icon(
                controller.userRole.value == 'student'
                    ? Icons.school
                    : Icons.admin_panel_settings,
                color: Colors.blueAccent,
              ),
              tooltip:
                  'Switch to ${controller.userRole.value == 'student' ? 'Teacher' : 'Student'}',
            ),
          ),
          Obx(
            () => controller.userRole.value == 'teacher'
                ? IconButton(
                    onPressed: () => Get.to(() => IssueRecordsScreen()),
                    icon: const Icon(
                      Icons.history_edu,
                      color: Colors.blueAccent,
                    ),
                    tooltip: 'Issue Records',
                  )
                : const SizedBox(),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: Obx(() {
              final books = controller.filteredBooks;
              if (books.isEmpty) {
                return const Center(child: Text('No books available.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return _buildBookCard(context, book);
                },
              );
            }),
          ),
        ],
      ),
      floatingActionButton: Obx(
        () => controller.userRole.value == 'teacher'
            ? FloatingActionButton.extended(
                onPressed: () => Get.to(() => const AddBookScreen()),
                icon: const Icon(Icons.add),
                label: const Text('Add Book'),
                backgroundColor: Colors.blueAccent,
              )
            : const SizedBox(),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: TextField(
        onChanged: (value) => controller.searchController.value = value,
        decoration: InputDecoration(
          hintText: 'Search for books, authors, ID...',
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.grey[100],
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildBookCard(BuildContext context, Book book) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
              ),
              child: Image.network(
                book.coverUrl,
                width: 100,
                height: 150,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  width: 100,
                  color: Colors.blueGrey[100],
                  child: const Icon(Icons.book, size: 40),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blue[50],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            book.bookNumber,
                            style: TextStyle(
                              color: Colors.blue[700],
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        if (controller.userRole.value == 'teacher')
                          _buildTeacherActions(book),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      book.title,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'By ${book.author}',
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              book.isAvailable ? 'AVAILABLE' : 'ISSUED',
                              style: TextStyle(
                                color: book.isAvailable
                                    ? Colors.green
                                    : Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 10,
                              ),
                            ),
                            Text(
                              book.category,
                              style: TextStyle(
                                color: Colors.grey[400],
                                fontSize: 10,
                              ),
                            ),
                          ],
                        ),
                        if (controller.userRole.value == 'student')
                          _buildStudentAction(book)
                        else if (book.isAvailable)
                          ElevatedButton(
                            onPressed: () =>
                                Get.to(() => IssueBookScreen(book: book)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blueAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                            ),
                            child: const Text(
                              'Issue',
                              style: TextStyle(fontSize: 12),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStudentAction(Book book) {
    return ElevatedButton(
      onPressed: () {
        Get.dialog(
          AlertDialog(
            title: const Text('How to Issue?'),
            content: const Text(
              'To issue this book, please visit the college library physically. Present your Roll Number and the Book ID to the librarian.',
            ),
            actions: [
              TextButton(
                onPressed: () => Get.back(),
                child: const Text('Got it'),
              ),
            ],
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.blueAccent,
        side: const BorderSide(color: Colors.blueAccent),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 12),
      ),
      child: const Text('How to Issue?', style: TextStyle(fontSize: 11)),
    );
  }

  Widget _buildTeacherActions(Book book) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          icon: const Icon(Icons.edit_note, size: 22, color: Colors.orange),
          onPressed: () => Get.to(() => AddBookScreen(book: book)),
        ),
        const SizedBox(width: 4),
        IconButton(
          constraints: const BoxConstraints(),
          padding: EdgeInsets.zero,
          icon: const Icon(
            Icons.delete_sweep,
            size: 22,
            color: Colors.redAccent,
          ),
          onPressed: () => _showDeleteDialog(book),
        ),
      ],
    );
  }

  void _showDeleteDialog(Book book) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Book'),
        content: Text(
          'Are you sure you want to delete "${book.title}" from the library?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              controller.deleteBook(book.id);
              Get.back();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
