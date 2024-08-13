import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sd_client/data/const_img2imgs.dart';
import 'package:sd_client/data/const_prompt.dart';
import 'package:sd_client/data/const_txt2imgs.dart';
import 'package:sd_client/data/scene_style_models.dart';
import 'package:sd_client/page/mine/result/txt2img/txt2imgs_result.dart';
import 'package:sd_client/page/scene/img2imgs/img2imgs_result_tmp.dart';

import 'package:sd_client/page/scene/txt2imgs/txt2imgs_result_tmp.dart';
import 'package:sd_client/tools/gpt_page.dart';
import 'package:sd_client/tools/gpt_page2.dart';
import 'package:sd_client/tools/gpt_page3.dart';

class Img2Imgs extends StatefulWidget {
  final String? selectedScene;
  final List<String>? selectedStyle;

  const Img2Imgs({
    super.key,
    required this.selectedScene,
    required this.selectedStyle,
  });

  @override
  State<Img2Imgs> createState() => _Img2ImgsState();
}

class _Img2ImgsState extends State<Img2Imgs> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  bool _showAdvancedOptions = false;

  // 用户的图片
  List<String> init_images = [];
  List<String> mask_images = [];
  final ImagePicker _picker = ImagePicker();

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

  // 处理图片为base64
  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      String base64Image = base64Encode(bytes);
      // print(base64Image);
      setState(() {
          // init_images.add(base64Image);
          init_images=[base64Image];
      });
    }
  }

  Future<void> _pickMaskImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final bytes = await image.readAsBytes();
      String base64Image = base64Encode(bytes);
      // print(base64Image);
      setState(() {
        // mask_images.add(base64Image);
        mask_images=[base64Image];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    String? selectedSceneName = widget.selectedScene;
    String? selectedStyleName = widget.selectedStyle?[0].toString();
    // 切换模型
    String? modelInfo = "$selectedSceneName$selectedStyleName";
    // print(modelInfo);
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
              // 图片选择按钮和预览
              GestureDetector(
                onTap: _pickImage,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (init_images.isEmpty)
                        // Icon(
                        //   Icons.add,
                        //   size: 50,
                        //   color: Colors.grey,
                        // )
                        Text(
                          "原图",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.grey,
                          ),
                        )
                      else
                        Image.memory(
                          base64Decode(init_images[0]),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              // 蒙版图片选择按钮和预览
              GestureDetector(
                onTap: _pickMaskImage,
                child: Container(
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (mask_images.isEmpty)
                        // Icon(
                        //   Icons.add,
                        //   size: 50,
                        //   color: Colors.grey,
                        // ),
                        Text(
                          "蒙版",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.grey,
                          ),
                        )
                      else
                        Image.memory(
                          base64Decode(mask_images[0]),
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20.0),
              // 提示词输入框和其他内容
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
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: GptPage2(),
                                      );
                                    },
                                  );
                                  // return _templateRadioDialog(
                                  //     context, _controller1, "WORD", promptSug);
                                },
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
                        // SizedBox(height: 40.0),
                        // TextFormField(
                        //   controller: _controller2,
                        //   maxLines: 5, // 增加行数
                        //   decoration: InputDecoration(
                        //     labelText: '负面提示词',
                        //     border: OutlineInputBorder(),
                        //   ),
                        // ),

                        // // 按钮添加提示词
                        // Wrap(
                        //   spacing: 8.0,
                        //   runSpacing: 8.0,
                        //   children: [
                        //     ElevatedButton(
                        //       onPressed: () => _templateRadioDialog(
                        //           context,
                        //           _controller2,
                        //           "TEMPLATE",
                        //           negativePromptTemplate),
                        //       child: Text(
                        //         "提示词模板",
                        //         style: TextStyle(
                        //           fontSize: 10.0,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //     ElevatedButton(
                        //       onPressed: () => _templateRadioDialog(context,
                        //           _controller2, "WORD", negativePromptSug),
                        //       child: Text(
                        //         "提示词推荐",
                        //         style: TextStyle(
                        //           fontSize: 10.0,
                        //           fontWeight: FontWeight.bold,
                        //         ),
                        //       ),
                        //     ),
                        //     Container(
                        //       // width: 100.0,
                        //       // height: 25.0,
                        //       child: ElevatedButton(
                        //         onPressed: () => _templateRadioDialog(context,
                        //             _controller2, "WORD", negativePromptSug),
                        //         child: Text(
                        //           "提示词引导",
                        //           style: TextStyle(
                        //             fontSize: 10.0,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
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
                    Map<String, dynamic>.from(baseImg2Imgs);
                // 参数填充
                // 模型更换
                // print(modelInfos[modelInfo]?["sd_model_checkpoint"]);
                finalParams['override_settings']['sd_model_checkpoint'] =
                    modelInfos[modelInfo]?["sd_model_checkpoint"];
                // 图片参数
                finalParams['init_images'] = init_images;
                // finalParams['alwayson_scripts']['controlnet']['args'][0]
                //     ['image']['image'] = init_images[0];
                // 蒙版参数
                // finalParams['alwayson_scripts']['controlnet']['args'][0]
                //     ['image']['mask'] = mask_images[0];
                finalParams['prompt'] = _controller1.text.isNotEmpty
                    ? _controller1.text
                    : finalParams['prompt'];
                // 加入lora 参数
                finalParams['prompt'] +=
                    modelInfos[modelInfo]?["lora"].join(",");
                finalParams['negative_prompt'] = _controller2.text.isNotEmpty
                    ? _controller2.text
                    : finalParams['negative_prompt'];
                finalParams['n_iter'] = _imageCount.round();
                // test
                // finalParams['seed'] = 3396603372;
                // finalParams['save_images'] = true;

                // print(finalParams);

                // 发送参数到云端，获取队列信息

                // 传递参数到结果页，具体生成结果交由结果页处理
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Img2ImgsResultTmp(
                        modelinfo: modelInfo, img2ImgsParams: finalParams),
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
