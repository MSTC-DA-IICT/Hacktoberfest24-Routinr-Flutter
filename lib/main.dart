import 'package:flutter/material.dart';
import 'Signup_screen.dart';
import 'temp_backend.dart';
import 'profile_screen.dart';

void main() {
  runApp(const HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  const HabitTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    TempBackend tempbackend = TempBackend();

    // Use FutureBuilder to handle the async check for login status
    return MaterialApp(
      title: 'Routinr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: FutureBuilder<bool>(
        future: tempbackend.isUserLoggedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Display loading spinner while waiting for login status
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            // Handle error while loading login status
            return const Center(child: Text('Error loading data'));
          } else {
            // Navigate to HomePage if user is logged in, otherwise show SignUpScreen
            bool isLogin = snapshot.data ?? false;
            return isLogin ? const HomePage() : const SignUpScreen();
          }
        },
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HabitListPage(), // Home Page
    const Center(
        child: Text('Calendar Page',
            style: TextStyle(fontSize: 24))), // Calendar Page
    const ProfileScreen(), // Profile Page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: const Text(
          'Routinr: Habit Tracker',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon:
                const Icon(Icons.incomplete_circle_sharp, color: Colors.white),
            onPressed: () {
              // Add streak logic here
              TempBackend().logOut();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()),
                (Route<dynamic> route) => false,
              );
            },
          ),
        ],
      ),
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add new habit logic
        },
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text("Add Habit"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        selectedItemColor: Colors.green[700],
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}

class HabitListPage extends StatelessWidget {
  final List<String> habits = [
    'Exercise',
    'Read a book',
    'Meditate',
    'Drink water',
  ];

  HabitListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hi, John',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          const Text(
            "Today is 2024-10-01",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          const Text(
            "Your Habits:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 14),
          Column(
            children: habits.map((habit) {
              return Card(
                child: ListTile(
                  title: Text(habit),
                  trailing: const Icon(
                    Icons.arrow_drop_down_outlined,
                    size: 30,
                  ),
                  iconColor: Colors.green,
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
