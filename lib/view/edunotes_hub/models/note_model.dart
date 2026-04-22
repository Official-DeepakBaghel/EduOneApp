class Note {
  final String id;
  final String title;
  final String subject;
  final String course;
  final String description;
  final String previewUrl;
  int likes;
  int views;
  bool isBookmarked;
  bool isLiked;

  Note({
    required this.id,
    required this.title,
    required this.subject,
    required this.course,
    required this.description,
    required this.previewUrl,
    this.likes = 0,
    this.views = 0,
    this.isBookmarked = false,
    this.isLiked = false,
  });
}
