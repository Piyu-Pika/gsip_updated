import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class IdeaPage extends StatefulWidget {
  const IdeaPage({super.key});

  @override
  _IdeaPageState createState() => _IdeaPageState();
}

class _IdeaPageState extends State<IdeaPage> {
  List<Map<String, dynamic>> idea = [];
  final TextEditingController _ideaController = TextEditingController();
  final TextEditingController _responseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadIdeaData();
  }

  Future<void> _loadIdeaData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/idea.json');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final data = json.decode(jsonData) as Map<String, dynamic>;
      setState(() {
        idea = List<Map<String, dynamic>>.from(data['Idea']);
      });
    }
  }

  Future<void> _saveIdeaData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/idea.json');
    await file.writeAsString(json.encode({'Idea': idea}));
    print('Idea data saved to ${file.path}');
  }

  void _postIdea() {
    if (_ideaController.text.isNotEmpty) {
      setState(() {
        idea.add({
          'idea': _ideaController.text,
          'responses': [],
        });
        _ideaController.clear();
      });
      _saveIdeaData();
    }
  }

  void _postResponse(int index) {
    if (_responseController.text.isNotEmpty) {
      setState(() {
        idea[index]['responses'].add(_responseController.text);
        _responseController.clear();
      });
      _saveIdeaData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _ideaController,
              decoration: InputDecoration(
                hintText: 'Enter your idea',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _postIdea,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: idea.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            idea[index]['idea'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          ...List.generate(
                            idea[index]['responses'].length,
                            (responseIndex) => Text(
                              idea[index]['responses'][responseIndex],
                              style: const TextStyle(
                                fontSize: 14.0,
                              ),
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          TextField(
                            controller: _responseController,
                            decoration: InputDecoration(
                              hintText: 'Enter your response',
                              border: const OutlineInputBorder(),
                              suffixIcon: IconButton(
                                icon: const Icon(Icons.send),
                                onPressed: () => _postResponse(index),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}