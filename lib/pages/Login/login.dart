import 'package:flutter/material.dart';
// import 'sign_up_page.dart'; // Import the sign-up page.

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const Text(
              "Hello Again!",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const Text(
              "Welcome Back to Wildlife Connect!",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
            const SizedBox(height: 30.0),
            const Text(
              "Login",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16.0),
            const Text(
              "Email ID",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // Email input field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'example123@gmail.com',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16.0),
            const Text(
              "Password",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            // Password input field
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Must have atleast 8 characters',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            TextButton(
              child: const Text("Forgot Password?"),
              onPressed: () {
                //reset password page
              },
            ),
            const SizedBox(height: 16.0),
            // Login button
            ElevatedButton(
              child: const Text(
                'Login',
                style: TextStyle(fontSize: 22),),
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
