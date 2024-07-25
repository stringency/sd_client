import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("主页界面"),
      ),
      body: const Center(
        child: Text("主页界面"),
      ),
    );
  }
}