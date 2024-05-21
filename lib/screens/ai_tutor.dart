import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';


class AiTutor extends StatefulWidget{
  const AiTutor({super.key});

  @override
  State<AiTutor> createState() => _AiTutorState();
}

class _AiTutorState extends State<AiTutor> {
  final _text1controller=TextEditingController();
  late  String prompt='';
  late  String modPrompt='';
  final gemini = Gemini.instance;
  late  String result='Write Something';

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("AI Tutor"),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Expanded(child: Center(
                    child:SingleChildScrollView(child: Text(result,)),),
                ),
                TextField(
              controller: _text1controller,
              decoration: InputDecoration(
                hintText: 'what you want to ask',
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () {_text1controller.clear();},icon: const Icon(Icons.clear)
                  ),
                  prefixIcon: const Icon(Icons.search),
            )
          ),
          MaterialButton(onPressed: (){
            setState(() {
              prompt=_text1controller.text;
              modPrompt="act as a tutor and instated of providing the direct answer to the question provide me the steps to reach the answer and the question is $prompt";
              gemini.text(modPrompt)
              .then((value) =>result=( value?.content?.parts?.last.text )!); 
              }
              );
      
          },
          color: Colors.blue,
          elevation: 2,
          
          child :const Text('serach'))
          
          ],
          ),
          ),)
            ));
  }
}

