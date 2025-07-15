import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sd_client/page/mine/result/result_page.dart'; // 确保导入结果页面

class Txt2ImgsResultTmp extends StatefulWidget {
  final Map<String, dynamic> finalParams;

  const Txt2ImgsResultTmp({Key? key, required this.finalParams}) : super(key: key);

  @override
  _Txt2ImgsResultTmpState createState() => _Txt2ImgsResultTmpState();
}

class _Txt2ImgsResultTmpState extends State<Txt2ImgsResultTmp> {
  bool _isLoading = true; // 控制加载指示器
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _sendRequest(); // 页面初始化时发送请求
  }

  Future<void> _sendRequest() async {
    try {
      final url = Uri.parse("http://10.105.164.201:8000/api/v1/txt2img/");
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final headers = {
        "Content-Type": "application/json",
        "Authorization": token
      };
      final body = jsonEncode(widget.finalParams);

      final response = await http.post(
        url,
        headers: headers,
        body: body,
      );

      if (response.statusCode == 202) {
        // 请求成功，跳转到结果页面
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ResultPage()),
        );
      } else {
        // 请求失败
        setState(() {
          _isLoading = false;
          _errorMessage = "请求失败: ${response.statusCode}, ${response.body}";
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = "请求异常: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("正在处理...")),
      body: Center(
        child: _isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(), // 旋转加载指示器
                  SizedBox(height: 20),
                  Text("正在生成图片，请稍候..."),
                ],
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("请求失败"),
                  SizedBox(height: 10),
                  Text(_errorMessage ?? "未知错误"),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _isLoading = true;
                        _errorMessage = null;
                      });
                      _sendRequest(); // 重新发送请求
                    },
                    child: Text("重试"),
                  ),
                ],
              ),
      ),
    );
  }
}
