import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Student {
  final String id;
  final String name;
  bool isPresent;

  Student({required this.id, required this.name, this.isPresent = false});
}

class TeachersAttendancePage extends StatefulWidget {
  const TeachersAttendancePage({super.key});

  @override
  _TeachersAttendancePageState createState() => _TeachersAttendancePageState();
}

class _TeachersAttendancePageState extends State<TeachersAttendancePage> {
  List<Student> students = [
    Student(id: '1', name: 'Piyush Bhardwaj'),
    Student(id: '2', name: 'Shrishti Rawat'),
    Student(id: '3', name: 'Manya Thapliyal'),
    Student(id: '4', name: 'Aadhya Sharma'),
    Student(id: '5', name: 'Kashish Gupta'),
    // Add more students as needed
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

  void _saveAttendance() async {
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    Map<String, dynamic> attendanceData = {};

    for (var student in students) {
      attendanceData[student.id] = {
        'date': today,
        'isPresent': student.isPresent,
        'studentId': student.id,
        'studentName': student.name,
      };
    }

    try {
      await FirebaseFirestore.instance
          .collection('attendance')
          .doc(today)
          .set(attendanceData);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Attendance saved successfully')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving attendance: $e')),
      );
    }
  }

  Future<void> _generatePdf() async {
    final doc = pw.Document();
    String today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    doc.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Attendance Report - $today',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(context: context, data: <List<String>>[
                <String>['Student Name', 'Status'],
                ...students.map((student) =>
                    [student.name, student.isPresent ? 'Present' : 'Absent'])
              ]),
            ],
          ); // Center
        }));

    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher\'s Attendance Portal'),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf),
            onPressed: _generatePdf,
          ),
        ],
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
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: _saveAttendance,
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                textStyle: const TextStyle(fontSize: 18),
              ),
              child: const Text('Save Attendance'),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.check_circle),
            label: 'Mark All Present',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.cancel),
            label: 'Mark All Absent',
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            _markAllPresent();
          } else if (index == 1) {
            _markAllAbsent();
          }
        },
      ),
    );
  }
}

class StudentCard extends StatefulWidget {
  final Student student;

  const StudentCard({super.key, required this.student});

  @override
  _StudentCardState createState() => _StudentCardState();
}

class _StudentCardState extends State<StudentCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: widget.student.isPresent ? Colors.green[100] : Colors.red[100],
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: ListTile(
        title: Text(
          widget.student.name,
          style: const TextStyle(fontSize: 16),
        ),
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
