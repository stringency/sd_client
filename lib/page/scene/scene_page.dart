import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sd_client/page/scene/scene_cell.dart';
import 'package:sd_client/page/scene/scene_txt2imgs.dart';
import 'package:flutter/cupertino.dart';

class ScenePage extends StatefulWidget {
  const ScenePage({super.key});

  @override
  State<ScenePage> createState() => _ScenePageState();
}

class _ScenePageState extends State<ScenePage> {
  // 模拟场景数据
  final List<Map<String, String>> sceneInfos = [
    {'name': '营销展会', 'imgPath': 'assets/images/sceneimgs/scene11.png'},
    {'name': '产品宣传', 'imgPath': 'assets/images/sceneimgs/example.png'},
    {'name': 'Logo设计', 'imgPath': 'assets/images/sceneimgs/example.png'},
    {'name': '社交媒体宣传', 'imgPath': 'assets/images/sceneimgs/example.png'},
    {'name': '产品包装设计', 'imgPath': 'assets/images/sceneimgs/example.png'},
    {'name': '基于。。。', 'imgPath': 'assets/images/sceneimgs/example.png'},
  ];
  final List<Map<String, List<Map<String, String>>>> styleInfos = [
    {
      '营销展会': [
        {"科技抽象": "assets/images/sceneimgs/scene11.png"},
        {"自然环保": "assets/images/sceneimgs/scene12.png"},
        {"国风唯美": "assets/images/sceneimgs/scene13.png"},
      ]
    },
    {
      '产品宣传': [
        {"科技抽象": "assets/images/sceneimgs/scene11.png"},
        {"自然环保": "assets/images/sceneimgs/scene12.png"},
        {"国风唯美": "assets/images/sceneimgs/scene13.png"},
      ]
    },
    {
      'Logo设计': [
        {"科技抽象": "assets/images/sceneimgs/scene11.png"},
        {"自然环保": "assets/images/sceneimgs/scene12.png"},
        {"国风唯美": "assets/images/sceneimgs/scene13.png"},
      ]
    },
    {
      '社交媒体宣传': [
        {"科技抽象": "assets/images/sceneimgs/scene11.png"},
        {"自然环保": "assets/images/sceneimgs/scene12.png"},
        {"国风唯美": "assets/images/sceneimgs/scene13.png"},
      ]
    },
    {
      '产品包装设计': [
        {"科技抽象": "assets/images/sceneimgs/scene11.png"},
        {"自然环保": "assets/images/sceneimgs/scene12.png"},
        {"国风唯美": "assets/images/sceneimgs/scene13.png"},
      ]
    },
    {
      '基于': [
        {"科技抽象": "assets/images/sceneimgs/scene11.png"},
        {"自然环保": "assets/images/sceneimgs/scene12.png"},
        {"国风唯美": "assets/images/sceneimgs/scene13.png"},
      ]
    },
  ];

  int? _selectedIndex;

  void _showSelectStyle(BuildContext context, String sceneName) {
    final List<Map<String, String>> styles = styleInfos
        .firstWhere((element) => element.keys.contains(sceneName))[sceneName]!;

    int? _selectedStyleIndex;
    Map<String, String>? _selectedStyle;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Center(
                  child: Text(
                '$sceneName风格',
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
                          _selectedStyle = {styleName: styleImgPath};
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
                        MaterialPageRoute(
                          builder: (context) => Txt2Imgs(
                            selectedScene: sceneName,
                            selectedStyle: _selectedStyle!,
                          ),
                        ),
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
            );
          },
        );
      },
    ).then(
      (result) {
        // 处理从对话框返回的结果
        setState(() {
          _selectedIndex = null; // 重置选中的场景
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text("场景界面"),
      // ),
      body: Container(
        child: GridView.builder(
          padding: const EdgeInsets.all(20.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 1, // 每行显示3个
            crossAxisSpacing: 10.0, // 两个子项之间的间隔
            mainAxisSpacing: 8.0, // 两个子项之间的间隔
            childAspectRatio: 1.4, // 子项宽高比
          ),
          itemCount: sceneInfos.length, // 模拟数据长度
          itemBuilder: (context, index) {
            return SceneCell(
              sceneName: sceneInfos[index]['name'], // 模拟名称
              sceneImgPath: sceneInfos[index]['imgPath'], // 模拟图标
              isSelected: _selectedIndex == index, // 判断每个cell是否是当前选中的
              onTap: () {
                setState(() {
                  _selectedIndex = index;
                });
                final sceneName = sceneInfos[index]['name'];
                _showSelectStyle(context, "$sceneName");
              }, // 传入回调函数
            );
          },
        ),
      ),
    );
  }
}
