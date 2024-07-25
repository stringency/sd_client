import 'package:flutter/material.dart';
import 'package:sd_client/page/community/community_page.dart';
import 'package:sd_client/page/extend/extend_page.dart';
import 'package:sd_client/page/home/home_page.dart';
import 'package:sd_client/page/mine/mine_page.dart';
import 'package:sd_client/page/scene/scene_page.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".


  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  static int _currentIndex = 1;

  final List<Widget> _pages = [
    const HomePage(),
    const ScenePage(),
    const ExtendPage(),
    const CommunityPage(),
    const MinePage()
  ];
  final PageController _controller = PageController(initialPage: _currentIndex);
  

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      // appBar: AppBar(
      //   // TRY THIS: Try changing the color here to a specific color (to
      //   // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
      //   // change color while the other colors stay the same.
      //   backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      //   // Here we take the value from the MyHomePage object that was created by
      //   // the App.build method, and use it to set our appbar title.
      //   title: Text(widget.title),
      // ),
      body: PageView(
        // 禁用拖拽
        // physics: NeverScrollableScrollPhysics(),
        // 底部bar跟着改变
        onPageChanged: (int index) {
          // 刷新
          setState(() {
            _currentIndex = index;
          });
        },
        // 指定控制器和页面列表
        controller: _controller,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        // 点击事件
        onTap: (index) {
          setState(
            () {
              _currentIndex = index;
              // 跳转到指定页面
              _controller.jumpToPage(_currentIndex);
            },
          );
        },
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '主页'),
          BottomNavigationBarItem(icon: Icon(Icons.sailing), label: '场景'),
          BottomNavigationBarItem(icon: Icon(Icons.sensors), label: '扩展'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: '社区'),
          // BottomNavigationBarItem(icon: Icon(Icons.sensors), label: '发现'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: '我的')
        ],
      ),
      
    );
  }
}