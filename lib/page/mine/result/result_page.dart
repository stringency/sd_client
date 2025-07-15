import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'success_page.dart';
import 'pending_page.dart';

class ResultPage extends StatefulWidget {
  const ResultPage({super.key});

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  List<Map<String, dynamic>> _imageList = [];
  bool _isLoading = true;
  Map<int, Timer> _pollingTimers = {}; // 存储定时器

  @override
  void initState() {
    Future.delayed(Duration(seconds: 1));
    super.initState();
    _fetchImageData();
  }

  @override
  void dispose() {
    // 页面销毁时，清除所有定时器
    _pollingTimers.forEach((key, timer) => timer.cancel());
    super.dispose();
  }

  /// 获取图片数据
  Future<void> _fetchImageData() async {
    try {
      final url = Uri.parse(
          "http://10.105.164.201:8000/api/v1/user_management/user_info/user_img_info_list/");

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final headers = {
        "Content-Type": "application/json",
        "Authorization": token
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        List<dynamic> data = jsonResponse['data'] ?? [];
        setState(() {
          _imageList = List<Map<String, dynamic>>.from(data);
          _isLoading = false;
        });

        // 开始轮询 `pending` 状态的图片
        for (var image in _imageList) {
          if (image['img_status'] == 'pending') {
            _startPolling(image["id"]);
          }
        }
      } else {
        throw Exception('数据获取失败');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('加载失败: $e')),
      );
    }
  }

  /// 轮询后端，检查 `pending` 状态是否变成 `success`
  void _startPolling(int imgID) {
    if (_pollingTimers.containsKey(imgID)) return; // 避免重复轮询

    _pollingTimers[imgID] = Timer.periodic(const Duration(seconds: 2), (timer) async {
      try {
        final url = Uri.parse(
            "http://10.105.164.201:8000/api/v1/user_management/user_info/user_img_info_list?img_id=$imgID");

        final prefs = await SharedPreferences.getInstance();
        final token = prefs.getString('token') ?? '';

        final headers = {
          "Content-Type": "application/json",
          "Authorization": token
        };

        final response = await http.get(url, headers: headers);

        if (response.statusCode == 200) {
          final jsonResponse = jsonDecode(response.body);
          List<dynamic> data = jsonResponse['data'] ?? [];

          if (data.isNotEmpty) {
            final updatedImage = data.first;
            final String newStatus = updatedImage['img_status'] ?? 'pending';

            setState(() {
              // 更新图片状态
              for (var i = 0; i < _imageList.length; i++) {
                if (_imageList[i]["id"] == imgID) {
                  _imageList[i] = updatedImage;
                  break;
                }
              }
            });

            // 停止轮询，如果状态变为 success
            if (newStatus == 'success') {
              timer.cancel();
              _pollingTimers.remove(imgID);
            }
          }
        }
      } catch (e) {
        print("轮询失败: $e");
      }
    });
  }

  /// 处理点击事件
  void _handleImageTap(String status, int imgID, String taskId) {
    if (status == 'success') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SuccessPage(imgID: imgID)),
      );
    } else if (status == 'pending') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => PendingPage(imgID: imgID, taskId: taskId)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("我的生成结果")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _imageList.isEmpty
              ? const Center(child: Text("暂无生成的图片"))
              : ListView.builder(
                  itemCount: _imageList.length,
                  itemBuilder: (context, index) {
                    final image = _imageList[index];
                    int imgID = image["id"];
                    String imgName = image['img_name'] ?? '未知图片';
                    String imgStatus = image['img_status'] ?? 'pending';
                    String taskId = image['task_id'] ?? '';
                    String? base64Img = image['img_logo'];

                    Uint8List? imgLogo;
                    if (base64Img != null && base64Img.isNotEmpty) {
                      try {
                        imgLogo = base64Decode(base64Img);
                      } catch (e) {
                        imgLogo = null;
                      }
                    }

                    return Card(
                      margin: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: imgStatus == 'pending'
                            ? const SizedBox(
                                width: 60,
                                height: 60,
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : imgLogo != null
                                ? Image.memory(imgLogo,
                                    width: 60, height: 60, fit: BoxFit.cover)
                                : const Icon(Icons.image,
                                    size: 60, color: Colors.grey),
                        title: Text(
                          imgStatus == 'pending' ? "正在生图..." : imgName,
                          style: const TextStyle(fontSize: 16),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios,
                            size: 16, color: Colors.grey),
                        onTap: () => _handleImageTap(imgStatus, imgID, taskId),
                      ),
                    );
                  },
                ),
    );
  }
}
