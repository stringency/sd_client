import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("我的界面"),
      ),
      body: const Center(
        child: Text("我的界面"),
      ),
    );
  }
}