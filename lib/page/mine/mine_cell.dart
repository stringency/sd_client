
import 'package:flutter/material.dart';

class MineCell extends StatefulWidget {
  final Icon iconName;
  final String title;
  final String? subTitle;
  final Icon? subIconName;

  const MineCell(
      {super.key,
      required this.iconName,
      required this.title,
      this.subTitle,
      this.subIconName});

  @override
  State<MineCell> createState() => _MineCellState();
}

class _MineCellState extends State<MineCell> {
  Color _currentColor = Colors.white;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (TapDownDetails details) {
        print("点下来了！");
        setState(() {
          _currentColor = const Color.fromRGBO(220, 220, 240, 0.5);
        });
      },
      onTap: () {
        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (BuildContext context) => MineChildPage(
        //       title: widget.title,
        //     ),
        //   ),
        // );
        setState(() {
          _currentColor = const Color.fromRGBO(220, 220, 240, 0.5);
        });
      },
      
      
      onTapCancel: () {
        print("取消了！");
        setState(() {
          _currentColor = Colors.white;
        });
      },
      child: Container(
        height: 50,
        color: _currentColor,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // left
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  widget.iconName,
                  const SizedBox(width: 15),
                  Text(widget.title),
                ],
              ),
            ),
            //right
            Container(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Text(widget.subTitle ?? '',
                      style: const TextStyle(color: Colors.grey, fontSize: 13)),
                  widget.subIconName ?? const SizedBox(),
                  const Icon(Icons.navigate_next)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
