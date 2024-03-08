import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  String _enteredEmail = '';
  String _enteredPassword = '';
  String _enteredFName = '';
  String _enteredLName = '';
  String _enteredUName = '';
  String _errorMessage = ''; // For displaying error messages

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    try {
      final response = await http.post(
        Uri.parse(
            'http://localhost:3000/users/register'), // Update with actual endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': _enteredEmail,
          'password': _enteredPassword,
          'firstName': _enteredFName,
          'lastName': _enteredLName,
          'username': _enteredUName,
        }),
      );
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 201) {
        Navigator.of(context)
            .pushReplacementNamed('/loginpage'); // Navigate to login page
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      } else {
        setState(() {
          _errorMessage = 'Failed to register. Please try again.';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An error occurred. Please try again later.';
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
                          decoration:
                              const InputDecoration(labelText: 'First Name'),
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your first name'
                              : null,
                          onSaved: (value) => _enteredFName = value!,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Last Name'),
                          validator: (value) => value!.isEmpty
                              ? 'Please enter your last name'
                              : null,
                          onSaved: (value) => _enteredLName = value!,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Username'),
                          validator: (value) =>
                              value!.isEmpty ? 'Please enter a username' : null,
                          onSaved: (value) => _enteredUName = value!,
                        ),
                        TextFormField(
                          decoration: const InputDecoration(labelText: 'Email'),
                          validator: (value) => !value!.contains('@')
                              ? 'Please enter a valid email'
                              : null,
                          onSaved: (value) => _enteredEmail = value!,
                        ),
                        TextFormField(
                          decoration:
                              const InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) => value!.length < 8
                              ? 'Password must be at least 8 characters long'
                              : null,
                          onSaved: (value) => _enteredPassword = value!,
                        ),
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(_errorMessage,
                                style:
                                    const TextStyle(color: Colors.redAccent)),
                          ),
                        ElevatedButton(
                          onPressed: _submit,
                          child: const Text('Create Account'),
                        ),
                        TextButton(
                          onPressed: () =>
                              Navigator.of(context).pushNamed('/loginpage'),
                          child: const Text('Already have an account? Login'),
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
