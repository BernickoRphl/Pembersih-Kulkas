import 'dart:convert';

import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:pembersih_kulkas/shared/shared.dart';
import 'package:http/http.dart' as http;

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _openAi = OpenAI.instance.build(
      token: OPENAI_API_KEY,
      baseOption: HttpSetup(receiveTimeout: const Duration(seconds: 10)),
      enableLog: true);
  final _currentUser = ChatUser(id: '1', firstName: 'User', lastName: 'Name');
  final _chatGptUser = ChatUser(id: '2', firstName: 'AI');

  List<ChatMessage> _messages = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
        title: const Text(
          'Recipt Maker',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: DashChat(
          currentUser: _currentUser,
          messageOptions: const MessageOptions(
              currentUserContainerColor: Colors.black,
              containerColor: Color.fromRGBO(0, 166, 126, 1),
              textColor: Colors.white),
          onSend: (ChatMessage m) {
            getChatResponse(m);
          },
          messages: _messages),
    );
  }

  // Future<void> getChatResponse(ChatMessage m) async {
  //   setState(() {
  //     _messages.insert(0, m);
  //   });

  //   List<Map<String, dynamic>> _messagesHistory = _messages.reversed.map((m) {
  //     return {
  //       'role': m.user == _currentUser ? 'user' : 'assistant',
  //       'content': m.text,
  //     };
  //   }).toList();

  //   final request = ChatCompleteText(
  //       model: GptTurboChatModel(), messages: _messagesHistory, maxToken: 200);

  //   final response = await _openAi.onChatCompletion(request: request);

  //   for (var element in response!.choices) {
  //     setState(() {
  //       _messages.insert(
  //           0,
  //           ChatMessage(
  //               user: _chatGptUser,
  //               createdAt: DateTime.now(),
  //               text: element.message!.content));
  //     });
  //   }
  // }

  // Future<void> getChatResponse(ChatMessage m) async {
  //   setState(() {
  //     _messages.insert(0, m);
  //   });

  //   try {
  //     final response = await http.post(
  //       Uri.parse('http://127.0.0.1:8000/generate/send'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode({
  //         'message': m.text,
  //         'user_id': _currentUser.id,
  //       }),
  //     );

  //     if (response.statusCode == 200) {
  //       final data = jsonDecode(response.body);
  //       setState(() {
  //         _messages.insert(
  //           0,
  //           ChatMessage(
  //             user: _chatGptUser,
  //             createdAt: DateTime.parse(data['timestamp']),
  //             text: data['message'],
  //           ),
  //         );
  //       });
  //     }
  //   } catch (e) {
  //     print('Error: $e');
  //   }
  // }

  Future<String> fetchApiKey() async {
    final response = await http.get(Uri.parse('http://10.0.2.2:8000/api-key'));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      if (data.containsKey('api_key')) {
        return data['api_key'];
      } else {
        throw Exception('API key tidak ditemukan dalam respons: $data');
      }
    } else {
      throw Exception('Gagal memuat API key: ${response.statusCode}');
    }
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
    });

    try {
      // Ambil API Key dari Laravel
      String apiKey = await fetchApiKey();

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/generate/send'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey', // Gunakan API Key di header
        },
        body: jsonEncode({
          'message': m.text,
          'user_id': _currentUser.id,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _messages.insert(
            0,
            ChatMessage(
              user: _chatGptUser,
              createdAt: DateTime.parse(data['timestamp']),
              text: data['message'],
            ),
          );
        });
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
