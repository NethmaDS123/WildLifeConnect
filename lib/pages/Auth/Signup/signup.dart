import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

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
  bool _obscurePassword = true; // For toggling password visibility

  Future<void> _submit() async {
    final isValid = _formKey.currentState?.validate() ?? false;
    if (!isValid) {
      return;
    }
    _formKey.currentState?.save();

    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2:3000/users/register'), // Update with actual endpoint
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
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bgimglogin.jpg'), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Card(
                  margin: const EdgeInsets.all(5),
                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.5),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            style: const TextStyle(color: Colors.white), 
                            decoration: InputDecoration(
                              labelText: 'First Name',
                              labelStyle: const TextStyle(color: Colors.white), 
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.7),
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter your first name'
                                : null,
                            onSaved: (value) => _enteredFName = value!,
                          ),
                          const SizedBox(height: 10), // Add spacing between fields
                          TextFormField(
                            style: const TextStyle(color: Colors.white), 
                            decoration: InputDecoration(
                              labelText: 'Last Name',
                              labelStyle: const TextStyle(color: Colors.white), 
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.7),
                            ),
                            validator: (value) => value!.isEmpty
                                ? 'Please enter your last name'
                                : null,
                            onSaved: (value) => _enteredLName = value!,
                          ),
                          const SizedBox(height: 10), // Add spacing between fields
                          TextFormField(
                            style: const TextStyle(color: Colors.white), 
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: const TextStyle(color: Colors.white), 
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.7),
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Please enter a username' : null,
                            onSaved: (value) => _enteredUName = value!,
                          ),
                          const SizedBox(height: 10), // Add spacing between fields
                          TextFormField(
                            style: const TextStyle(color: Colors.white), 
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: const TextStyle(color: Colors.white), 
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.7),
                            ),
                            validator: (value) => !value!.contains('@')
                                ? 'Please enter a valid email'
                                : null,
                            onSaved: (value) => _enteredEmail = value!,
                          ),
                          const SizedBox(height: 10), // Add spacing between fields
                          TextFormField(
                            style: const TextStyle(color: Colors.white), 
                            decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.white), 
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: const BorderSide(color: Colors.white),
                              ),
                              filled: true,
                              fillColor: Colors.black.withOpacity(0.7),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  // Toggle password visibility
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                                child: Icon(
                                  _obscurePassword ? Icons.visibility : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            obscureText: _obscurePassword,
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
                          const SizedBox(height: 20), // Add spacing between the last TextFormField and the Create Account button
                          SizedBox(
                            width: double.infinity,
                            height: 55, // Set width to the maximum
                            child: ElevatedButton(
                              onPressed: _submit,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: Colors.black, backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: const Text('Create Account',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () =>
                                  Navigator.of(context).pushNamed('/loginpage'),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white, // Text color
                              ),
                              child: const Text('Already have an account? Login'),
                            ),
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
      ),
    );
  }
}