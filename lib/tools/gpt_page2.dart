import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

/** 后端GPT Bot接入*/
class GptPage2 extends StatefulWidget {
  @override
  _GptPage2State createState() => _GptPage2State();
}

class _GptPage2State extends State<GptPage2> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [{'role': 'bot', 'content': "您好！请告诉我您想生成的图像类型。您可以简单描述它，比如：‘我想要一张关于未来城市的图像’或‘我想要一张森林里的小屋图片’。"}];
  final ScrollController _scrollController = ScrollController();
  // final String apiUrl = 'http://10.105.164.201:8000/api/v1/gptbot/';

  // 滚动到最新消息处
  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  // 发送消息
  Future<void> sendMessage(String message) async {
    if (message.isEmpty) return;

    setState(() {
      _messages.add({'role': 'user', 'content': message});
      _controller.clear();
    });

    _scrollToBottom();

    try {
      final apiUrl =
          Uri.parse("http://10.105.164.201:8000/api/v1/gptbot/deepseek_bot/deepseek_online/");
    
      // final apiUrl =
      //     Uri.parse("http://10.105.164.201:8000/api/v1/gptbot/deepseek_bot/");

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final headers = {
        "Content-Type": "application/json; charset=utf-8",
        "Authorization": token
      };
      final body = jsonEncode({'message': message});

      final response = await http.post(
        apiUrl,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(utf8.decode(response.bodyBytes));
        final reply = data['response'] ?? 'Error: No response received';
        setState(() {
          _messages.add({'role': 'bot', 'content': reply});
        });
      } else {
        setState(() {
          // final data = jsonDecode(utf8.decode(response.bodyBytes));
          // final reply = data['response'] ?? 'Error: No response received';
          _messages.add({'role': 'bot', 'content': 'Error: Server error'});
        });
      }
    } catch (e) {
      setState(() {
        _messages.add({'role': 'bot', 'content': 'Error: $e'});
      });
    }

    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Container(
          margin: EdgeInsets.only(right: 50),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '   提示词引导助手',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                alignment: Alignment.center,
                child: Text(
                  '您专属的提示词专家',
                  style: TextStyle(
                    fontSize: 10,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUserMessage = message['role'] == 'user';
                return Align(
                  alignment: isUserMessage
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color:
                          isUserMessage ? Colors.blue[100] : Colors.grey[300],
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                        bottomLeft: isUserMessage
                            ? Radius.circular(16)
                            : Radius.circular(0),
                        bottomRight: isUserMessage
                            ? Radius.circular(0)
                            : Radius.circular(16),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SelectableText(
                          message['content']!,
                          style: TextStyle(fontSize: 16),
                        ),
                        SizedBox(height: 5),
                        isUserMessage
                            ? Text(
                                '',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey[700],
                                ),
                              )
                            : Image(
                                width: 14,
                                image: AssetImage("assets/images/logo/y2.jpg"),
                              ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(hintText: '请问任何提示词问题...'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    final message = _controller.text;
                    sendMessage(message);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
