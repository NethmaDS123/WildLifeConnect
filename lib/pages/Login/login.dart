import 'package:flutter/material.dart';
// import 'sign_up_page.dart'; // Import the sign-up page.

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});
  //test

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            // Email input field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            // Password input field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24.0),
            // Login button
            ElevatedButton(
              child: const Text('Login'),
              onPressed: () {
                // Handle login logic
              },
            ),
            // Navigate to sign up page
            TextButton(
              child: const Text("Don't have an account? Sign up"),
              onPressed: () {
                // Navigator.push(
                //   context,
                //   // MaterialPageRoute(builder: (context) => SignUpPage()),
                // );
              },
            ),
          ],
        ),
      ),
    );
  }
}
