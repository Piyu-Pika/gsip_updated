import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gsip_updated/screens/home_screen.dart';
import 'package:gsip_updated/screens/parents_portal.dart';
//import 'package:gsip_new/screens/parents_portal.dart';
import 'package:gsip_updated/screens/registration.dart';
import 'package:gsip_updated/screens/teachers_portal.dart';
// import 'package:gsip_new/screens/teachers_portal.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String? _userType;

  Future<void> _login() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Navigate based on user type
      if (_userType == 'Teacher') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const TeachereScreen()));
      } else if (_userType == 'Student') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const HomeScreen()));
      } else if (_userType == 'Parents') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const ParentsPortal()));
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'An error occurred')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Image.asset('assets/images/logo.png', width: 200, height: 150),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _userType,
              hint: const Text('Select User Type'),
              items: ['Teacher', 'Student', 'Parents'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _userType = newValue;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _login,
              child: const Text('Login'),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => RegistrationScreen()));
              },
              child: const Text('Don \'t have an account? Register'),
            ),
          ],
        ),
      ),
    );
  }
}
