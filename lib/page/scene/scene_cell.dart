import 'package:flutter/material.dart';
import 'package:sd_client/page/scene/txt2imgs/scene_txt2imgs.dart';

class SceneCell extends StatefulWidget {
  final String? sceneName;
  final String? sceneImgPath;
  final bool isSelected;
  final VoidCallback? onTap;

  const SceneCell({
    super.key,
    required this.sceneName,
    required this.sceneImgPath,
    this.isSelected = false,
    this.onTap,
  });

  @override
  State<SceneCell> createState() => _SceneCellState();
}

class _SceneCellState extends State<SceneCell> {
  Color _currentColor = Colors.white;

  // 初始化的时候调用
  @override
  void didUpdateWidget(SceneCell oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isSelected != oldWidget.isSelected) {
      _currentColor = widget.isSelected ? Colors.purple : Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 按下时候
      onTapDown: (TapDownDetails details) {
        setState(() {
          _currentColor = const Color.fromRGBO(220, 220, 240, 0.5);
        });
      },
      onTap: () {
        setState(() {
          _currentColor = Colors.purple;
        });
        if (widget.onTap != null) {
          widget.onTap!();
        }
      },
      // 点击取消
      onTapCancel: () {
        setState(() {
          _currentColor = Colors.white;
        });
      },

      child: Container(
        decoration: BoxDecoration(
          color: _currentColor,
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
              Container(
                // color: Colors.red,
                child: Image.asset(widget.sceneImgPath!, height: 240),
              ),
            const SizedBox(height: 10),
            if (widget.sceneName != null)
              Container(
                // color: Colors.red,
                child: Text(
                  widget.sceneName!,
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
