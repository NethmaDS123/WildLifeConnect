import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:wildlifeconnect/pages/Auth/secure_storage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final storage = FlutterSecureStorage();

  String _enteredEmail = '';
  String _enteredPassword = '';
  String _errorMessage = ''; // Variable to hold error messages

  void _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return; // If not valid, return and do not proceed
    }
    _formKey.currentState?.save();

    try {
      final response = await http.post(
        Uri.parse('http://localhost:3000/users/login'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': _enteredEmail,
          'password': _enteredPassword,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print(
            'Login Successful. Token: ${data['token']}'); // This line prints the token
        await SecureStorage.storeToken(data['token']); // Store token
        Navigator.of(context)
            .pushReplacementNamed('/navbar'); // Navigate to homepage
      } else {
        setState(() {
          _errorMessage = "Failed to log in. Please check your credentials.";
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage =
            "An error occurred during login. Please try again later.";
      });
    }
  }

  @override
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
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            border: OutlineInputBorder(),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          onSaved: (value) => _enteredEmail = value!,
                        ),
                        const SizedBox(height: 16.0),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null ||
                                value.isEmpty ||
                                value.length < 8) {
                              return 'Password must be at least 8 characters';
                            }
                            return null;
                          },
                          onSaved: (value) => _enteredPassword = value!,
                          obscureText: true,
                        ),
                        const SizedBox(height: 20.0),
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _errorMessage,
                              style: const TextStyle(color: Colors.redAccent),
                            ),
                          ),
                        ElevatedButton(
                          onPressed: _submit,
                          child: const Text(
                            'Login',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context)
                              .pushNamed('/signuppage'), // Adjust as needed
                          child: const Text("Don't have an account? Sign up"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
