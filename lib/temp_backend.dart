import 'package:shared_preferences/shared_preferences.dart';

class TempBackend {
  String email = "";
  String password = "";
  String name = "";

  // Function to save signup form data to SharedPreferences
  Future<bool> saveSignUpData(
      String email, String password, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if the email already exists
    String? storedEmail = prefs.getString('email');
    if (storedEmail != null && storedEmail == email) {
      // Email already exists
      return false; // Signup failed, email not unique
    }

    // Save user details to SharedPreferences if email is unique
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('name', name);
    return true; // Signup successful
  }

  // Function to validate login data from SharedPreferences
  Future<bool> validateLogin(String inputEmail, String inputPassword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve stored email and password from SharedPreferences
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    // Validate if the input matches the stored values
    if (storedEmail != null && storedPassword != null) {
      if (inputEmail == storedEmail && inputPassword == storedPassword) {
        return true; // Login successful
      } else {
        return false; // Login failed
      }
    } else {
      return false; // No user data found
    }
  }

  // Function to check if user is already logged in by verifying email and password
  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if both email and password are already saved in SharedPreferences
    String? storedEmail = prefs.getString('email');
    String? storedPassword = prefs.getString('password');

    return (storedEmail != null && storedPassword != null);
  }

  // Function to log out and clear the user data from SharedPreferences
  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove stored email, password, and name
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('name');
  }

  // Function to print saved data (for debugging purposes)
  void printSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve stored email, password, and name from SharedPreferences
    String? _email = prefs.getString('email');
    String? _password = prefs.getString('password');
    String? _name = prefs.getString('name');

    print("Saved Email: $_email");
    print("Saved Password: $_password");
    print("Saved Name: $_name");
  }
}
