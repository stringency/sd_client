import 'package:flutter/material.dart';

class Txt2Imgs extends StatefulWidget {
  final String? selectedScene;
  final List<String>? selectedStyle;
  const Txt2Imgs({
    super.key,
    required this.selectedScene,
    required this.selectedStyle,
  });

  @override
  State<Txt2Imgs> createState() => _Txt2ImgsState();
}

class _Txt2ImgsState extends State<Txt2Imgs> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(widget.selectedScene ?? ""),
          Text(widget.selectedStyle?[0] ?? ""),
          Text(widget.selectedStyle?[1] ?? ""),
        ],
      ),
    );
  }
}
