import 'package:shared_preferences/shared_preferences.dart';

class TempBackend {
  String email = "";
  String password = "";
  String name = "";

  // Function to save signup form data to SharedPreferences
  Future<void> saveSignUpData(
      String email, String password, String name) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Save user details to SharedPreferences
    await prefs.setString('email', email);
    await prefs.setString('password', password);
    await prefs.setString('name', name);
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

  // Function to check if user is already logged in
  Future<bool> isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Check if email and password are already saved in SharedPreferences
    String? storedEmail = prefs.getString('email');
    return storedEmail != null;
  }

  // Function to log out and clear the user data from SharedPreferences
  Future<void> logOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Remove stored email, password, and name
    await prefs.remove('email');
    await prefs.remove('password');
    await prefs.remove('name');
  }

  void printSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Retrieve stored email and password from SharedPreferences
    String? _email = prefs.getString('email');
    String? _password = prefs.getString('password');
    String? _name = prefs.getString('name');

    print(_email);
    print(_password);
    print(name);
  }
}
