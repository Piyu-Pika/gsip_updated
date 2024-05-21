import 'package:flutter/material.dart';
import 'package:gsip/screens/home_screen.dart';
import 'package:gsip/screens/parents_portal.dart';
import 'package:gsip/screens/teachers_portal.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Gemini.init(apiKey: 'YOUR_API_KEY');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoginDemo(),
    );
  }
}

class LoginDemo extends StatefulWidget {
  const LoginDemo({super.key});

  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  final _textcontroller = TextEditingController();
  final _passcontroller = TextEditingController();
  final String defemail = 'admin@example.com';
  final String defpassword = 'admin';
  String text1 = '';
  var value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Login Page"),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Center(
                  child: SizedBox(
                      width: 200,
                      height: 150,
                      child: Image.asset('assets/images/logo.png')),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _textcontroller,
                  decoration: const InputDecoration(
                      hintText: "Email", border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  obscureText: true,
                  controller: _passcontroller,
                  decoration: const InputDecoration(
                      hintText: "Password", border: OutlineInputBorder()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton(
                  items: const [
                    DropdownMenuItem(
                        value: "Teacher",
                        child: Text(
                          "Teacher",
                        )),
                    DropdownMenuItem(value: "Student", child: Text("Student")),
                    DropdownMenuItem(value: "Parents", child: Text("Parents"))
                  ],
                  onChanged: (value) {
                    setState(() {
                      this.value = value;
                    });
                  },
                  value: value,
                  hint: const Text("Select User Type"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: MaterialButton(
                  onPressed: () {
                    String emailpar = _textcontroller.text;
                    String pass = _passcontroller.text;
                    if (emailpar == defemail && pass == defpassword) {
                      if (value == "Teacher") {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const TeachereScreen()));
                        });
                      }
                      if (value == "Student") {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomeScreen()));
                        });
                      }
                      if (value == "Parents") {
                        setState(() {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const ParentsPortal()));
                        });
                      }
                    } else {
                      text1 = "";
                    }
                  },
                  color: const Color(0xFF007ACC),
                  child: const Text("Submit"),
                ),
              ),
              Text(text1)
            ],
          ),
        ));
  }
}
