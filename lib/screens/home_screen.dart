import 'package:flutter/material.dart';
import 'package:gsip/screens/ideascreean.dart';
import 'package:gsip/screens/studentsnotes.dart';
import 'package:gsip/screens/studentattendance.dart';
import 'package:gsip/screens/test_portal.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key,});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Student Portal'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.library_books),
                text: "Test",
              ),
              Tab(
                icon: Icon(Icons.play_lesson),
                text: "Resouces",
              ),
              Tab(
                icon: Icon(Icons.build),
                text: "Idea",),
              Tab(
                icon: Icon(Icons.tab),
                text: "attandance",),
            ],
          ),
        elevation: 0,),
        body: TabBarView(
          children: <Widget>[
            const Cards(),
            const Resources(),
            const IdeaPage(),
            AttendanceScreen()

          ],
        ),
      ),
    );
  }
}


class Cards extends StatefulWidget {
  const Cards({super.key});

  @override
  State<Cards> createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        ElevatedButton(onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) => TestScreen(),));
          });
        }, child: const Text("test1")),
        ElevatedButton(onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  TestScreen(),));
          });
        }, child: const Text("test2")),
        ElevatedButton(onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  TestScreen(),));
          });
        }, child: const Text("test3")),
        ElevatedButton(onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  TestScreen(),));
          });
        }, child: const Text("test4")),
        ElevatedButton(onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  TestScreen(),));
          });
        }, child: const Text("test5")),
        ElevatedButton(onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  TestScreen(),));
          });
        }, child: const Text("test6")),
        ElevatedButton(onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  TestScreen(),));
          });
        }, child: const Text("test7")),
        ElevatedButton(onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  TestScreen(),));
          });
        }, child: const Text("test8")),
        ElevatedButton(onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  TestScreen(),));
          });
        }, child: const Text("test9")),
        ElevatedButton(onPressed: (){
          setState(() {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>  TestScreen(),));
          });
        }, child: const Text("test10")),
      ],
      ),
    );
  }
}
