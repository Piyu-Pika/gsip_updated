import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  List<Map<String, dynamic>> allQuestions = [];
  int currentQuestionIndex = 0;
  int? selectedOptionIndex;
  Map<String, dynamic> userResponses = {};

  @override
  void initState() {
    super.initState();
    _loadQuestionsData();
  }

  Future<void> _loadQuestionsData() async {
    final String response = await rootBundle.loadString('assets/data/questions_data.json');
    final data = await json.decode(response);

    setState(() {
      allQuestions = List<Map<String, dynamic>>.from(data['AllQuestions']);
    });
  }

  void _selectOption(int? optionIndex) {
    setState(() {
      selectedOptionIndex = optionIndex;
      userResponses['question${currentQuestionIndex + 1}'] = optionIndex;
    });
  }

  void _previousQuestion() {
    if (currentQuestionIndex > 0) {
      setState(() {
        currentQuestionIndex--;
        selectedOptionIndex = null;
      });
    }
  }

  void _nextQuestion() {
    if (currentQuestionIndex < allQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        selectedOptionIndex = null;
      });
    }
  }

  Future<void> _saveUserResponses() async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/user_responses.json');
    await file.writeAsString(json.encode(userResponses));
    print('User responses saved to ${file.path}');
  }

  @override
  Widget build(BuildContext context) {
    if (allQuestions.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Data Structures Quiz'),
        ),
        body: const Center(
          child: Text('No questions found.'),
        ),
      );
    }

    final currentQuestion = allQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data Structures Quiz'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question ${currentQuestion['id']}:',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(currentQuestion['Question']),
              const SizedBox(height: 16.0),
              ...List.generate(
                currentQuestion['Options'].length,
                (index) => RadioListTile(
                  value: index,
                  groupValue: selectedOptionIndex,
                  onChanged: _selectOption,
                  title: Text(currentQuestion['Options'][index]),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: currentQuestionIndex > 0 ? _previousQuestion : null,
              child: Card(
                color: currentQuestionIndex > 0 ? Colors.blue : Colors.grey,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Previous', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            GestureDetector(
              onTap: _saveUserResponses,
              child: const Card(
                color: Colors.blue,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Clear', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
            GestureDetector(
              onTap: currentQuestionIndex < allQuestions.length - 1 ? _nextQuestion : null,
              child: Card(
                color: currentQuestionIndex < allQuestions.length - 1 ? Colors.blue : Colors.grey,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Next', style: TextStyle(color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}