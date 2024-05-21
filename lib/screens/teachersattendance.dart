import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Attendance Portal',
      home: AttendancePage(),
    );
  }
}

class Student {
  final String name;
  bool isPresent;

  Student({required this.name, this.isPresent = false});
}

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  List<Student> students = [
    Student(name: 'Piyush Bhardwaj'),
    Student(name: 'Shrishti Rawat'),
    Student(name: 'Manya Thapliyal'),
    Student(name: 'Aadhya Sharma'),
    Student(name: 'Kashish Gupta'),
    Student(name: 'Prem '),
    Student(name: 'Ali'),
    Student(name: 'Taylor swift'),
    Student(name: 'Thonos'),
    Student(name: 'Iron Man'),
  ];

  void _markAllPresent() {
    setState(() {
      for (var student in students) {
        student.isPresent = true;
      }
    });
  }

  void _markAllAbsent() {
    setState(() {
      for (var student in students) {
        student.isPresent = false;
      }
    });
  }

  void _navigateToSummary() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage(students: students),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Portal'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: students.length,
              itemBuilder: (context, index) {
                return StudentCard(student: students[index]);
              },
            ),
          ),
          BottomNavigationBar(
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.check_circle),
                label: 'Mark All Present',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cancel),
                label: 'Mark All Absent',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.navigate_next),
                label: 'Next',
              ),
            ],
            onTap: (index) {
              switch (index) {
                case 0:
                  _markAllPresent();
                  break;
                case 1:
                  _markAllAbsent();
                  break;
                case 2:
                  _navigateToSummary();
                  break;
              }
            },
          ),
        ],
      ),
    );
  }
}

class StudentCard extends StatefulWidget {
  final Student student;

  StudentCard({required this.student});

  @override
  _StudentCardState createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.student.isPresent ? Colors.green : Colors.red,
      child: ListTile(
        title: Text(widget.student.name),
        trailing: Switch(
          value: widget.student.isPresent,
          onChanged: (value) {
            setState(() {
              widget.student.isPresent = value;
            });
          },
        ),
      ),
    );
  }
}

class SummaryPage extends StatelessWidget {
  final List<Student> students;

  SummaryPage({required this.students});

  @override
  Widget build(BuildContext context) {
    List<Student> presentStudents = students.where((student) => student.isPresent).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendance Summary'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Present Students:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: presentStudents.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(presentStudents[index].name),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}