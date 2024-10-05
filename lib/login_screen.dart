import 'package:flutter/material.dart';
import 'package:habit_tracker/Signup_screen.dart';
import 'package:habit_tracker/main.dart';
import 'package:habit_tracker/temp_backend.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TempBackend tempBackend = TempBackend();
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  // Function to validate and save the form data
  void _submitForm() async {
    // Check if the form is valid
    if (_formKey.currentState!.validate()) {
      // Save the form state (this saves input data)
      _formKey.currentState!.save();

      // Perform login action - check credentials in SharedPreferences
      bool isValidUser = await tempBackend.validateLogin(_email, _password);

      if (isValidUser) {
        // Navigate to HomePage if login is successful
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const HomePage(),
          ),
        );

        // Show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Logged in as $_email')),
        );
      } else {
        // Show an error message for invalid credentials
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Invalid Username or Password')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          // Reusing the same header style as in the SignupScreen
          Container(
            height: 200,
            decoration: const BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(200),
                    bottomRight: Radius.circular(200))),
            child: Center(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 50),
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: const Text(
                      "Welcome back!",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 20, left: 20),
                    child: const Text(
                      "Login to continue",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(15),
            width: 300,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: const BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: Form(
              key: _formKey, // Add form key for validation
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Email"),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  const SizedBox(height: 15),
                  const Text("Password"),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _password = value!;
                    },
                  ),
                  const SizedBox(height: 30),
                  Center(
                      child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _submitForm,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.green, // Button background color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUpScreen(),
                              ));
                        },
                        child: const Text(
                          "Create an account",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
