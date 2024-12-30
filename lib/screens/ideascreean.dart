import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class IdeaPage extends StatefulWidget {
  const IdeaPage({super.key});

  @override
  _IdeaPageState createState() => _IdeaPageState();
}

class _IdeaPageState extends State<IdeaPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _ideaController = TextEditingController();
  final TextEditingController _responseController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  Future<void> _postIdea() async {
    if (_ideaController.text.isNotEmpty) {
      await _firestore.collection('ideas').add({
        'idea': _ideaController.text,
        'responses': [],
        'timestamp': FieldValue.serverTimestamp(),
      });
      _ideaController.clear();
    }
  }

  Future<void> _postResponse(String ideaId) async {
    if (_responseController.text.isNotEmpty) {
      await _firestore.collection('ideas').doc(ideaId).update({
        'responses': FieldValue.arrayUnion([_responseController.text]),
      });
      _responseController.clear();
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
              child: StreamBuilder<QuerySnapshot>(
                stream: _firestore
                    .collection('ideas')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  final ideas = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: ideas.length,
                    itemBuilder: (context, index) {
                      final idea = ideas[index].data() as Map<String, dynamic>;
                      final ideaId = ideas[index].id;

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                idea['idea'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0,
                                ),
                              ),
                              const SizedBox(height: 8.0),
                              ...List.generate(
                                (idea['responses'] as List).length,
                                (responseIndex) => Text(
                                  idea['responses'][responseIndex],
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
                                    onPressed: () => _postResponse(ideaId),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
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
