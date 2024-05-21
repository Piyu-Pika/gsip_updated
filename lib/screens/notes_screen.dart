import 'dart:convert';
import 'package:flutter/material.dart';

class NotesPage extends StatefulWidget {
  final int id;

  NotesPage({required this.id});

  @override
  _NotesPageState createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  Map<String, dynamic>? _note;

  @override
  void initState() {
    super.initState();
    _loadNote();
  }

  Future<void> _loadNote() async {
    final jsonString = await DefaultAssetBundle.of(context)
        .loadString('assets/data/notes.json');
    final jsonData = json.decode(jsonString) as List<dynamic>;
    final note = jsonData.firstWhere((item) => item['id'] == widget.id,
        orElse: () => null);
    setState(() {
      _note = note;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Note'),
      ),
      body: _note != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _note!['title'],
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    _note!['content'],
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
