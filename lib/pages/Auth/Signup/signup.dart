import 'package:flutter/material.dart';
// import 'sign_up_page.dart'; // Import the sign-up page.

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  color: Color.fromARGB(255, 59, 255, 154),
                ),
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text("Create Account",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left),
                    const SizedBox(height: 16.0),
                    const Text("First Name",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left),
                    // First Name input field
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 16.0),
                    const Text("Last Name",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    // Last Name input field
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0),
                    const Text("Username",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    // Username input field
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: '',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0),
                    const Text("Password",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    // Password input field
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Must have atleast 8 characters',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 16.0),
                    const Text("Email Address",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    // Email Address input field
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'example123@gmail.com',
                        border: OutlineInputBorder(),
                      ),
                      obscureText: true,
                    ),
                    const SizedBox(height: 32.0),
                    // Create Account Button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Create My Account',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        // Handle account creation logic
                      },
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
