import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'library_controller.dart';
import '../../model/ElibraryModel/book_model.dart';
import '../../model/ElibraryModel/issue_record_model.dart';

class IssueBookScreen extends StatefulWidget {
  final Book book;
  const IssueBookScreen({super.key, required this.book});

  @override
  State<IssueBookScreen> createState() => _IssueBookScreenState();
}

class _IssueBookScreenState extends State<IssueBookScreen> {
  final _formKey = GlobalKey<FormState>();
  final _studentNameController = TextEditingController();
  final _fatherNameController = TextEditingController();
  final _courseController = TextEditingController();
  final _semesterController = TextEditingController();
  final _rollNumberController = TextEditingController();

  final LibraryController controller = Get.find<LibraryController>();

  @override
  void dispose() {
    _studentNameController.dispose();
    _fatherNameController.dispose();
    _courseController.dispose();
    _semesterController.dispose();
    _rollNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue Book'),
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
              _buildBookSummary(),
              const SizedBox(height: 32),
              const Text(
                'Student Details',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Student Name',
                _studentNameController,
                'Enter full name',
              ),
              const SizedBox(height: 16),
              _buildTextField(
                'Father\'s Name',
                _fatherNameController,
                'Enter father\'s name',
              ),
              const SizedBox(height: 16),
              _buildTextField('Course', _courseController, 'e.g. B.Tech'),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: _buildTextField(
                      'Semester / Year',
                      _semesterController,
                      'e.g. 4th Sem',
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _buildTextField(
                      'Roll Number',
                      _rollNumberController,
                      'e.g. 101',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _issueBook,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Save Record & Issue Book',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBookSummary() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.blue[100]!),
      ),
      child: Row(
        children: [
          const Icon(Icons.book, size: 40, color: Colors.blueAccent),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.book.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'ID: ${widget.book.bookNumber} | Author: ${widget.book.author}',
                  style: TextStyle(color: Colors.blue[700], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller,
    String hint,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 8),
        TextFormField(
          controller: controller,
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
          validator: (value) =>
              value == null || value.isEmpty ? 'Required' : null,
        ),
      ],
    );
  }

  void _issueBook() {
    if (_formKey.currentState!.validate()) {
      final record = IssueRecord(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        studentName: _studentNameController.text,
        fatherName: _fatherNameController.text,
        course: _courseController.text,
        semesterYear: _semesterController.text,
        rollNumber: _rollNumberController.text,
        bookId: widget.book.id,
        bookName: widget.book.title,
        issueDate: DateTime.now(),
      );

      controller.issueBook(record);
      Get.back();
      Get.snackbar('Success', 'Book issued to ${_studentNameController.text}');
    }
  }
}
