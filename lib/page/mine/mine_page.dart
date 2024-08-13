import 'package:flutter/material.dart';
import 'package:sd_client/page/mine/mine_cell.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MinePage> {
  Widget headerWidget() {
    return Container(
      height: 200,
      color: Colors.white,
      child: Container(
        margin:
            const EdgeInsets.only(top: 100, bottom: 20, left: 20, right: 10),
        child: Row(
          children: [
            Container(
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: const DecorationImage(
                  image: AssetImage("assets/images/logo/TitanLab.png"),
                  fit: BoxFit.cover, //自动裁剪图片
                ),
              ),
            ),
            Expanded(
              child: Container(
                // width: MediaQuery.of(context).size.width, // 获取屏幕宽度 - 100
                padding: const EdgeInsets.only(
                    left: 15, top: 8, right: 10, bottom: 15),
                // color: Colors.red,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // 用户名
                    Container(
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "您好TitanLab设计师",
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 17,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // id号
                    Container(
                      child: const Row(
                        children: [
                          Expanded(
                            child: Text(
                              "ID:1",
                              style: TextStyle(
                                  // fontWeight: FontWeight.w500,
                                  fontSize: 13,
                                  color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Icon(Icons.navigate_next),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromRGBO(220, 220, 220, 0.5),
        child: Stack(
          children: [
            // mine内容
            Container(
              child: MediaQuery.removePadding(
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    // 头部
                    headerWidget(),
                    const SizedBox(
                      height: 5,
                    ),
                    // 列表
                    Column(
                      children: [
                        const MineCell(
                          iconName: Icon(Icons.mood),
                          title: "图库",
                        ),
                        // 分割线
                        const SizedBox(
                          height: 5,
                        ),
                        const MineCell(
                          iconName: Icon(Icons.mood_bad),
                          title: "伤心2",
                          subTitle: "原因",
                          subIconName: Icon(Icons.priority_high,
                              size: 13, color: Colors.red),
                        ),
                        Row(
                          children: [
                            Container(
                                width: 50, height: 0.5, color: Colors.white),
                            Container(height: 0.5, color: Colors.grey),
                          ],
                        ),
                        const MineCell(
                          iconName: Icon(Icons.mood),
                          title: "开心4",
                        ),
                        Row(
                          children: [
                            Container(
                                width: 50, height: 0.5, color: Colors.white),
                            Container(height: 0.5, color: Colors.grey),
                          ],
                        ),
                        const MineCell(
                          iconName: Icon(Icons.mood_bad),
                          title: "伤心5",
                          subTitle: "原因",
                          subIconName: Icon(Icons.priority_high,
                              size: 13, color: Colors.red),
                        ),
                        Row(
                          children: [
                            Container(
                                width: 50, height: 0.5, color: Colors.white),
                            Container(height: 0.5, color: Colors.grey),
                          ],
                        ),
                        const MineCell(
                          iconName: Icon(Icons.mood_bad),
                          title: "伤心伤心6",
                          subTitle: "原因是裂开",
                          subIconName: Icon(Icons.priority_high,
                              size: 13, color: Colors.red),
                        ),
                        Row(
                          children: [
                            Container(
                                width: 50, height: 0.5, color: Colors.white),
                            Container(height: 0.5, color: Colors.grey),
                          ],
                        ),
                        const MineCell(
                          iconName: Icon(Icons.mood),
                          title: "开心7",
                        ),
                        // 分割线
                        const SizedBox(
                          height: 5,
                        ),
                        const MineCell(
                          iconName: Icon(Icons.mood_bad),
                          title: "伤心伤心8",
                          subTitle: "原因是裂开",
                          subIconName: Icon(Icons.priority_high,
                              size: 13, color: Colors.red),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            // 悬浮标
            SafeArea(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: const Icon(Icons.self_improvement),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
