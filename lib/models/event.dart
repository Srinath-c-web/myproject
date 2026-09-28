class Event {
  final String id;
  final String title;
  final String category;
  final String description;
  final DateTime date;
  final String time;
  final String venue;
  final String organizer;
  final String imageUrl;
  final String eligibility;
  final DateTime registrationDeadline;
  final int registrationCount;
  final int maxParticipants;
  final String status;
  final List<String> tags;

  const Event({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.date,
    required this.time,
    required this.venue,
    required this.organizer,
    required this.imageUrl,
    required this.eligibility,
    required this.registrationDeadline,
    required this.registrationCount,
    required this.maxParticipants,
    required this.status,
    required this.tags,
  });

  Event copyWith({String? status, int? registrationCount}) => Event(
        id: id,
        title: title,
        category: category,
        description: description,
        date: date,
        time: time,
        venue: venue,
        organizer: organizer,
        imageUrl: imageUrl,
        eligibility: eligibility,
        registrationDeadline: registrationDeadline,
        registrationCount: registrationCount ?? this.registrationCount,
        maxParticipants: maxParticipants,
        status: status ?? this.status,
        tags: tags,
      );
}

final demoEvents = <Event>[
  Event(
    id: 'evt-001',
    title: 'Cyber Security CTF 2026',
    category: 'Technical',
    description: 'A capture-the-flag competition to test practical cyber security skills through puzzles, challenges and team rounds.',
    date: DateTime(2026, 9, 30),
    time: '10:00 AM - 5:00 PM',
    venue: 'Main Block, KSRCT',
    organizer: 'Cyber Club',
    imageUrl: '',
    eligibility: 'All Years',
    registrationDeadline: DateTime(2026, 9, 28),
    registrationCount: 96,
    maxParticipants: 200,
    status: 'approved',
    tags: ['Technical', 'CTF', 'Cyber Security'],
  ),
  Event(
    id: 'evt-002',
    title: 'AI Workshop',
    category: 'Workshop',
    description: 'Hands-on introduction to practical AI tools, prompting and responsible AI application development.',
    date: DateTime(2026, 9, 28),
    time: '9:30 AM - 1:00 PM',
    venue: 'Seminar Hall',
    organizer: 'AI Club',
    imageUrl: '',
    eligibility: 'All Years',
    registrationDeadline: DateTime(2026, 9, 27),
    registrationCount: 74,
    maxParticipants: 120,
    status: 'approved',
    tags: ['Workshop', 'AI/ML'],
  ),
  Event(
    id: 'evt-003',
    title: 'Hackathon 2026',
    category: 'Hackathon',
    description: 'Build a practical technology solution with a team and present your working prototype to the jury.',
    date: DateTime(2026, 10, 1),
    time: '9:00 AM - 9:00 PM',
    venue: 'Innovation Centre',
    organizer: 'Tech Club',
    imageUrl: '',
    eligibility: 'All Years',
    registrationDeadline: DateTime(2026, 9, 30),
    registrationCount: 132,
    maxParticipants: 250,
    status: 'approved',
    tags: ['Hackathon', 'Innovation'],
  ),
  Event(
    id: 'evt-004',
    title: 'Robotics Seminar',
    category: 'Technical',
    description: 'Explore robotics, embedded systems and autonomous machines with demonstrations.',
    date: DateTime(2026, 10, 5),
    time: '2:00 PM - 4:30 PM',
    venue: 'ECE Block',
    organizer: 'Robotics Club',
    imageUrl: '',
    eligibility: 'All Years',
    registrationDeadline: DateTime(2026, 10, 4),
    registrationCount: 42,
    maxParticipants: 100,
    status: 'approved',
    tags: ['Seminar', 'Robotics'],
  ),
  Event(
    id: 'evt-005',
    title: 'Cricket Tournament',
    category: 'Sports',
    description: 'Inter-department cricket tournament. Register your team before the deadline.',
    date: DateTime(2026, 10, 10),
    time: '8:00 AM - 5:00 PM',
    venue: 'Sports Ground',
    organizer: 'Sports Club',
    imageUrl: '',
    eligibility: 'All Years',
    registrationDeadline: DateTime(2026, 10, 7),
    registrationCount: 68,
    maxParticipants: 160,
    status: 'approved',
    tags: ['Sports', 'Cricket'],
  ),
];
