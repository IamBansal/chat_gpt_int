import 'dart:convert';
import 'package:chat_gpt_int/screens/data_screen.dart';
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

  Future<Response?> makeChatRequest() async {

    String input = _inputController.text;
    final url = Uri.parse('https://api.openai.com/v1/chat/completions');
    final headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer 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',
    };
    final body = jsonEncode({
      "model": "gpt-3.5-turbo",
      "messages": [{"role": "user", "content": input}]
    });

    try {
      final response = await http.post(url, headers: headers, body: body);
      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        final result = Response.fromJson(jsonResponse);
        setState(() {
          _response = result.choices[0].message.content;
        });
        return result;
      } else {
      }
    } catch (e) {
      _response = 'Error occurred: $e';
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _inputController,
              decoration: const InputDecoration(
                labelText: 'Enter some input',
              ),
            ),
            const SizedBox(height: 16.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: makeChatRequest,
                  child: const Text('Send Request'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: saveInDB,
                  child: const Text('Save the chat'),
                ),
                const SizedBox(width: 16.0),
                ElevatedButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder:(context) => const DataScreen()));
                    },
                  child: const Text('History'),
                )
              ],
            ),
            const SizedBox(height: 16.0),
            const Text(
              'Response:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(_response),
          ],
        ),
      ),
    );
  }

  void saveInDB(){
    //TODO - Implement to save data in firebase
  }
}
