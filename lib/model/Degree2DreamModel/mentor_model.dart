class Mentor {
  final String id;
  final String name;
  final String role;
  final String company;
  final String imageUrl;
  final double rating;
  final int reviews;
  final String bio;
  final List<String> skills;
  final double hourlyRate;

  Mentor({
    required this.id,
    required this.name,
    required this.role,
    required this.company,
    required this.imageUrl,
    required this.rating,
    required this.reviews,
    required this.bio,
    required this.skills,
    required this.hourlyRate,
  });

  static List<Mentor> get mockMentors => [
    Mentor(
      id: "1",
      name: "Sarah Johnson",
      role: "Senior Software Engineer",
      company: "Google",
      imageUrl: "https://i.pravatar.cc/150?u=sarah",
      rating: 4.9,
      reviews: 124,
      bio: "Expert in Flutter and Swift development with over 8 years of experience in mobile app architecture.",
      skills: ["Flutter", "Dart", "Swift", "Architecture"],
      hourlyRate: 50.0,
    ),
    Mentor(
      id: "2",
      name: "David Chen",
      role: "Product Designer",
      company: "Dropbox",
      imageUrl: "https://i.pravatar.cc/150?u=david",
      rating: 4.8,
      reviews: 89,
      bio: "Focusing on user-centric design and motion aesthetics. Helping designers level up their craft.",
      skills: ["UI/UX", "Figma", "Research", "Motion Design"],
      hourlyRate: 65.0,
    ),
    Mentor(
      id: "3",
      name: "Emily Rodriguez",
      role: "Data Scientist",
      company: "NVIDIA",
      imageUrl: "https://i.pravatar.cc/150?u=emily",
      rating: 4.7,
      reviews: 56,
      bio: "Passionate about Machine Learning and AI. I help students transition into Data Science roles.",
      skills: ["Python", "TensorFlow", "Pandas", "Math"],
      hourlyRate: 75.0,
    ),
    Mentor(
      id: "4",
      name: "Michael Smith",
      role: "Marketing Strategist",
      company: "Airbnb",
      imageUrl: "https://i.pravatar.cc/150?u=michael",
      rating: 4.9,
      reviews: 210,
      bio: "Growth expert with a track record of scaling consumer apps. Let's talk strategy.",
      skills: ["SEO", "AdWords", "Analytics", "Growth"],
      hourlyRate: 40.0,
    ),
  ];
}
