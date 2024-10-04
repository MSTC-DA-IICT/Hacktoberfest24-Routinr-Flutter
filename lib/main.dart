import 'package:flutter/material.dart';
import 'package:habit_tracker/profile_screen.dart';

void main() {
  runApp(HabitTrackerApp());
}

class HabitTrackerApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Routinr',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HabitListPage(), // Home Page
    Center(
        child: Text('Calendar Page',
            style: TextStyle(fontSize: 24))), //Add widgets for Calendar Page
    Center(
        child: ProfileScreen()), //Add widget for profile page
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[700],
        title: Text('Routinr: Habit Tracker', style: TextStyle(
          color: Colors.white
        ),),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.incomplete_circle_sharp, color: Colors.white,),
                onPressed: () {
                  // Add Logic for streak
                },
              ),
            ],
          )
        ],
      ),
      body: _pages[_currentIndex],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add new habit logic
        },
        backgroundColor: Colors.green[700],
        foregroundColor: Colors.white,
        icon: Icon(Icons.add),
        label: Text("Add Habit"),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi, John',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 14),
          Text(
            "Today is 2024-10-01",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 14),
          Text(
            "Your Habits:",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 14),
          Column(
              children: habits.map((habit) {
            return Card(
              child: ListTile(
                title: Text(habit),
                trailing: Icon(
                  Icons.arrow_drop_down_outlined,
                  size: 30,
                ),
                iconColor: Colors.green,
              ),
            );
          }).toList()),
        ],
      ),
    );
  }
}
