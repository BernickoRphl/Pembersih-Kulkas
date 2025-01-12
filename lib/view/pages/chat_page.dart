part of 'pages.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _currentUser = ChatUser(id: '1', firstName: 'User', lastName: 'Name');
  final _chatGptUser = ChatUser(id: '2', firstName: 'AI Assistant');
  List<ChatMessage> _messages = <ChatMessage>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 166, 126, 1),
        title: const Text(
          'Recipe Maker',
          style: TextStyle(color: Colors.white),
        ),
        elevation: 2,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Masukkan bahan-bahan yang tersedia (pisahkan dengan koma)',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            child: DashChat(
              currentUser: _currentUser,
              messageOptions: const MessageOptions(
                currentUserContainerColor: Colors.black,
                containerColor: Color.fromRGBO(0, 166, 126, 1),
                textColor: Colors.white,
              ),
              onSend: (ChatMessage m) {
                getChatResponse(m);
              },
              messages: _messages,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
    });

    try {
      // Convert comma-separated string to array
      List<String> ingredients = m.text
          .split(',')
          .map((e) => e.trim())
          .where((e) => e.isNotEmpty)
          .toList();

      final response = await http.post(
        Uri.parse('http://10.0.2.2:8000/generate/send'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'ingredients': ingredients,
          'user_id': _currentUser.id,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Response from Laravel: $data'); // Untuk debugging

        if (data['status'] == 'success' && data['data'] != null) {
          setState(() {
            _messages.insert(
              0,
              ChatMessage(
                user: _chatGptUser,
                createdAt: DateTime.parse(data['data']['ai_response']['timestamp']),
                text: data['data']['ai_response']['message'],
              ),
            );
          });
        } else {
          // Tampilkan pesan error ke user
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Terjadi kesalahan: ${data['message']}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        // Tampilkan error response ke user
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: ${response.statusCode}'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Tampilkan error ke user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Terjadi kesalahan: $e'),
          backgroundColor: Colors.red,
        ),
      );
      print('Error connecting to server: $e');
    }
  }

  @override
  void dispose() {
    // Clean up resources
    super.dispose();
  }
}