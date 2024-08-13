import 'package:flutter/material.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 16.0), // Added space to the left and right
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
                          backgroundImage: AssetImage('../../assets/images/avatar.png'), // Placeholder for avatar image
                        ),
                        SizedBox(width: 16),
                        Text(
                          'k1eran',
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
                      offset: Offset(0, 3), // Changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildMenuItem(Icons.folder, '我的文件'),
                    _buildMenuItem(Icons.remove_red_eye, '我的浏览'),
                    _buildMenuItem(Icons.person, '用户资料'),
                    _buildMenuItem(Icons.settings, '设置'),
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
                    _buildMenuItem(Icons.info, '关于我们'),
                    _buildMenuItem(Icons.phone, '联系我们'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Menu item builder
  Widget _buildMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.orangeAccent),
      title: Text(title),
      trailing: Icon(Icons.chevron_right),
      onTap: () {
        // Handle the tap
      },
    );
  }
}
