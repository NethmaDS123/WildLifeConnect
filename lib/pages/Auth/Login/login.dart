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
            const Text("Hello Again!",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const SizedBox(height: 10.0),
            const Text("Welcome Back to Wildlife Connect!",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center),
            const SizedBox(height: 50.0),
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
                    const Text("Login",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left),
                    const SizedBox(height: 16.0),
                    const Text("Email ID",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left),
                    // Email input field
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'example123@gmail.com',
                        border: OutlineInputBorder(),
                      ),
                      keyboardType: TextInputType.emailAddress,
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
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          child: const Text(
                            "Forgot Password?",
                          ),
                          onPressed: () {
                            //reset password page
                          },
                        )),
                    // Login button
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {
                        // Handle login logic
                      },
                    ),
                    // Navigate to sign up page
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        child: const Text(
                          "Don't have an account? Sign up",
                        ),
                        onPressed: () {
                          // Navigator.push(
                          //   context,
                          //   // MaterialPageRoute(builder: (context) => SignUpPage()),
                          // );
                        },
                      ),
                    ),
                  ],
                )),
            const SizedBox(height: 40.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  shape: CircleBorder(
                    side: BorderSide(color: Colors.black, width: 6.0),
                  )),
              child: const Text(
                'X',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                // Handle login logic
              },
            ),
          ],
        ),
      ),
    );
  }
}
