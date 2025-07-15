import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sd_client/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with SingleTickerProviderStateMixin {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmpasswordController =
      TextEditingController();
  bool _isLoading = false;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    setState(() {
      _isLoading = true;
    });

    final response = await http.post(
      Uri.parse(
          'http://10.105.164.201:8000/api/v1/user_management/user_info/register/'),
      body: jsonEncode({
        'username': _usernameController.text,
        'password': _passwordController.text,
        'confirm_password': _confirmpasswordController.text,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 200 || response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('注册成功，请登录')),
      );
      Navigator.pop(context); // 返回登录页面
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('注册失败，请重试')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("注册")),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              left: 16,
              right: 16,
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // 动画部分
                    ScaleTransition(
                      scale: _animation,
                      child: Container(
                        margin: const EdgeInsets.only(top: 40, bottom: 20),
                        child: Image.asset(
                          'assets/images/logo/y2.jpg',
                          height: 100,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),

                    // 输入表单
                    _buildInputForm(),

                    // 底部弹性空间
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputForm() {
    return AutofillGroup(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(
              labelText: "用户名",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            autofillHints: const [AutofillHints.username],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(
              labelText: "密码",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            obscureText: true,
            autofillHints: const [AutofillHints.newPassword],
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _confirmpasswordController,
            decoration: const InputDecoration(
              labelText: "确认密码",
              border: OutlineInputBorder(),
              contentPadding: EdgeInsets.symmetric(horizontal: 12),
            ),
            obscureText: true,
            autofillHints: const [AutofillHints.newPassword],
          ),
          const SizedBox(height: 24),
          _isLoading
              ? const CircularProgressIndicator()
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: _register,
                  child: const Text("注册"),
                ),
          TextButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginPage()));
            },
            child: const Text("已有账号？去登录"),
          ),
        ],
      ),
    );
  }
}
