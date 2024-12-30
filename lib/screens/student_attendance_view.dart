import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StudentAttendancePage extends StatelessWidget {
  final String studentId;

  const StudentAttendancePage({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Attendance'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('attendance')
            .orderBy(FieldPath.documentId, descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          List<DocumentSnapshot> documents = snapshot.data!.docs;
          List<Map<String, dynamic>> attendanceRecords = [];

          for (var doc in documents) {
            Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
            if (data.containsKey(studentId)) {
              Map<String, dynamic> studentData =
                  data[studentId] as Map<String, dynamic>;
              studentData['date'] = doc.id; // Use document ID as date
              attendanceRecords.add(studentData);
            }
          }

          if (attendanceRecords.isEmpty) {
            return const Center(child: Text('No attendance records found.'));
          }

          return ListView.builder(
            itemCount: attendanceRecords.length,
            itemBuilder: (context, index) {
              var record = attendanceRecords[index];
              return Card(
                child: ListTile(
                  title: Text('Date: ${record['date']}'),
                  subtitle: Text(
                      'Status: ${record['isPresent'] ? 'Present' : 'Absent'}'),
                  leading: Icon(
                    record['isPresent'] ? Icons.check_circle : Icons.cancel,
                    color: record['isPresent'] ? Colors.green : Colors.red,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
