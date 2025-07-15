import 'package:flutter/material.dart';
import 'package:sd_client/page/mine/result/result_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MinePage extends StatefulWidget {
  const MinePage({super.key});

  @override
  State<MinePage> createState() => _MinePageState();
}

class _MinePageState extends State<MinePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 16.0), // Added space to the left and right
          child: Column(
            children: [
              // User Profile Section
              Container(
                padding: const EdgeInsets.all(16.0),
                margin: const EdgeInsets.only(top: 20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3), // Changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundImage: AssetImage(
                              'assets/images/logo/y2.jpg'), // Placeholder for avatar image
                        ),
                        SizedBox(width: 16),
                        Text(
                          '1234',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              '2',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '作品',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              '12',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              '收藏',
                              style: TextStyle(
                                color: Colors.grey[600],
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // Menu Section
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuItem(Icons.picture_in_picture_sharp, '生成图片', () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ResultPage()),
                      );
                    }),
                    _buildMenuItem(Icons.remove_red_eye, '我的浏览', () {}),
                    _buildMenuItem(Icons.person, '用户资料', () {}),
                    _buildMenuItem(Icons.settings, '设置', () {}),
                  ],
                ),
              ),
              SizedBox(height: 20),
              // About Section
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 3), // Changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuItem(Icons.info, '关于我们', () {}),
                    _buildMenuItem(Icons.phone, '联系我们', () {}),
                  ],
                ),
              ),
              SizedBox(height: 40),
              // Logout Button
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 12),
                  ),
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  child: Text(
                    '退出登录',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              SizedBox(height: 20), // 添加一些底部间距
            ],
          ),
        ),
      ),
    );
  }

  // Menu item builder
  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.orangeAccent),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  // Show logout confirmation dialog
  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('退出登录'),
          content: Text('确定要退出登录吗？'),
          actions: [
            TextButton(
              onPressed: () {
                // 可选：移除用户相关数据
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
            TextButton(
              onPressed: () async {
                // 先清除本地存储的用户数据
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove('token'); // 移除存储的登录Token
                await prefs.remove('user_data');
                // 这里可以添加登出逻辑，比如清除本地存储的用户数据并返回登录页面
                Navigator.of(context).pop(); // 先关闭对话框
                Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login',
                  (route) => false,
                ); // 跳转到登录页面
              },
              child: Text(
                '退出',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }
}
