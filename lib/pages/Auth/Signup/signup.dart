import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firebase = FirebaseAuth.instance;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  var _enteredEmail = '';
  var _enteredPassword = '';

  void _submit() async {
    final isValid = _formKey.currentState!.validate();
    if (isValid) {
      _formKey.currentState!.save();
      print(_enteredEmail);
      print(_enteredPassword);
      try {
        final userCredentials = await _firebase.createUserWithEmailAndPassword(
            email: _enteredEmail, password: _enteredPassword);
        print(userCredentials);
      } on FirebaseAuthException catch (error) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(error.message ?? 'Authentication Failed'),
        ));
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Form(
                          key: _formKey,
                          child:
                              Column(mainAxisSize: MainAxisSize.min, children: [
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Create Account",
                                  style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left),
                            ),
                            const SizedBox(height: 16.0),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Email ID",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.left),
                            ),
                            // Email input field
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'example123@gmail.com',
                                border: OutlineInputBorder(),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              autocorrect: false,
                              textCapitalization: TextCapitalization.none,
                              validator: (value) {
                                if (value == null ||
                                    value.trim().isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please enter a valid email address';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredEmail = value!;
                              },
                            ),
                            const SizedBox(height: 16.0),
                            const Align(
                              alignment: Alignment.centerLeft,
                              child: Text("Password",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold)),
                            ),
                            // Password input field
                            TextFormField(
                              decoration: const InputDecoration(
                                labelText: 'Must have atleast 8 characters',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.trim().length < 8) {
                                  return 'Password mnust have atleast 8 characters';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _enteredPassword = value!;
                              },
                              obscureText: true,
                            ),
                            // Sign Up button
                            SizedBox(
                              width: double
                                  .infinity, // Replace with your desired width
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(16.0),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                child: const Text(
                                  'Create Account',
                                  style: TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold),
                                ),
                                onPressed: () {
                                  _submit();
                                },
                              ),
                            ),
                            // Navigate to sign up page
                            Align(
                                alignment: Alignment.centerRight,
                                child: TextButton(
                                  child: const Text(
                                    "Already have an account? Login",
                                  ),
                                  onPressed: () {
                                    //login page
                                  },
                                )),
                          ]))))
            ],
          ),
        ),
      ),
    );
  }
}
