import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:gsip/screens/ai_tutor.dart';

class Resources extends StatefulWidget {
  const Resources({super.key});

  @override
  State<Resources> createState() => _ResourcesState();
}

class _ResourcesState extends State<Resources> {
  List<dynamic> noteData = [];

  @override
  void initState() {
    super.initState();
    loadNoteData();
  }

  Future<void> loadNoteData() async {
    String jsonString = await rootBundle.loadString('assets/data/notes.json');
    setState(() {
      noteData = json.decode(jsonString);
    });
  }

  Future<void> addNote(String title, String content) async {
    final newNote = {
      'id': noteData.length + 1,
      'title': title,
      'content': content,
    };

    setState(() {
      noteData.add(newNote);
    });

    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/notes.json');
    await file.writeAsString(json.encode(noteData));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: noteData.length,
        itemBuilder: (context, index) {
          return ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotesPage(
                    noteData: noteData[index],
                  ),
                ),
              );
            },
            child: Text(noteData[index]['Title']),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            Navigator.of(context).push(MaterialPageRoute(builder: ((context) => const AiTutor())));
          });
  },child: const Icon(Icons.shape_line_rounded),),
    );
  }

}

class NotesPage extends StatelessWidget {
  final Map<String, dynamic> noteData;

  const NotesPage({super.key, required this.noteData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(noteData['Title']),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(noteData['Content']),
      ),
    );
  }
}