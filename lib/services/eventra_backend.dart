import '../models/event.dart';

/// Backend abstraction. Demo mode works without Firebase. When Firebase is enabled,
/// replace these methods with the Firestore/Auth implementations in this same class.
class EventraBackend {
  static final EventraBackend instance = EventraBackend._();
  EventraBackend._();

  final List<Event> _events = List<Event>.from(demoEvents);
  final Set<String> _registeredEventIds = {'evt-001', 'evt-002'};
  final Set<String> _bookmarkedEventIds = {'evt-003'};
  final Map<String, Map<String, String>> _users = {};
  String? _currentUserEmail;
  String _defaultUserName = 'Pranav Giri';

  bool hasAccount(String email) => _users.containsKey(_normalizeEmail(email));

  bool login(String email, String password) {
    final key = _normalizeEmail(email);
    final user = _users[key];
    if (user == null || user['password'] != password) return false;
    _currentUserEmail = key;
    return true;
  }

  void registerUser({
    required String fullName,
    required String username,
    required String email,
    required String password,
    required String department,
    required String college,
    required String year,
  }) {
    final key = _normalizeEmail(email);
    if (_users.containsKey(key)) {
      throw StateError('Account already exists for this email. Please login instead.');
    }

    _users[key] = {
      'fullName': fullName.trim(),
      'username': username.trim(),
      'email': key,
      'password': password,
      'department': department.trim(),
      'college': college.trim(),
      'year': year.trim(),
    };
    _currentUserEmail = key;
  }

  void updateProfile({
    String? fullName,
    String? username,
    String? department,
    String? college,
    String? year,
  }) {
    final user = currentUser;
    if (user == null) return;

    if (fullName != null) user['fullName'] = fullName.trim();
    if (username != null) user['username'] = username.trim();
    if (department != null) user['department'] = department.trim();
    if (college != null) user['college'] = college.trim();
    if (year != null) user['year'] = year.trim();
  }

  void logout() => _currentUserEmail = null;

  Map<String, String>? get currentUser => _currentUserEmail == null ? null : _users[_currentUserEmail!];

  String get userName {
    final user = currentUser;
    if (user == null) return _defaultUserName;
    return (user['username'] ?? user['fullName'] ?? _defaultUserName).trim().isEmpty
        ? _defaultUserName
        : (user['username'] ?? user['fullName'] ?? _defaultUserName);
  }

  set userName(String value) {
    final trimmed = value.trim();
    if (_currentUserEmail == null) return;
    currentUser!['username'] = trimmed.isEmpty ? _defaultUserName : trimmed;
  }

  String get department => currentUser?['department'] ?? '';
  set department(String value) => currentUser?['department'] = value.trim();
  String get year => currentUser?['year'] ?? '';
  set year(String value) => currentUser?['year'] = value.trim();
  String get college => currentUser?['college'] ?? '';
  set college(String value) => currentUser?['college'] = value.trim();

  String _normalizeEmail(String value) => value.trim().toLowerCase();

  List<Event> getEvents() => List.unmodifiable(_events);
  bool isRegistered(String eventId) => _registeredEventIds.contains(eventId);
  bool isBookmarked(String eventId) => _bookmarkedEventIds.contains(eventId);

  Future<void> registerForEvent(String eventId) async {
    _registeredEventIds.add(eventId);
  }

  Future<void> toggleBookmark(String eventId) async {
    if (!_bookmarkedEventIds.add(eventId)) _bookmarkedEventIds.remove(eventId);
  }

  Future<void> createEvent(Event event) async => _events.add(event);

  Future<void> approveEvent(String eventId) async {
    final i = _events.indexWhere((e) => e.id == eventId);
    if (i >= 0) _events[i] = _events[i].copyWith(status: 'approved');
  }
}
