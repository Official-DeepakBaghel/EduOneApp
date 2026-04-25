class Teacherloginmodel {
  final String message;
  final String token;
  final TeacherUser user;

  Teacherloginmodel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory Teacherloginmodel.fromJson(Map<String, dynamic> json) {
    return Teacherloginmodel(
      message: (json['message'] ?? '').toString(),
      token: (json['token'] ?? '').toString(),
      user: json['user'] != null
          ? TeacherUser.fromJson(json['user'] as Map<String, dynamic>)
          : TeacherUser(id: '', email: '', role: ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'token': token, 'user': user.toJson()};
  }
}

class TeacherUser {
  final String id;
  final String email;
  final String role;

  TeacherUser({required this.id, required this.email, required this.role});

  factory TeacherUser.fromJson(Map<String, dynamic> json) {
    return TeacherUser(
      id: (json['id'] ?? json['_id'] ?? json['teacherId'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'role': role};
  }
}
