import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sd_client/data/scene_style_imgs.dart';
import 'package:sd_client/page/scene/scene_cell.dart';
import 'package:sd_client/page/scene/txt2imgs/scene_txt2imgs.dart';
import 'package:sd_client/page/scene/show_select_style.dart';

class ScenePage extends StatefulWidget {
  const ScenePage({super.key});

  @override
  State<ScenePage> createState() => _ScenePageState();
}

class _ScenePageState extends State<ScenePage> {
  int? _selectedIndex;

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
                // _showSelectStyle(context, "$sceneName");
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return StatefulBuilder(
                      builder: (BuildContext context, StateSetter setState) {
                        return ShowSelectStyle(
                          sceneName: sceneName!,
                          updateSelectedIndex: (newIndex) {
                            // 更新选中的场景
                            setState(() {
                              _selectedIndex = newIndex;
                            });
                          },
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
              }, // 传入回调函数
            );
          },
        ),
      ),
    );
  }
}
