import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'library_controller.dart';
import '../../model/ElibraryModel/book_model.dart';

class AddBookScreen extends StatefulWidget {
  final Book? book; // If provided, we are editing
  const AddBookScreen({super.key, this.book});

  @override
  State<AddBookScreen> createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _bookNumberController;
  late TextEditingController _authorController;
  late TextEditingController _categoryController;
  late TextEditingController _descriptionController;
  late TextEditingController _coverUrlController;
  final LibraryController controller = Get.find<LibraryController>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book?.title);
    _bookNumberController = TextEditingController(text: widget.book?.bookNumber);
    _authorController = TextEditingController(text: widget.book?.author);
    _categoryController = TextEditingController(text: widget.book?.category);
    _descriptionController = TextEditingController(text: widget.book?.description);
    _coverUrlController = TextEditingController(text: widget.book?.coverUrl);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bookNumberController.dispose();
    _authorController.dispose();
    _categoryController.dispose();
    _descriptionController.dispose();
    _coverUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.book != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Book' : 'Add New Book'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField('Book Title', _titleController, 'e.g. Clean Code'),
              const SizedBox(height: 16),
              _buildTextField('Book ID / Number', _bookNumberController, 'e.g. CS101'),
              const SizedBox(height: 16),
              _buildTextField('Author', _authorController, 'e.g. Robert C. Martin'),
              const SizedBox(height: 16),
              _buildTextField('Category', _categoryController, 'e.g. Programming'),
              const SizedBox(height: 16),
              _buildTextField('Cover Image URL', _coverUrlController, 'https://...'),
              const SizedBox(height: 16),
              _buildTextField('Description', _descriptionController, 'Write about the book...', maxLines: 4),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _saveBook,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 0,
                  ),
                  child: Text(
                    isEditing ? 'Update Book' : 'Save Book',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, String hint, {int maxLines = 1}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
          maxLines: maxLines,
          decoration: InputDecoration(
            hintText: hint,
            filled: true,
            fillColor: Colors.grey[100],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.all(16),
          ),
          validator: (value) => value == null || value.isEmpty ? 'This field is required' : null,
        ),
      ],
    );
  }

  void _saveBook() {
    if (_formKey.currentState!.validate()) {
      final newBook = Book(
        id: widget.book?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        bookNumber: _bookNumberController.text,
        title: _titleController.text,
        author: _authorController.text,
        category: _categoryController.text,
        coverUrl: _coverUrlController.text,
        description: _descriptionController.text,
        isAvailable: widget.book?.isAvailable ?? true,
      );

      if (widget.book != null) {
        controller.updateBook(newBook);
        Get.snackbar('Success', 'Book updated successfully');
      } else {
        controller.addBook(newBook);
        Get.snackbar('Success', 'Book added to library');
      }
      Get.back();
    }
  }
}
