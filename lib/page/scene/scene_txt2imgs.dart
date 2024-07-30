import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sd_client/data/const_prompt.dart';
import 'package:sd_client/data/const_txt2imgs.dart';
import 'package:sd_client/page/mine/result/txt2imgs_result.dart';
import 'package:sd_client/page/scene/txt2imgs_result_tmp.dart';

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
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  bool _showAdvancedOptions = false;

  // 需要用户传递的参数
  // String _currPrompt = "";
  // String _currNegativePrompt = "";
  double _imageCount = 1; // 图片数量变量
  // 最终参数
  // Map<String, dynamic> finalParams = Map<String, dynamic>.from(_baseTxt2img);

  // 提示词选择弹出框
  void _templateRadioDialog(
      BuildContext context,
      TextEditingController controller,
      String title,
      Map<String, String> constPrompt) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Container(
            width: double.maxFinite,
            child: ListView(
              children: constPrompt.entries.map((entry) {
                return ListTile(
                  title: Text(entry.key),
                  // subtitle: Text(entry.value),
                  onTap: () {
                    setState(() {
                      if (title == "TEMPLATE") {
                        controller.text = entry.value;
                      } else if (title == "WORD") {
                        controller.text += entry.value;
                      }
                    });
                    Navigator.of(context).pop();
                  },
                );
              }).toList(),
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
                              onPressed: () => _templateRadioDialog(context,
                                  _controller1, "TEMPLATE", promptTemplate),
                              child: Text(
                                "提示词模板",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _templateRadioDialog(
                                  context, _controller1, "WORD", promptSug),
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
                                onPressed: () => _templateRadioDialog(
                                    context, _controller1, "WORD", promptSug),
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

                        // 按钮添加提示词
                        Wrap(
                          spacing: 8.0,
                          runSpacing: 8.0,
                          children: [
                            ElevatedButton(
                              onPressed: () => _templateRadioDialog(
                                  context,
                                  _controller2,
                                  "TEMPLATE",
                                  negativePromptTemplate),
                              child: Text(
                                "提示词模板",
                                style: TextStyle(
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () => _templateRadioDialog(context,
                                  _controller2, "WORD", negativePromptSug),
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
                                onPressed: () => _templateRadioDialog(context,
                                    _controller2, "WORD", negativePromptSug),
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
              onPressed: () {
                // 整合参数，转为json
                Map<String, dynamic> finalParams =
                    Map<String, dynamic>.from(baseTxt2img);
                finalParams['prompt'] = _controller1.text.isNotEmpty
                    ? _controller1.text
                    : finalParams['prompt'];
                finalParams['negative_prompt'] = _controller2.text.isNotEmpty
                    ? _controller2.text
                    : finalParams['negative_prompt'];
                finalParams['batch_size'] = _imageCount.round();

                // 发送参数到云端，获取队列信息

                // 传递参数到结果页，具体生成结果交由结果页处理
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Txt2ImgsResultTmp(txt2ImgsParams: finalParams),
                  ),
                );
              },
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
