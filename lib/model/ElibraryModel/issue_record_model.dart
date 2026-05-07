class IssueRecord {
  final String id;
  final String studentName;
  final String fatherName;
  final String course;
  final String semesterYear;
  final String rollNumber;
  final String bookId;
  final String bookName;
  final DateTime issueDate;
  final DateTime? returnDate;
  final bool isReturned;

  IssueRecord({
    required this.id,
    required this.studentName,
    required this.fatherName,
    required this.course,
    required this.semesterYear,
    required this.rollNumber,
    required this.bookId,
    required this.bookName,
    required this.issueDate,
    this.returnDate,
    this.isReturned = false,
  });

  IssueRecord copyWith({DateTime? returnDate, bool? isReturned}) {
    return IssueRecord(
      id: id,
      studentName: studentName,
      fatherName: fatherName, 
      course: course,
      semesterYear: semesterYear,
      rollNumber: rollNumber,
      bookId: bookId,
      bookName: bookName,
      issueDate: issueDate,
      returnDate: returnDate ?? this.returnDate,
      isReturned: isReturned ?? this.isReturned,
    );
  }
}
