import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessPage extends StatefulWidget {
  final int imgID;
  const SuccessPage({super.key, required this.imgID});

  @override
  State<SuccessPage> createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  bool _isLoading = true;
  Map<String, dynamic>? _imageData;
  Uint8List? _imageBytes;

  @override
  void initState() {
    super.initState();
    _fetchImageDetails();
  }

  /// 调用后端 API 获取图片详情
  Future<void> _fetchImageDetails() async {
    try {
      final url = Uri.parse(
          "http://10.105.164.201:8000/api/v1/user_management/user_info/user_img_info_list?img_id=${widget.imgID}");

      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';

      final headers = {
        "Content-Type": "application/json",
        "Authorization": token
      };

      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData =
            json.decode(utf8.decode(response.body.runes.toList()));

        if (responseData['result'] == true && responseData['data'].isNotEmpty) {
          setState(() {
            _imageData = responseData['data'][0];
            _imageBytes =
                base64Decode(_imageData!['img_base64']); // 直接解析 Base64
            _isLoading = false;
          });
        } else {
          throw Exception('未找到对应图片数据');
        }
      } else {
        throw Exception('数据获取失败');
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('加载失败: $e')));
    }
  }

  /// 下载图片
  Future<void> _downloadImage() async {
    if (_imageBytes == null) return;

    try {
      // 申请权限
      await _requestPermissions();

      // 处理文件名
      String imgName =
          _sanitizeFileName(_imageData!['img_name'] ?? "downloaded_image.png");

      // 保存到本地相册
      final result = await ImageGallerySaver.saveImage(
        _imageBytes!,
        quality: 100,
        name: imgName,
      );

      if (result == null || !(result['isSuccess'] ?? false)) {
        throw Exception('保存失败');
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('图片已保存到相册')));
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('下载失败: $e')));
    }
  }

  /// 申请权限（适配 Android 版本）
  Future<void> _requestPermissions() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.isDenied) {
        await Permission.storage.request();
      }
      if (await Permission.photos.isDenied) {
        await Permission.photos.request();
      }
      if (await Permission.manageExternalStorage.isDenied) {
        await Permission.manageExternalStorage.request();
      }
    }
  }

  /// 处理文件名，防止特殊字符
  String _sanitizeFileName(String name) {
    return name.replaceAll(RegExp(r'[<>:"/\\|?*]'), '_');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("图片详情")),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _imageData == null
              ? const Center(child: Text("加载失败"))
              : SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // 直接展示 Base64 解码后的图片
                        _imageBytes != null
                            ? Image.memory(_imageBytes!,
                                width: 300, height: 300, fit: BoxFit.contain)
                            : const Icon(Icons.image,
                                size: 120, color: Colors.grey),

                        const SizedBox(height: 10),

                        // 图片信息
                        Text("名称: ${_imageData!['img_name']}",
                            style: const TextStyle(fontWeight: FontWeight.bold)),
                        Text("类型: ${_imageData!['img_type']}"),
                        Text("描述: ${_imageData!['desc']}"),
                        Text("状态: ${_imageData!['img_status']}"),

                        const SizedBox(height: 20),

                        // 下载按钮
                        ElevatedButton.icon(
                          onPressed: _downloadImage,
                          icon: const Icon(Icons.download),
                          label: const Text("下载原图"),
                        ),
                      ],
                    ),
                  ),
                ),
    );
  }
}
