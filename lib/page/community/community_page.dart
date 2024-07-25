import 'package:flutter/material.dart';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _MessagePageState();
}

class _MessagePageState extends State<CommunityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("社区界面"),
      ),
      body: const Center(
        child: Text("社区界面"),
      ),
    );
  }
}