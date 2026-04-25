class StudentLoginModel {
  final String message;
  final String token;
  final StudentUser user;

  StudentLoginModel({
    required this.message,
    required this.token,
    required this.user,
  });

  factory StudentLoginModel.fromJson(Map<String, dynamic> json) {
    return StudentLoginModel(
      message: (json['message'] ?? '').toString(),
      token: (json['token'] ?? '').toString(),
      user: json['user'] != null
          ? StudentUser.fromJson(json['user'] as Map<String, dynamic>)
          : StudentUser(id: '', email: '', role: ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {'message': message, 'token': token, 'user': user.toJson()};
  }
}

class StudentUser {
  final String id;
  final String email;
  final String role;

  StudentUser({required this.id, required this.email, required this.role});

  factory StudentUser.fromJson(Map<String, dynamic> json) {
    return StudentUser(
      id: (json['id'] ?? json['_id'] ?? '').toString(),
      email: (json['email'] ?? '').toString(),
      role: (json['role'] ?? '').toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'email': email, 'role': role};
  }
}
