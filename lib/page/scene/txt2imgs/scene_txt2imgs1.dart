import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:sd_client/data/const_prompt.dart';
import 'package:sd_client/data/const_txt2imgs.dart';
import 'package:sd_client/data/scene_style_models.dart';

import 'package:sd_client/page/scene/txt2imgs/txt2imgs_result_tmp.dart';
import 'package:sd_client/page/scene/txt2imgs/txt2imgs_result_tmp2.dart';
import 'package:sd_client/tools/gpt_page2.dart';

class Txt2Imgs1 extends StatefulWidget {
  final String? selectedScene;
  final List<String>? selectedStyle;

  const Txt2Imgs1({
    super.key,
    required this.selectedScene,
    required this.selectedStyle,
  });

  @override
  State<Txt2Imgs1> createState() => _Txt2Imgs1State();
}

class _Txt2Imgs1State extends State<Txt2Imgs1> {
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  bool _showAdvancedOptions = false;

// 固定SD参数
  Map<String, dynamic>? finalParams;

  // 需要用户传递的参数
  // String _currPrompt = "";
  // String _currNegativePrompt = "";
  double _imageCount = 1; // 图片数量变量
  // 高级参数
  // double _image_cfg_scale = 1.5; // 图片缩放
  // double _image_cfg_scale = 1.5; // 原图占比
  double _cfg_scale = 7; // 图文关联
  String _samplerMethod = "DPM++ 2M"; // 采样器
  double _steps = 20.0; // 迭代步数
  double _denoising_strength = 0.75; // 重绘强度
  double _weight = 1; // CN权重
  double _guidance_start = 0; // CN开始
  double _guidance_end = 1; // CN结束
  // 最终参数
  // Map<String, dynamic> finalParams = Map<String, dynamic>.from(_baseTxt2img);

  // 初始化值
  @override
  void initState() {
    super.initState();
    print("${widget.selectedScene}${widget.selectedStyle![0]}");
    finalParams = Map<String, dynamic>.from(
        paramTxt2Imgs["${widget.selectedScene}${widget.selectedStyle![0]}"]);
    
    // _imageZoom = finalParams!['image_cfg_scale'];
    _cfg_scale =
        finalParams!['cfg_scale'].toDouble(); // 在 initState 方法中初始化 scene
    _samplerMethod = finalParams!['sampler_name']; // 在 initState 方法中初始化 scene
    _steps = finalParams!['steps'].toDouble(); // 在 initState 方法中初始化 scene
    _denoising_strength = finalParams!['denoising_strength'].toDouble();
    _weight = finalParams!['alwayson_scripts']['controlnet']['args'][0]
            ['weight']
        .toDouble(); // 在 initState 方法中初始化 scene
    _guidance_start = finalParams!['alwayson_scripts']['controlnet']['args'][0]
            ['guidance_start']
        .toDouble(); // 在 initState 方法中初始化 scene
    _guidance_end = finalParams!['alwayson_scripts']['controlnet']['args'][0]
            ['guidance_end']
        .toDouble(); // 在 initState 方法中初始化 scene

    _controller1.text = finalParams!['prompt'];
  }

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
    // 切换模型
    String? modelInfo = "$selectedSceneName$selectedStyleName";
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
                            labelText: '额外提示词(选填)',
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
                                  _controller1, "TEMPLATE", promptTemplatetest),
                              child: Text(
                                "图片效果",
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
                                "文字模板",
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
                                  "提示词点这里",
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
                      "采样器选:",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 80.0),
                      child: Container(
                        // color: Colors.red,
                        child: PopupMenuButton<String>(
                          initialValue: _samplerMethod,
                          onSelected: (value) {
                            setState(
                              () {
                                _samplerMethod = value; // 更新变量值
                              },
                            );
                          },
                          itemBuilder: (BuildContext context) {
                            return <PopupMenuEntry<String>>[
                              PopupMenuItem<String>(
                                value: 'DPM++ 2M',
                                child: Text('DPM++ 2M'),
                              ),
                              PopupMenuItem<String>(
                                value: 'DPM++ SDE',
                                child: Text('DPM++ SDE'),
                              ),
                              PopupMenuItem<String>(
                                value: 'Euler',
                                child: Text('Euler'),
                              ),
                              PopupMenuItem<String>(
                                value: 'Euler a',
                                child: Text('Euler a'),
                              ),
                            ];
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              children: [
                                Text(
                                  _samplerMethod,
                                  style: TextStyle(
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Icon(Icons.arrow_drop_down),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                // Row(
                //   children: [
                //     Text(
                //       "原图占比:",
                //       style: TextStyle(
                //         fontSize: 12.0,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     Expanded(
                //       child: Slider(
                //         min: 1.5,
                //         max: 2.5,
                //         value: _image_cfg_scale,
                //         divisions: 10, // 设定分区数为10，根据需求可调整
                //         label: _image_cfg_scale.toStringAsFixed(1), // 保留一位小数
                //         onChanged: (value) {
                //           setState(() {
                //             _image_cfg_scale = value;
                //           });
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                // Row(
                //   children: [
                //     Text(
                //       "原图占比:",
                //       style: TextStyle(
                //         fontSize: 12.0,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //     Expanded(
                //       child: Slider(
                //         min: 1,
                //         max: 2,
                //         value: _denoising_strength,
                //         divisions: 100,
                //         label: _denoising_strength.toStringAsFixed(2), // 保留一位小数
                //         onChanged: (value) {
                //           setState(() {
                //             _denoising_strength = value;
                //           });
                //         },
                //       ),
                //     ),
                //   ],
                // ),
                Row(
                  children: [
                    Text(
                      "图文关联:",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        min: 1,
                        max: 20,
                        value: _cfg_scale,
                        divisions: 38,
                        label: _cfg_scale.toStringAsFixed(1), // 保留一位小数
                        onChanged: (value) {
                          setState(() {
                            _cfg_scale = value;
                          });
                        },
                      ),
                    ),
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
                        min: 20,
                        max: 100,
                        value: _steps,
                        divisions: 80,
                        label: _steps.toStringAsFixed(1), // 保留一位小数
                        onChanged: (value) {
                          setState(() {
                            _steps = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "重绘强度:",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: 1,
                        value: _denoising_strength,
                        divisions: 100,
                        label: _denoising_strength.toStringAsFixed(2), // 保留一位小数
                        onChanged: (value) {
                          setState(() {
                            _denoising_strength = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "CN权重:  ",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: 2,
                        value: _weight,
                        divisions: 40,
                        label: _weight.toStringAsFixed(2), // 保留一位小数
                        onChanged: (value) {
                          setState(() {
                            _weight = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "CN开始:  ",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: 1,
                        value: _guidance_start,
                        divisions: 100,
                        label: _guidance_start.toStringAsFixed(2), // 保留一位小数
                        onChanged: (value) {
                          setState(() {
                            _guidance_start = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "CN结束:  ",
                      style: TextStyle(
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Expanded(
                      child: Slider(
                        min: 0,
                        max: 1,
                        value: _guidance_end,
                        divisions: 100,
                        label: _guidance_end.toStringAsFixed(2), // 保留一位小数
                        onChanged: (value) {
                          setState(() {
                            _guidance_end = value;
                          });
                        },
                      ),
                    ),
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

                // 参数填充
                // 模型更换
                // print(modelInfos[modelInfo]?["sd_model_checkpoint"]);
                finalParams!['override_settings']['sd_model_checkpoint'] =
                    modelInfos[modelInfo]?["sd_model_checkpoint"];
                // vae模型更换
                finalParams!['override_settings']['sd_vae'] =
                    modelInfos[modelInfo]?["sd_vae"];
                // 图片参数
                // finalParams!['init_images'] = init_images;
                // finalParams['alwayson_scripts']['controlnet']['args'][0]
                //     ['image']['image'] = init_images[0];
                // 蒙版参数
                // finalParams['alwayson_scripts']['controlnet']['args'][0]
                //     ['image']['mask'] = mask_images[0];
                finalParams!['prompt'] = _controller1.text;
                // 加入lora 参数
                finalParams!['prompt'] +=
                    modelInfos[modelInfo]?["lora"].join(",");
                // finalParams!['negative_prompt'] = _controller2.text.isNotEmpty
                //     ? _controller2.text
                //     : finalParams!['negative_prompt'];
                finalParams!['n_iter'] = _imageCount;
                // 高级选项
                // 采样器
                finalParams!['sampler_name'] = _samplerMethod;
                finalParams!['sampler_index'] = _samplerMethod;
                // 原图占比
                // finalParams!['image_cfg_scale'] = _image_cfg_scale;
                // 图文关联
                finalParams!['cfg_scale'] = _cfg_scale;
                // 迭代步数
                finalParams!['steps'] = _steps;
                // 重绘强度
                finalParams!['denoising_strength'] = _denoising_strength;
                // CN权重
                finalParams!['alwayson_scripts']['controlnet']['args'][0]
                    ['weight'] = _weight;
                // CN开始
                finalParams!['alwayson_scripts']['controlnet']['args'][0]
                    ['guidance_start'] = _guidance_start;
                // CN结束
                finalParams!['alwayson_scripts']['controlnet']['args'][0]
                    ['guidance_end'] = _guidance_end;
                // test
                // seed:
                // finalParams!['seed'] = -1;
                // finalParams['save_images'] = true;

                // print(finalParams);

                // 发送参数到云端，获取队列信息

                // 传递参数到结果页，具体生成结果交由结果页处理
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        Txt2ImgsResultTmp2(txt2ImgsParams: finalParams!),
                  ),
                ).then((value) {
                  setState(() {
                    finalParams = Map.from(paramTxt2Imgs[
                        "${widget.selectedScene}${widget.selectedStyle![0]}"]);
                  });
                });
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
