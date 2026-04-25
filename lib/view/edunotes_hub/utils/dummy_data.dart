import 'package:eduone/model/EduNotesHubModel/note_model.dart';
import 'package:eduone/model/EduNotesHubModel/playlist_model.dart';

class DummyData {
  static final List<Note> notes = [
    Note(
      id: '1',
      title: 'Introduction to Data Structures',
      subject: 'Computer Science',
      course: 'B.Tech',
      description:
          'Foundational concepts of arrays, linked lists, stacks, and queues.',
      previewUrl:
          'https://images.unsplash.com/photo-1542831371-29b0f74f9713?auto=format&fit=crop&q=80',
      likes: 120,
      views: 1200,
      isLiked: true,
      isBookmarked: true,
    ),
    Note(
      id: '2',
      title: 'Database Management Systems',
      subject: 'Computer Science',
      course: 'B.Tech',
      description: 'In-depth notes on SQL, ER Diagrams, and Normalization.',
      previewUrl:
          'https://images.unsplash.com/photo-1518770660439-4636190af475?auto=format&fit=crop&q=80',
      likes: 85,
      views: 950,
    ),
    Note(
      id: '3',
      title: 'Engineering Mathematics II',
      subject: 'Mathematics',
      course: 'B.Tech',
      description:
          'Calculus, linear algebra, and differential equations notes.',
      previewUrl:
          'https://images.unsplash.com/photo-1509228468518-180dd482180c?auto=format&fit=crop&q=80',
      likes: 54,
      views: 450,
    ),
    Note(
      id: '4',
      title: 'Thermodynamics & Heat Transfer',
      subject: 'Mechanical Engineering',
      course: 'B.Tech',
      description:
          'Concepts, laws of thermodynamics, and heat conduction, convection.',
      previewUrl:
          'https://images.unsplash.com/photo-1510519133411-c990ee1c183b?auto=format&fit=crop&q=80',
      likes: 35,
      views: 310,
    ),
    Note(
      id: '5',
      title: 'Operating Systems - Process Scheduling',
      subject: 'Computer Science',
      course: 'B.Tech',
      description:
          'Deep dive into Round Robin, FCFS, and priority-based scheduling.',
      previewUrl:
          'https://images.unsplash.com/photo-1517694712202-14dd9538aa97?auto=format&fit=crop&q=80',
      likes: 110,
      views: 890,
    ),
    Note(
      id: '6',
      title: 'Microeconomics Principles',
      subject: 'Economics',
      course: 'B.A.',
      description:
          'Supply and demand curves, market equilibrium, and price elasticity.',
      previewUrl:
          'https://images.unsplash.com/photo-1518186285589-2f7649de83e0?auto=format&fit=crop&q=80',
      likes: 40,
      views: 280,
    ),
    Note(
      id: '7',
      title: 'Introduction to Psychology',
      subject: 'Psychology',
      course: 'B.A.',
      description:
          'Overview of behavioral studies, brain functions, and cognitive development.',
      previewUrl:
          'https://images.unsplash.com/photo-1551847670-7bbf1bbbc00a?auto=format&fit=crop&q=80',
      likes: 72,
      views: 560,
    ),
    Note(
      id: '8',
      title: 'Advanced Computer Networks',
      subject: 'Computer Science',
      course: 'M.Tech',
      description:
          'Detailed analysis of TCP/IP, OSI models, and network protocols.',
      previewUrl:
          'https://images.unsplash.com/photo-1544197150-b99a580bb7a8?auto=format&fit=crop&q=80',
      likes: 95,
      views: 1100,
    ),
    Note(
      id: '9',
      title: 'Civil Engineering Materials',
      subject: 'Civil Engineering',
      course: 'B.Tech',
      description:
          'Understanding cement, concrete, bricks, and their properties.',
      previewUrl:
          'https://images.unsplash.com/photo-1503387762-592dea58ef21?auto=format&fit=crop&q=80',
      likes: 28,
      views: 220,
    ),
    Note(
      id: '10',
      title: 'Artificial Intelligence & Ethics',
      subject: 'Computer Science',
      course: 'B.Tech',
      description: 'Discussion on societal impacts, ethics, and futuro of AI.',
      previewUrl:
          'https://images.unsplash.com/photo-1531297484001-80022131f5a1?auto=format&fit=crop&q=80',
      likes: 156,
      views: 2400,
      isLiked: true,
    ),
  ];

  static final List<Playlist> playlists = [
    Playlist(
      id: '1',
      name: 'CS Core Fundamentals',
      notes: [notes[0], notes[1], notes[4]],
    ),
    Playlist(
      id: '2',
      name: 'Mechanical Specialization',
      notes: [notes[3], notes[8]],
    ),
    Playlist(id: '3', name: 'Miscellaneous Prep', notes: [notes[5], notes[6]]),
  ];
}
