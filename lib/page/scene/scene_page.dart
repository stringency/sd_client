import 'package:flutter/material.dart';
import 'package:sd_client/page/scene/scene_cell.dart';

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
  final List<String> sceneImgPaths = [
    'assets/images/scene11.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("场景界面"),
      ),
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
            );
          },
        ),
      ),
    );
  }
}
