import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  _FeedbackPageState createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  List<Map<String, dynamic>> feedback = [];
  final TextEditingController _feedbackController = TextEditingController();
  final TextEditingController _responseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadFeedbackData();
  }

  Future<void> _loadFeedbackData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/feedback.json');
    if (await file.exists()) {
      final jsonData = await file.readAsString();
      final data = json.decode(jsonData) as Map<String, dynamic>;
      setState(() {
        feedback = List<Map<String, dynamic>>.from(data['Feedback']);
      });
    }
  }

  Future<void> _saveFeedbackData() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/feedback.json');
    await file.writeAsString(json.encode({'Feedback': feedback}));
    print('Feedback data saved to ${file.path}');
  }

  void _postFeedback() {
    if (_feedbackController.text.isNotEmpty) {
      setState(() {
        feedback.add({
          'feedback': _feedbackController.text,
          'responses': [],
        });
        _feedbackController.clear();
      });
      _saveFeedbackData();
    }
  }

  void _postResponse(int index) {
    if (_responseController.text.isNotEmpty) {
      setState(() {
        feedback[index]['responses'].add(_responseController.text);
        _responseController.clear();
      });
      _saveFeedbackData();
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
              controller: _feedbackController,
              decoration: InputDecoration(
                hintText: 'Enter your feedback',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _postFeedback,
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: ListView.builder(
                itemCount: feedback.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            feedback[index]['feedback'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.0,
                            ),
                          ),
                          const SizedBox(height: 8.0),
                          ...List.generate(
                            feedback[index]['responses'].length,
                            (responseIndex) => Text(
                              feedback[index]['responses'][responseIndex],
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