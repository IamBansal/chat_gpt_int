import 'dart:convert';
import 'package:chat_gpt_int/constants.dart';
import 'package:chat_gpt_int/screens/data_screen.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/Response.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _inputController = TextEditingController();
  String _response = '';
  bool isLoading = false;

  Future<Response?> makeChatRequest() async {
    String input = _inputController.text;
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer ${Constants().API_KEY}',
    };
    final body = jsonEncode({
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": input}
      ]
    });

    try {
      setState(() {
        isLoading = true;
      });
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final result = Response.fromJson(jsonResponse);
        setState(() {
          _response = result.choices[0].message.content;
        });
        return result;
      } else {}
    } catch (e) {
      _response = 'Error occurred: $e';
    }finally{
      setState(() {
        isLoading = false;
      });

    }
    return null;
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pocket ChatGPT'),
      ),
      body: SingleChildScrollView(
        child:
          Column(
            children: [Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              height: 130,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Send a message',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),),
                    const SizedBox(height: 15,),
                    TextFormField(
                      controller: _inputController,
                      decoration: const InputDecoration(
                        hintText: 'Message',
                        // border: InputBorder.none,
                      ),
                      maxLines: 1,
                    ),
                  ],
                ),
              ),
            ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: makeChatRequest,
                child: const Text('Send Message'),
              ),
              const SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  saveInDB(_inputController.text, _response);
                },
                child: const Text('Save the chat'),
              ),
              const SizedBox(width: 16.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DataScreen()));
                },
                child: const Text('History'),
              ),
            ]),
          const SizedBox(height: 16.0),
          const Text(
            'Your Answer:',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4.0),
          Container(
              child: isLoading
              ? const Center(child: CircularProgressIndicator())
              :Container(
                margin: const EdgeInsets.all(10.0),
                child: Text(_response,
                  style: const TextStyle(
                  color: Colors.black
              ),),
          ),
        )
      ]),
    ));
  }

  void saveInDB(String question, String answer) {
    final DatabaseReference _database =
        FirebaseDatabase.instance.reference().child("chatgpt");

    _database
        .push()
        .set({'question': question, 'answer': _response}).then((value) {
          showPopup(context);
      print('Data Added successfully.');
    }).catchError((onError) {
      print("Error occurred $onError");
    });
  }

  void showPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Chat Saved'),
          content: const Text('Chat saved successfully to the database.'),
          actions: [
            ElevatedButton(
              child: const Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}
