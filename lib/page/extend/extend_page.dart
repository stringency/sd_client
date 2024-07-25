import 'package:flutter/material.dart';

class ExtendPage extends StatefulWidget {
  const ExtendPage({super.key});

  @override
  State<ExtendPage> createState() => _MessagePageState();
}

class _MessagePageState extends State<ExtendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("扩展界面"),
      ),
      body: const Center(
        child: Text("扩展界面"),
      ),
    );
  }
}