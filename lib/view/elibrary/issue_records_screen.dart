import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'library_controller.dart';
import '../../model/ElibraryModel/issue_record_model.dart';

class IssueRecordsScreen extends StatelessWidget {
  final LibraryController controller = Get.find<LibraryController>();

  IssueRecordsScreen({super.key});

  String _formatDate(DateTime date) {
    return "${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: AppBar(
        title: const Text(
          'Issue & Return Records',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          _buildFilters(context),
          Expanded(
            child: Obx(() {
              final records = controller.filteredRecords;
              if (records.isEmpty) {
                return const Center(child: Text('No records found.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: records.length,
                itemBuilder: (context, index) {
                  return _buildRecordCard(context, records[index]);
                },
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(24),
          bottomRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          TextField(
            onChanged: (value) => controller.searchController.value = value,
            decoration: InputDecoration(
              hintText: 'Search student or book...',
              prefixIcon: const Icon(Icons.search),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All Courses', ''),
                _buildFilterChip('B.Tech', 'B.Tech'),
                _buildFilterChip('B.Sc', 'B.Sc'),
                _buildFilterChip('B.A', 'B.A'),
                _buildFilterChip('B.Com', 'B.Com'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: FilterChip(
          label: Text(label),
          selected: controller.filterCourse.value == value,
          onSelected: (selected) {
            controller.filterCourse.value = selected ? value : '';
          },
          selectedColor: Colors.blueAccent.withOpacity(0.2),
          checkmarkColor: Colors.blueAccent,
          labelStyle: TextStyle(
            color: controller.filterCourse.value == value
                ? Colors.blueAccent
                : Colors.black,
            fontWeight: controller.filterCourse.value == value
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildRecordCard(BuildContext context, IssueRecord record) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                record.studentName,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: record.isReturned
                      ? Colors.green[50]
                      : Colors.orange[50],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  record.isReturned ? 'Returned' : 'Issued',
                  style: TextStyle(
                    color: record.isReturned
                        ? Colors.green[700]
                        : Colors.orange[700],
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Book: ${record.bookName}',
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.blueAccent,
            ),
          ),
          const Divider(height: 24),
          Row(
            children: [
              _buildInfoItem(Icons.school, 'Course', record.course),
              _buildInfoItem(
                Icons.calendar_today,
                'Issued',
                _formatDate(record.issueDate),
              ),
              if (record.isReturned)
                _buildInfoItem(
                  Icons.check_circle,
                  'Returned',
                  _formatDate(record.returnDate!),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (!record.isReturned)
                ElevatedButton.icon(
                  onPressed: () => controller.returnBook(record.id),
                  icon: const Icon(Icons.keyboard_return, size: 16),
                  label: const Text('Mark Returned'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () => _showDeleteDialog(record),
                icon: const Icon(Icons.delete_outline, color: Colors.red),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String label, String value) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 12, color: Colors.grey),
              const SizedBox(width: 4),
              Text(
                label,
                style: const TextStyle(color: Colors.grey, fontSize: 10),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(IssueRecord record) {
    Get.dialog(
      AlertDialog(
        title: const Text('Delete Record'),
        content: const Text(
          'Are you sure you want to delete this issue entry?',
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              controller.deleteIssueRecord(record.id);
              Get.back();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
