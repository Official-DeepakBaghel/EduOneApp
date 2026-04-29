class Book {
  final String id;
  final String bookNumber;
  final String title;
  final String author;
  final String category;
  final String coverUrl;
  final bool isAvailable;
  final String description;

  Book({
    required this.id,
    required this.bookNumber,
    required this.title,
    required this.author,
    required this.category,
    required this.coverUrl,
    this.isAvailable = true,
    required this.description,
  });

  Book copyWith({
    String? bookNumber,
    String? title,
    String? author,
    String? category,
    String? coverUrl,
    bool? isAvailable,
    String? description,
  }) {
    return Book(
      id: id,
      bookNumber: bookNumber ?? this.bookNumber,
      title: title ?? this.title,
      author: author ?? this.author,
      category: category ?? this.category,
      coverUrl: coverUrl ?? this.coverUrl,
      isAvailable: isAvailable ?? this.isAvailable,
      description: description ?? this.description,
    );
  }
}
