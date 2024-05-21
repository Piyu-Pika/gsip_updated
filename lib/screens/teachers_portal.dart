import 'package:flutter/material.dart';
import 'package:gsip/screens/feedback.dart';
import 'package:gsip/screens/teachersattendance.dart';
import 'package:gsip/screens/ideascreean.dart';
import 'package:gsip/screens/teacheresnotes.dart';

class TeachereScreen extends StatefulWidget {
  const TeachereScreen({super.key,});

  @override
  State<TeachereScreen> createState() => _TeachereScreenState();
}

class _TeachereScreenState extends State<TeachereScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Teachers Portal'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.library_books),
                text: "Feedback",
              ),
              Tab(
                icon: Icon(Icons.play_lesson),
                text: "Resouces",
              ),
              Tab(
                icon: Icon(Icons.build),
                text: "Ideas",),
              Tab(
                icon: Icon(Icons.tab),
                text: "Attendance",
              ),
            ],
          ),
        elevation: 0,),
        body: TabBarView(
          children: <Widget>[
            const FeedbackPage(),
            const Resources(),
            const IdeaPage(),
            AttendancePage()
          ],
        ),
      ),
    );
  }
}


// 