import 'package:flutter/material.dart';
import 'app_config.dart';
import 'models/event.dart';
import 'services/eventra_backend.dart';
import 'widgets/event_card.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const EventraApp());
}

class EventraApp extends StatelessWidget {
  const EventraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppConfig.appName,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF5B2BE0),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFFAFAFC),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFFF3F3F7),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashState();
}

class _SplashState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1300), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const OnboardingScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFF5B2BE0),
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(Icons.school_rounded, color: Colors.white, size: 48),
            ),
            const SizedBox(height: 20),
            const Text(
              'EVENTRA',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w900,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              AppConfig.tagline,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 30),
            const CircularProgressIndicator(strokeWidth: 2),
          ],
        ),
      ),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingState();
}

class _OnboardingState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int page = 0;

  final List<List<dynamic>> data = [
    [
      'All College Events in One Place',
      'Discover events, register and never miss an opportunity.',
      Icons.event_available_rounded,
    ],
    [
      'Personalized Discovery',
      'Choose your interests and see relevant college events.',
      Icons.auto_awesome_rounded,
    ],
    [
      'Participate & Grow',
      'Register, get reminders, attend and keep your certificates.',
      Icons.emoji_events_rounded,
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: data.length,
                onPageChanged: (value) => setState(() => page = value),
                itemBuilder: (_, index) {
                  final item = data[index];
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 210,
                          height: 210,
                          decoration: BoxDecoration(
                            color: const Color(0xFF5B2BE0).withValues(alpha: 0.1),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            item[2] as IconData,
                            size: 100,
                            color: const Color(0xFF5B2BE0),
                          ),
                        ),
                        const SizedBox(height: 45),
                        Text(
                          item[0] as String,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 14),
                        Text(
                          item[1] as String,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            height: 1.5,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                data.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  margin: const EdgeInsets.all(4),
                  height: 7,
                  width: index == page ? 24 : 7,
                  decoration: BoxDecoration(
                    color: index == page
                        ? const Color(0xFF5B2BE0)
                        : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(9),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 20, 24, 25),
              child: SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: () {
                    if (page < data.length - 1) {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeOut,
                      );
                    } else {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    }
                  },
                  child: Text(page < data.length - 1 ? 'Continue' : 'Get Started'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginState();
}

class _LoginState extends State<LoginScreen> {
  final fullNameController = TextEditingController();
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final departmentController = TextEditingController();
  final collegeController = TextEditingController();
  final yearController = TextEditingController();
  bool signup = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              const Center(
                child: Icon(
                  Icons.school_rounded,
                  size: 54,
                  color: Color(0xFF5B2BE0),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  signup ? 'Create Account' : 'Welcome Back',
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Center(
                child: Text(
                  signup ? 'Join Eventra and discover events' : 'Login to continue',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ),
              const SizedBox(height: 35),
              if (signup) ...[
                TextField(
                  controller: fullNameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.badge_outlined),
                    hintText: 'Full Name',
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.alternate_email),
                    hintText: 'Username',
                  ),
                ),
                const SizedBox(height: 14),
              ],
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.person_outline),
                  hintText: 'Email',
                ),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  prefixIcon: Icon(Icons.lock_outline),
                  hintText: 'Password',
                ),
              ),
              if (signup) ...[
                const SizedBox(height: 14),
                TextField(
                  controller: departmentController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.school_outlined),
                    hintText: 'Department',
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: collegeController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.account_balance_outlined),
                    hintText: 'College',
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: yearController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.calendar_today_outlined),
                    hintText: 'Study Year',
                  ),
                ),
              ],
              if (!signup)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => _snack(context, 'Please sign up first if you do not have an account.'),
                    child: const Text('Need an account? Sign Up'),
                  ),
                ),
              const SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: loading
                      ? null
                      : () {
                          setState(() => loading = true);

                          Future.delayed(const Duration(milliseconds: 500), () {
                            if (!mounted) return;
                            setState(() => loading = false);

                            if (signup) {
                              final email = emailController.text.trim();
                              final password = passwordController.text.trim();
                              final fullName = fullNameController.text.trim();
                              final username = usernameController.text.trim();
                              final department = departmentController.text.trim();
                              final college = collegeController.text.trim();
                              final year = yearController.text.trim();

                              if ([email, password, fullName, username, department, college, year].any((value) => value.isEmpty)) {
                                _snack(context, 'Please complete all profile details before continuing.');
                                return;
                              }

                              try {
                                EventraBackend.instance.registerUser(
                                  fullName: fullName,
                                  username: username,
                                  email: email,
                                  password: password,
                                  department: department,
                                  college: college,
                                  year: year,
                                );
                              } on StateError catch (_) {
                                _snack(context, 'An account with this email already exists. Please login instead.');
                                return;
                              }

                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (_) => const ProfileSetupScreen()),
                              );
                              return;
                            }

                            final email = emailController.text.trim();
                            final password = passwordController.text.trim();

                            if (email.isEmpty || password.isEmpty) {
                              _snack(context, 'Please enter your email and password.');
                              return;
                            }

                            final authenticated = EventraBackend.instance.login(email, password);
                            if (!authenticated) {
                              _snack(context, 'No account found. Please sign up first.');
                              return;
                            }

                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (_) => const MainShell()),
                            );
                          });
                        },
                  child: loading
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(signup ? 'Create Account' : 'Login'),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  const Expanded(child: Divider()),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'OR',
                      style: TextStyle(color: Colors.grey.shade600),
                    ),
                  ),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: OutlinedButton.icon(
                  onPressed: () => _snack(context, 'Connect Google Sign-In in Firebase setup'),
                  icon: const Icon(Icons.g_mobiledata, size: 28),
                  label: const Text('Continue with Google'),
                ),
              ),
              const SizedBox(height: 22),
              Center(
                child: TextButton(
                  onPressed: () => setState(() => signup = !signup),
                  child: Text(
                    signup ? 'Already have an account? Login' : 'Don’t have an account? Sign Up',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key});

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupState();
}

class _ProfileSetupState extends State<ProfileSetupScreen> {
  final fullNameController = TextEditingController(text: EventraBackend.instance.currentUser?['fullName'] ?? '');
  final usernameController = TextEditingController(text: EventraBackend.instance.currentUser?['username'] ?? '');
  final departmentController = TextEditingController(text: EventraBackend.instance.currentUser?['department'] ?? '');
  final collegeController = TextEditingController(text: EventraBackend.instance.currentUser?['college'] ?? '');
  final yearController = TextEditingController(text: EventraBackend.instance.currentUser?['year'] ?? '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Set up your profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
              ),
              const SizedBox(height: 8),
              Text(
                'Tell us a bit more about yourself so your profile is ready.',
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 24),
              TextField(
                controller: fullNameController,
                decoration: const InputDecoration(labelText: 'Full Name'),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: departmentController,
                decoration: const InputDecoration(labelText: 'Department'),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: collegeController,
                decoration: const InputDecoration(labelText: 'College'),
              ),
              const SizedBox(height: 14),
              TextField(
                controller: yearController,
                decoration: const InputDecoration(labelText: 'Study Year'),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: () {
                    final fullName = fullNameController.text.trim();
                    final username = usernameController.text.trim();
                    final department = departmentController.text.trim();
                    final college = collegeController.text.trim();
                    final year = yearController.text.trim();

                    if ([fullName, username, department, college, year].any((value) => value.isEmpty)) {
                      _snack(context, 'Please fill in all profile details.');
                      return;
                    }

                    EventraBackend.instance.updateProfile(
                      fullName: fullName,
                      username: username,
                      department: department,
                      college: college,
                      year: year,
                    );

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const InterestScreen()),
                    );
                  },
                  child: const Text('Continue'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void _snack(BuildContext context, String message) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(message)),
  );
}

class InterestScreen extends StatefulWidget {
  const InterestScreen({super.key});

  @override
  State<InterestScreen> createState() => _InterestState();
}

class _InterestState extends State<InterestScreen> {
  final interests = [
    'AI / ML',
    'Cyber Security',
    'Web Development',
    'Data Science',
    'Hackathons',
    'Workshops',
    'Cultural',
    'Sports',
    'Design',
    'Entrepreneurship',
  ];

  final selected = <String>{'AI / ML', 'Hackathons'};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What are you interested in?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'Select your interests to get personalized event recommendations.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                itemCount: interests.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisExtent: 58,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (_, index) {
                  final item = interests[index];
                  final isSelected = selected.contains(item);
                  return FilterChip(
                    selected: isSelected,
                    onSelected: (value) {
                      setState(() {
                        if (value) {
                          selected.add(item);
                        } else {
                          selected.remove(item);
                        }
                      });
                    },
                    label: Text(item),
                    avatar: Icon(
                      isSelected ? Icons.check_circle : Icons.circle_outlined,
                      size: 18,
                    ),
                  );
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const MainShell()),
                ),
                child: const Text('Continue'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MainShell extends StatefulWidget {
  const MainShell({super.key});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  int index = 0;

  late final List<Widget> pages = [
    HomeScreen(onExplore: () => setState(() => index = 1)),
    const ExploreScreen(),
    const MyEventsScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (value) => setState(() => index = value),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: 'Explore',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            label: 'My Events',
          ),
          NavigationDestination(
            icon: Icon(Icons.notifications_none),
            selectedIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  final VoidCallback onExplore;

  const HomeScreen({super.key, required this.onExplore});

  @override
  Widget build(BuildContext context) {
    final events = EventraBackend.instance.getEvents();
    final userName = EventraBackend.instance.userName;

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 16, 18, 100),
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Good Morning,', style: TextStyle(color: Colors.grey)),
                    Text(
                      '$userName 👋',
                      style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
                    ),
                  ],
                ),
              ),
              CircleAvatar(
                backgroundColor: Colors.deepPurple.shade100,
                child: const Icon(Icons.person, color: Color(0xFF5B2BE0)),
              ),
            ],
          ),
          const SizedBox(height: 18),
          TextField(
            onTap: onExplore,
            readOnly: true,
            decoration: const InputDecoration(
              prefixIcon: Icon(Icons.search),
              hintText: 'Search events...',
            ),
          ),
          const SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Recommended for You',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
              ),
              TextButton(onPressed: onExplore, child: const Text('See All')),
            ],
          ),
          EventCard(
            event: events.first,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EventDetailsScreen(event: events.first),
              ),
            ),
            bookmarked: EventraBackend.instance.isBookmarked(events.first.id),
            onBookmark: () => _snack(context, 'Bookmark updated'),
          ),
          const SizedBox(height: 18),
          const Text(
            'Categories',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              'Hackathon',
              'Workshop',
              'Technical',
              'Cultural',
              'Sports',
              'Club',
            ]
                .map(
                  (label) => ActionChip(
                    label: Text(label),
                    avatar: const Icon(Icons.auto_awesome, size: 17),
                    onPressed: onExplore,
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 25),
          const Text(
            'Upcoming Events',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 12),
          ...events.skip(1).take(3).map(
            (event) => EventCard(
              event: event,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EventDetailsScreen(event: event)),
              ),
              bookmarked: EventraBackend.instance.isBookmarked(event.id),
              onBookmark: () => _snack(context, 'Bookmark updated'),
            ),
          ),
        ],
      ),
    );
  }
}

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreState();
}

class _ExploreState extends State<ExploreScreen> {
  String query = '';
  String category = 'All';

  @override
  Widget build(BuildContext context) {
    var events = EventraBackend.instance.getEvents();

    if (category != 'All') {
      events = events.where((event) => event.category == category).toList();
    }

    if (query.isNotEmpty) {
      events = events
          .where(
            (event) =>
                '${event.title} ${event.description} ${event.tags.join(' ')}'
                    .toLowerCase()
                    .contains(query.toLowerCase()),
          )
          .toList();
    }

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 16, 18, 10),
            child: Row(
              children: [
                const Expanded(
                  child: Text(
                    'Explore Events',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                  ),
                ),
                IconButton(
                  onPressed: () => _snack(context, 'More filters coming in Firebase version'),
                  icon: const Icon(Icons.tune),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: TextField(
              onChanged: (value) => setState(() => query = value),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Search events...',
              ),
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 45,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 18),
              children: ['All', 'Technical', 'Workshop', 'Hackathon', 'Cultural', 'Sports']
                  .map(
                    (value) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(value),
                        selected: category == value,
                        onSelected: (_) => setState(() => category = value),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(18),
              children: events
                  .map(
                    (event) => EventCard(
                      event: event,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => EventDetailsScreen(event: event),
                        ),
                      ),
                      bookmarked: EventraBackend.instance.isBookmarked(event.id),
                      onBookmark: () => setState(() {}),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetailsScreen> {
  bool get isRegistered => EventraBackend.instance.isRegistered(widget.event.id);

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final isBookmarked = EventraBackend.instance.isBookmarked(event.id);

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              await EventraBackend.instance.toggleBookmark(event.id);
              setState(() {});
            },
            icon: Icon(
              isBookmarked ? Icons.favorite : Icons.favorite_border,
              color: isBookmarked ? Colors.red : null,
            ),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 4, 18, 110),
        children: [
          Container(
            height: 210,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [Color(0xFF221044), Color(0xFF7548E8)],
              ),
            ),
            child: const Center(
              child: Icon(Icons.code_rounded, size: 85, color: Colors.white),
            ),
          ),
          const SizedBox(height: 18),
          Text(
            event.title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 7,
            children: event.tags.map((tag) => Chip(label: Text(tag))).toList(),
          ),
          const SizedBox(height: 14),
          _info(Icons.calendar_month, '${event.date.day}/${event.date.month}/${event.date.year} • ${event.time}'),
          _info(Icons.location_on_outlined, event.venue),
          _info(Icons.groups_outlined, '${event.registrationCount}/${event.maxParticipants} registered'),
          const SizedBox(height: 18),
          const Text('About', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
          const SizedBox(height: 8),
          Text(
            event.description,
            style: TextStyle(color: Colors.grey.shade700, height: 1.5),
          ),
          const SizedBox(height: 20),
          const Text('Eligibility', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          Text(event.eligibility),
          const SizedBox(height: 14),
          const Text('Registration Deadline', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          Text(
            '${event.registrationDeadline.day}/${event.registrationDeadline.month}/${event.registrationDeadline.year}',
          ),
          const SizedBox(height: 14),
          const Text('Organized by', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
          Text(event.organizer),
        ],
      ),
      bottomSheet: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: const BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Color(0xFFE8E8EE))),
          ),
          child: SizedBox(
            width: double.infinity,
            height: 52,
            child: FilledButton(
              onPressed: isRegistered
                  ? null
                  : () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegistrationScreen(event: event),
                        ),
                      ),
              child: Text(isRegistered ? 'Already Registered' : 'Register Now'),
            ),
          ),
        ),
      ),
    );
  }
}

Widget _info(IconData icon, String text) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 10),
    child: Row(
      children: [
        Icon(icon, size: 20, color: const Color(0xFF5B2BE0)),
        const SizedBox(width: 10),
        Expanded(child: Text(text)),
      ],
    ),
  );
}

class RegistrationScreen extends StatefulWidget {
  final Event event;

  const RegistrationScreen({super.key, required this.event});

  @override
  State<RegistrationScreen> createState() => _RegistrationState();
}

class _RegistrationState extends State<RegistrationScreen> {
  final name = TextEditingController(text: EventraBackend.instance.userName);
  final rollNumber = TextEditingController(text: '22CS001');
  String year = 'Second Year';
  bool agree = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Registration')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Card(
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.event.title,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  Text('${widget.event.date.day}/${widget.event.date.month} • ${widget.event.venue}'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 18),
          TextField(
            controller: name,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: rollNumber,
            decoration: const InputDecoration(labelText: 'Roll Number'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: year,
            decoration: const InputDecoration(labelText: 'Year'),
            items: ['First Year', 'Second Year', 'Third Year', 'Final Year']
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => year = value ?? year),
          ),
          const SizedBox(height: 12),
          CheckboxListTile(
            value: agree,
            onChanged: (value) => setState(() => agree = value ?? false),
            contentPadding: EdgeInsets.zero,
            title: const Text('I agree to the terms and conditions'),
          ),
          const SizedBox(height: 18),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: agree
                  ? () async {
                      await EventraBackend.instance.registerForEvent(widget.event.id);
                      if (!mounted) return;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => RegistrationSuccessScreen(event: widget.event),
                        ),
                      );
                    }
                  : null,
              child: const Text('Submit Registration'),
            ),
          ),
        ],
      ),
    );
  }
}

class RegistrationSuccessScreen extends StatelessWidget {
  final Event event;

  const RegistrationSuccessScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 105,
                height: 105,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFF22B573),
                ),
                child: const Icon(Icons.check_rounded, color: Colors.white, size: 65),
              ),
              const SizedBox(height: 25),
              const Text(
                'Registration Successful!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
              ),
              const SizedBox(height: 10),
              Text(
                'You are registered for ${event.title}.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey.shade600),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => TicketScreen(event: event)),
                  ),
                  child: const Text('View Registration QR'),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () => Navigator.popUntil(context, (route) => route.isFirst),
                  child: const Text('Go to Home'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TicketScreen extends StatelessWidget {
  final Event event;

  const TicketScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Registration')),
      body: Center(
        child: Card(
          margin: const EdgeInsets.all(24),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.qr_code_2, size: 190),
                const SizedBox(height: 15),
                Text(
                  event.title,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 19),
                ),
                const SizedBox(height: 8),
                const Text('Registration ID: EVT-2026-000421'),
                Text(
                  '${event.date.day}/${event.date.month}/${event.date.year} • ${event.venue}',
                  style: TextStyle(color: Colors.grey.shade600),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyEventsScreen extends StatelessWidget {
  const MyEventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final events = EventraBackend.instance
        .getEvents()
        .where((event) => EventraBackend.instance.isRegistered(event.id))
        .toList();

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const Text(
            'My Events',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Text('Upcoming'),
                  selected: true,
                  onSelected: (_) {},
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: ChoiceChip(
                  label: const Text('Past'),
                  selected: false,
                  onSelected: (_) {},
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          ...events.map(
            (event) => EventCard(
              event: event,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EventDetailsScreen(event: event)),
              ),
              bookmarked: EventraBackend.instance.isBookmarked(event.id),
            ),
          ),
        ],
      ),
    );
  }
}

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      ['New Event', 'AI Workshop has been published.', '10 min ago', Icons.event_available],
      ['Registration Reminder', 'Registration for Cyber Security CTF closes tomorrow.', '3h ago', Icons.notifications_active],
      ['Event Reminder', 'Cyber Security CTF starts tomorrow at 10:00 AM.', '1d ago', Icons.alarm],
      ['Update', 'Venue for AI Workshop was changed.', '2d ago', Icons.info_outline],
      ['General Announcement', 'New events have been added.', '3d ago', Icons.campaign],
    ];

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          Row(
            children: [
              const Expanded(
                child: Text(
                  'Notifications',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
                ),
              ),
              TextButton(
                onPressed: () => _snack(context, 'All marked as read'),
                child: const Text('Mark all as read'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ...notifications.map(
            (item) => Card(
              elevation: 0,
              margin: const EdgeInsets.only(bottom: 10),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: const Color(0xFF5B2BE0).withValues(alpha: 0.1),
                  child: Icon(item[3] as IconData, color: const Color(0xFF5B2BE0)),
                ),
                title: Text(item[0] as String, style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: Text(item[1] as String),
                trailing: Text(item[2] as String, style: const TextStyle(fontSize: 10)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userName = EventraBackend.instance.userName;
    final department = EventraBackend.instance.department;
    final year = EventraBackend.instance.year;
    final profileMeta = [department, year].where((value) => value.isNotEmpty).join(' • ');

    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          const SizedBox(height: 15),
          const Center(
            child: CircleAvatar(
              radius: 48,
              backgroundColor: Color(0xFFE9E1FF),
              child: Icon(Icons.person, size: 55, color: Color(0xFF5B2BE0)),
            ),
          ),
          const SizedBox(height: 12),
          Center(
            child: Text(
              userName,
              style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w800),
            ),
          ),
          if (profileMeta.isNotEmpty)
            Center(
              child: Text(
                profileMeta,
                style: TextStyle(color: Colors.grey.shade600),
              ),
            )
          else
            Center(
              child: TextButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const ProfileUpdateScreen()),
                ),
                child: const Text('Update profile'),
              ),
            ),
          const SizedBox(height: 25),
          _tile(context, Icons.interests, 'My Interests', 'AI/ML, Cyber Security, Hackathons'),
          _tile(context, Icons.bookmark_border, 'My Bookmarks', 'Saved events'),
          _tile(context, Icons.event_note, 'My Events', 'Registrations and tickets'),
          _tile(context, Icons.workspace_premium_outlined, 'My Certificates', 'Participation certificates'),
          _tile(
            context,
            Icons.add_business,
            'Organizer Mode',
            'Create and manage events',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrganizerScreen()),
            ),
          ),
          _tile(
            context,
            Icons.admin_panel_settings_outlined,
            'Admin Dashboard',
            'Approvals and management',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AdminScreen()),
            ),
          ),
          _tile(
            context,
            Icons.settings_outlined,
            'Profile Update',
            'Update department and year',
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const ProfileUpdateScreen()),
            ),
          ),
          _tile(context, Icons.help_outline, 'Help & Support', 'FAQs and contact support'),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('Logout', style: TextStyle(color: Colors.red)),
            onTap: () => Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (_) => false,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileUpdateScreen extends StatefulWidget {
  const ProfileUpdateScreen({super.key});

  @override
  State<ProfileUpdateScreen> createState() => _ProfileUpdateScreenState();
}

class _ProfileUpdateScreenState extends State<ProfileUpdateScreen> {
  final departmentController = TextEditingController(text: EventraBackend.instance.department);
  final yearController = TextEditingController(text: EventraBackend.instance.year);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile Update')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Update your profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 8),
            Text(
              'Add your department and year so your profile is complete.',
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: departmentController,
              decoration: const InputDecoration(
                labelText: 'Department',
                hintText: 'e.g. CSE',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: yearController,
              decoration: const InputDecoration(
                labelText: 'Year',
                hintText: 'e.g. Second Year',
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton(
                onPressed: () {
                  EventraBackend.instance.department = departmentController.text;
                  EventraBackend.instance.year = yearController.text;
                  Navigator.pop(context);
                },
                child: const Text('Save Profile'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _tile(
  BuildContext context,
  IconData icon,
  String title,
  String subtitle, [
  VoidCallback? onTap,
]) {
  return ListTile(
    onTap: onTap,
    leading: Icon(icon, color: const Color(0xFF5B2BE0)),
    title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
    subtitle: Text(subtitle),
    trailing: const Icon(Icons.chevron_right),
  );
}

class OrganizerScreen extends StatefulWidget {
  const OrganizerScreen({super.key});

  @override
  State<OrganizerScreen> createState() => _OrganizerState();
}

class _OrganizerState extends State<OrganizerScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final venueController = TextEditingController();
  String category = 'Technical';
  DateTime? date;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Event')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Event Title',
              hintText: 'Enter event title',
            ),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            initialValue: category,
            decoration: const InputDecoration(labelText: 'Category'),
            items: ['Technical', 'Workshop', 'Hackathon', 'Cultural', 'Sports', 'Club']
                .map(
                  (value) => DropdownMenuItem(
                    value: value,
                    child: Text(value),
                  ),
                )
                .toList(),
            onChanged: (value) => setState(() => category = value ?? category),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descriptionController,
            maxLines: 4,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          const SizedBox(height: 12),
          ListTile(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
            tileColor: const Color(0xFFF3F3F7),
            leading: const Icon(Icons.calendar_month),
            title: Text(date == null ? 'Select date' : '${date!.day}/${date!.month}/${date!.year}'),
            onTap: () async {
              final selectedDate = await showDatePicker(
                context: context,
                firstDate: DateTime.now(),
                lastDate: DateTime(2030),
                initialDate: DateTime.now(),
              );
              if (selectedDate != null) {
                setState(() => date = selectedDate);
              }
            },
          ),
          const SizedBox(height: 12),
          TextField(
            controller: venueController,
            decoration: const InputDecoration(labelText: 'Venue'),
          ),
          const SizedBox(height: 12),
          const TextField(
            decoration: InputDecoration(labelText: 'Registration Deadline'),
          ),
          const SizedBox(height: 25),
          SizedBox(
            height: 52,
            child: FilledButton(
              onPressed: () {
                _snack(context, 'Event submitted for admin approval');
                Navigator.pop(context);
              },
              child: const Text('Publish Event'),
            ),
          ),
        ],
      ),
    );
  }
}

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Dashboard')),
      body: ListView(
        padding: const EdgeInsets.all(18),
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.7,
            children: [
              _stat('25', 'Total Events', Colors.blue),
              _stat('320', 'Total Registrations', Colors.green),
              _stat('12', 'Pending Approvals', Colors.orange),
              _stat('8', 'Active Clubs', Colors.purple),
            ],
          ),
          const SizedBox(height: 25),
          const Text(
            'Recent Event Requests',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 10),
          ...['Robotics Workshop', 'Cultural Fest 2026', 'Tech Talk'].map(
            (title) => Card(
              elevation: 0,
              child: ListTile(
                title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
                subtitle: const Text('Submitted by organizer'),
                trailing: Wrap(
                  children: [
                    IconButton(
                      onPressed: () => _snack(context, 'Approved'),
                      icon: const Icon(Icons.check_circle, color: Colors.green),
                    ),
                    IconButton(
                      onPressed: () => _snack(context, 'Rejected'),
                      icon: const Icon(Icons.cancel, color: Colors.red),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

Widget _stat(String value, String label, Color color) {
  return Container(
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.08),
      borderRadius: BorderRadius.circular(18),
    ),
    padding: const EdgeInsets.all(14),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          value,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900, color: color),
        ),
        Text(label, style: TextStyle(color: color)),
      ],
    ),
  );
}
