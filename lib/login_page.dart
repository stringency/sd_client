import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:sd_client/root_page.dart';
import 'register_page.dart'; // 引入注册页面

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  bool _isKeyboardVisible = false; // 🔥 用于检测键盘状态

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // 监听键盘状态
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;
      });
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse('http://10.105.164.201:8000/api/v1/user_management/user_info/login/'),
      body: jsonEncode({
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)["data"];
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', data['token']);
      await prefs.setString('username', data['username']);
      await prefs.setString('role', data['role']);

      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const RootPage()),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('登录失败，请检查用户名或密码')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(), // 🔥 点击空白区域收起键盘
      child: Scaffold(
        resizeToAvoidBottomInset: true, // 🔥 让键盘弹出时不遮挡输入框
        appBar: AppBar(title: const Text("登录")),
        body: SingleChildScrollView( // 🔥 让页面可滚动，防止溢出
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: _isKeyboardVisible ? 60 : 100, // 🔥 键盘弹出时缩小 Logo
                  child: ScaleTransition(
                    scale: _animation,
                    child: Hero(
                      tag: "logo",
                      child: Image.asset(
                        "assets/images/logo/y2.jpg",
                        width: 100,
                        height: 100,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: "用户名"),
                ),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: "密码"),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                _isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _login,
                        child: const Text("登录"),
                      ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterPage()));
                  },
                  child: const Text("没有账号？去注册"),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
