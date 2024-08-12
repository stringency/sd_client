import 'package:flutter/material.dart';
import 'package:sd_client/data/scene_style_imgs.dart';
import 'package:sd_client/page/scene/img2imgs/scene_img2imgs.dart';
import 'package:sd_client/page/scene/scene_cell.dart';
import 'package:sd_client/page/scene/txt2imgs/scene_txt2imgs.dart';
import 'package:path/path.dart' as path;

class ShowSelectStyle extends StatefulWidget {
  final String sceneName;
  final Function(int?) updateSelectedIndex;

  const ShowSelectStyle({
    super.key,
    required this.sceneName,
    required this.updateSelectedIndex,
  });

  @override
  State<ShowSelectStyle> createState() => _ShowSelectStyleState();
}

class _ShowSelectStyleState extends State<ShowSelectStyle> {
  int? _selectedStyleIndex;
  List<String>? _selectedStyle;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> styles = styleInfos.firstWhere((element) =>
        element.keys.contains(widget.sceneName))[widget.sceneName]!;
    final _currentScenceName = widget.sceneName;
    return Container(
      child: AlertDialog(
        title: Center(
            child: Text(
          '$_currentScenceName风格',
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        )),
        content: Container(
          width: double.maxFinite,
          height: 300,
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, // 每行显示1个
              crossAxisSpacing: 10.0, // 两个子项之间的间隔
              mainAxisSpacing: 8.0, // 两个子项之间的间隔
              childAspectRatio: 1.3, // 子项宽高比
            ),
            itemCount: styles.length,
            itemBuilder: (context, index) {
              final styleName = styles[index].keys.first;
              final styleImgPath = styles[index].values.first;
              return SceneCell(
                sceneName: styleName, // 风格名称
                sceneImgPath: styleImgPath, // 风格图标
                isSelected: _selectedStyleIndex == index,
                onTap: () {
                  setState(() {
                    _selectedStyleIndex = index;
                    _selectedStyle = [styleName, styleImgPath];
                    // print(_selectedStyle);
                  });
                },
              );
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // 关闭弹窗
              // 取消后将当前选项背景变为白色
              // setState(() {
              //   _selectedStyleIndex = null; // 重置风格选择
              // });
            },
            child: Text('取消'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(); // 关闭弹窗
              if (_selectedStyle != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    bool isTxt2img =
                        path.basename(_selectedStyle![1]).substring(0, 3) ==
                                "txt"
                            ? true
                            : false;
                    print(isTxt2img);
                    return isTxt2img
                        ? Txt2Imgs(
                            selectedScene: widget.sceneName,
                            selectedStyle: _selectedStyle!,
                          )
                        : Img2Imgs(
                            selectedScene: widget.sceneName,
                            selectedStyle: _selectedStyle!,
                          );
                  }),
                );
              } else {
                // 弹出提示选择风格
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                          title: Center(
                            child: Text(
                              '警告！',
                              style: TextStyle(
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          content: Text(
                            '请选择您要的场景风格',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // 关闭弹窗
                              },
                              child: Text('确定'),
                            )
                          ]);
                    });
              }
            },
            child: Text('确定'),
          ),
        ],
      ),
    );
  }
}

// void _showSelectStyle(BuildContext context, String sceneName) {
//   final List<Map<String, String>> styles = styleInfos
//       .firstWhere((element) => element.keys.contains(sceneName))[sceneName]!;

//   int? _selectedStyleIndex;
//   List<String>? _selectedStyle;

//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return StatefulBuilder(
//         builder: (BuildContext context, StateSetter setState) {
//           return AlertDialog(
//             title: Center(
//                 child: Text(
//               '$sceneName风格',
//               style: TextStyle(
//                 fontSize: 20.0,
//                 fontWeight: FontWeight.bold,
//               ),
//             )),
//             content: Container(
//               width: double.maxFinite,
//               height: 300,
//               child: GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 1, // 每行显示1个
//                   crossAxisSpacing: 10.0, // 两个子项之间的间隔
//                   mainAxisSpacing: 8.0, // 两个子项之间的间隔
//                   childAspectRatio: 1.3, // 子项宽高比
//                 ),
//                 itemCount: styles.length,
//                 itemBuilder: (context, index) {
//                   final styleName = styles[index].keys.first;
//                   final styleImgPath = styles[index].values.first;
//                   return SceneCell(
//                     sceneName: styleName, // 风格名称
//                     sceneImgPath: styleImgPath, // 风格图标
//                     isSelected: _selectedStyleIndex == index,
//                     onTap: () {
//                       setState(() {
//                         _selectedStyleIndex = index;
//                         _selectedStyle = [styleName, styleImgPath];
//                         // print(_selectedStyle);
//                       });
//                     },
//                   );
//                 },
//               ),
//             ),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // 关闭弹窗
//                   // 取消后将当前选项背景变为白色
//                   // setState(() {
//                   //   _selectedStyleIndex = null; // 重置风格选择
//                   // });
//                 },
//                 child: Text('取消'),
//               ),
//               ElevatedButton(
//                 onPressed: () {
//                   Navigator.of(context).pop(); // 关闭弹窗
//                   if (_selectedStyle != null) {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => Txt2Imgs(
//                           selectedScene: sceneName,
//                           selectedStyle: _selectedStyle!,
//                         ),
//                       ),
//                     );
//                   } else {
//                     // 弹出提示选择风格
//                     showDialog(
//                         context: context,
//                         builder: (BuildContext context) {
//                           return AlertDialog(
//                               title: Center(
//                                 child: Text(
//                                   '警告！',
//                                   style: TextStyle(
//                                     fontSize: 20.0,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),
//                               content: Text(
//                                 '请选择您要的场景风格',
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               actions: [
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop(); // 关闭弹窗
//                                   },
//                                   child: Text('确定'),
//                                 )
//                               ]);
//                         });
//                   }
//                 },
//                 child: Text('确定'),
//               ),
//             ],
//           );
//         },
//       );
//     },
//   ).then(
//     (result) {
//       // 处理从对话框返回的结果
//       setState(() {
//         _selectedIndex = null; // 重置选中的场景
//       });
//     },
//   );
// }
