import 'package:flutter/material.dart';

class SceneCell extends StatefulWidget {
  final String? sceneName;
  final String? sceneImgPath;
  
  const SceneCell({
    super.key,
    required this.sceneName,
    required this.sceneImgPath,
  });

  @override
  State<SceneCell> createState() => _SceneCellState();
}

class _SceneCellState extends State<SceneCell> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (widget.sceneImgPath != null)
            Image.asset(widget.sceneImgPath!),
          const SizedBox(height: 10),
          if (widget.sceneName != null)
            Text(
              widget.sceneName!,
              style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            ),
        ],
      ),
    );
  }
}
