import 'package:flutter/material.dart';
import 'package:habit_tracker/temp_backend.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TempBackend tempBackend = TempBackend();

  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';

  // Function to validate and save the form data
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Here you can perform actions like saving the data or navigating to the next screen
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Account Created for $_name')),
      );
      tempBackend.saveSignUpData(_email, _password, _name);
      tempBackend.printSavedData();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                        "Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: const Text(
                        "Create an account to get started",
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
                        "It's free",
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
            const SizedBox(height: 100),
            Container(
              padding: const EdgeInsets.all(15),
              height: 420,
              width: 300,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: const BorderRadius.all(
                  Radius.circular(10),
                ),
              ),
              child: Form(
                canPop: false,
                key: _formKey, // Add the form key for validation
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Name"),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _name = value!;
                      },
                    ),
                    const SizedBox(height: 15),
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
                            'Create My Account',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            //navitate to login page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Already Have an account..LogIn",
                            style: TextStyle(
                              color: Colors.black,
                            ),
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
      ),
    );
  }
}
