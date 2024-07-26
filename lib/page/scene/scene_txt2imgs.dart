import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

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
  bool _showAdvancedOptions = false;
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  double _imageCount = 1; // 图片数量变量
  void _showTextSelectionDialog(
      BuildContext context, TextEditingController controller) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("选择文本"),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              children: [
                ListTile(
                  title: Text("示例文本1"),
                  onTap: () {
                    setState(() {
                      controller.text += "示例文本1";
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text("示例文本2"),
                  onTap: () {
                    setState(() {
                      controller.text += "示例文本2";
                    });
                    Navigator.of(context).pop();
                  },
                ),
                ListTile(
                  title: Text("示例文本3"),
                  onTap: () {
                    setState(() {
                      controller.text += "示例文本3";
                    });
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String? selectedSceneName = widget.selectedScene;
    String? selectedStyleName = widget.selectedStyle?[0].toString();
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "$selectedSceneName - $selectedStyleName",
            style: TextStyle(
              // fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text input fields and image preview
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _controller1,
                          maxLines: 5, // 增加行数
                          decoration: InputDecoration(
                            labelText: '正面提示词',
                            border: OutlineInputBorder(),
                          ),
                        ),

                        // Buttons to add text to input fields
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            ElevatedButton(
                              onPressed: () => _showTextSelectionDialog(
                                  context, _controller1),
                              child: Text(
                                "提示词模板",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _showTextSelectionDialog(
                                  context, _controller2),
                              child: Text(
                                "提示词推荐",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              // width: 100.0,
                              // height: 25.0,
                              child: ElevatedButton(
                                onPressed: () => _showTextSelectionDialog(
                                    context, _controller1),
                                child: Text(
                                  "提示词引导",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 40.0),
                        TextFormField(
                          controller: _controller2,
                          maxLines: 5, // 增加行数
                          decoration: InputDecoration(
                            labelText: '负面提示词',
                            border: OutlineInputBorder(),
                          ),
                        ),

                        // Buttons to add text to input fields
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            ElevatedButton(
                              onPressed: () => _showTextSelectionDialog(
                                  context, _controller1),
                              child: Text(
                                "提示词模板",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _showTextSelectionDialog(
                                  context, _controller2),
                              child: Text(
                                "提示词推荐",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Container(
                              // width: 100.0,
                              // height: 25.0,
                              child: ElevatedButton(
                                onPressed: () => _showTextSelectionDialog(
                                    context, _controller1),
                                child: Text(
                                  "提示词引导",
                                  style: TextStyle(
                                    fontSize: 10.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16.0),

              // Sliders for parameter adjustment
              Row(
                children: [
                  Text(
                    "图片数量:",
                    style: TextStyle(
                      fontSize: 12.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Expanded(
                    child: Slider(
                      min: 1,
                      max: 8,
                      value: _imageCount,
                      divisions: 7,
                      label: _imageCount.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _imageCount = value;
                        });
                      },
                    ),
                  )
                ],
              ),
              // Row(
              //   children: [
              //     Text(
              //       "图片数量:",
              //       style: TextStyle(
              //         fontSize: 12.0,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     Expanded(
              //       child: Slider(
              //         value: 0.5,
              //         onChanged: (value) {},
              //       ),
              //     )
              //   ],
              // ),
              // Row(
              //   children: [
              //     Text(
              //       "图片数量:",
              //       style: TextStyle(
              //         fontSize: 12.0,
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //     Expanded(
              //       child: Slider(
              //         value: 0.5,
              //         onChanged: (value) {},
              //       ),
              //     )
              //   ],
              // ),

              // Toggle for advanced options
              SizedBox(height: 16.0),
              TextButton(
                onPressed: () {
                  setState(() {
                    _showAdvancedOptions = !_showAdvancedOptions;
                  });
                },
                child: Text(_showAdvancedOptions ? '隐藏高级选项' : '显示高级选项'),
              ),

              // Advanced options
              if (_showAdvancedOptions) ...[
                Row(
                  children: [
                    Text(
                      "图片大小:",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: 0.5,
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "采样器的:",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: 0.5,
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "迭代步数:",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        value: 0.5,
                        onChanged: (value) {},
                      ),
                    )
                  ],
                ),
              ],
            ],
          ),
        ),
        bottomNavigationBar: Container(
          // 背景色为透明
          color: Colors.transparent,
          height: 80.0,
          child: Padding(
            // padding:EdgeInsets.all(16.0),
            padding: EdgeInsets.only(
                left: 120.0, right: 120.0, top: 10.0, bottom: 10.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 218, 255, 247),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
              ),
              onPressed: () {},
              child: Center(
                child: Text(
                  "生成图片",
                  style: TextStyle(
                    fontSize: 17.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ));
  }
}
