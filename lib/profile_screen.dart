import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final String username = "Prx";
  final String email = "prx@example.com";
  final String profilePicUrl = "https://via.placeholder.com/150"; // Replace with actual profile pic URL
  final List<String> habits = ["Exercise", "Reading", "Meditation", "Healthy Eating"];
  final List<int> progress = [70, 50, 90, 10]; // Example progress percentages
  bool isLoggedIn = true; // Change this to false to simulate a logged-out state

  String getMotivation(int progress) {
    if (progress == 100) {
      return "🎉 Great job! You've mastered this habit! Keep it up!";
    } else if (progress >= 90) {
      return "🌟 Amazing! You're just a step away from perfection!";
    } else if (progress >= 80) {
      return "👏 Almost there! Just a little more effort!";
    } else if (progress >= 70) {
      return "👍 You're doing well! Consistency is key!";
    } else if (progress >= 50) {
      return "😊 Good progress! Keep pushing forward!";
    } else if (progress >= 30) {
      return "🤔 You're making strides! Consider dedicating a bit more time.";
    } else if (progress >= 10) {
      return "⚠️ You can do better! Let's focus on this habit.";
    } else {
      return "❗ Need to focus more! Every little effort counts, let's get started!";
    }
  }

  void _handleAuth() {
    setState(() {
      isLoggedIn = !isLoggedIn; // Toggle login status
    });

    if (isLoggedIn) {
      // Code to handle logging in (e.g., navigating to login page)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logged in!")),
      );
    } else {
      // Code to handle logging out (e.g., clearing user data)
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logged out!")),
      );
    }
  }

  void _editProfile() {
    // Code to handle profile editing (e.g., navigate to edit profile screen)
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Edit Profile clicked!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(profilePicUrl),
            ),
            const SizedBox(height: 20),
            Text(
              username,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              email,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Habits',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      title: Text(habits[index]),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${progress[index]}%',
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          LinearProgressIndicator(
                            value: progress[index] / 100,
                            backgroundColor: Colors.grey[200],
                            color: Colors.blue,
                          ),
                          const SizedBox(height: 5),
                          // Display motivational message
                          Text(
                            getMotivation(progress[index]),
                            style: const TextStyle(color: Colors.green),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  onPressed: _editProfile,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text('Edit Profile'),
                ),
                SizedBox(width: 15,),
                ElevatedButton(
                  onPressed: _handleAuth,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: isLoggedIn ? Colors.red : Colors.green,
                  ),
                  child: Text(isLoggedIn ? 'Logout' : 'Login'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
