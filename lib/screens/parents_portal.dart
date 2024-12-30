import 'package:flutter/material.dart';
import 'package:gsip_updated/screens/feedback.dart';
import 'package:gsip_updated/screens/ideascreean.dart';
import 'package:gsip_updated/screens/notes_screen.dart';

class ParentsPortal extends StatefulWidget {
  const ParentsPortal({
    super.key,
  });

  @override
  State<ParentsPortal> createState() => _ParentsPortalState();
}

class _ParentsPortalState extends State<ParentsPortal> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Parents Portal'),
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                icon: Icon(Icons.play_lesson),
                text: "Feedback",
              ),
              Tab(
                icon: Icon(Icons.play_lesson),
                text: "Resouces",
              ),
              Tab(
                icon: Icon(Icons.build),
                text: "Idea",
              ),
            ],
          ),
          elevation: 0,
        ),
        body: const TabBarView(
          children: <Widget>[FeedbackPage(), Resources(), IdeaPage()],
        ),
      ),
    );
  }
}

class Resources extends StatefulWidget {
  const Resources({super.key});

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesPage(
                          id: 1,
                        ),
                      ));
                });
              },
              child: const Text("Notes1")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesPage(
                          id: 2,
                        ),
                      ));
                });
              },
              child: const Text("Notes2")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesPage(
                          id: 3,
                        ),
                      ));
                });
              },
              child: const Text("Notes3")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesPage(
                          id: 4,
                        ),
                      ));
                });
              },
              child: const Text("Notes4")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesPage(
                          id: 5,
                        ),
                      ));
                });
              },
              child: const Text("Notes5")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesPage(
                          id: 6,
                        ),
                      ));
                });
              },
              child: const Text("Notes6")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesPage(
                          id: 7,
                        ),
                      ));
                });
              },
              child: const Text("Notes7")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesPage(
                          id: 8,
                        ),
                      ));
                });
              },
              child: const Text("Notes8")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesPage(
                          id: 9,
                        ),
                      ));
                });
              },
              child: const Text("Notes9")),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NotesPage(
                          id: 10,
                        ),
                      ));
                });
              },
              child: const Text("Notes10")),
        ],
      ),
    );
  }
}
