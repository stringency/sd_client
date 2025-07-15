import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sd_client/page/mine/result/success_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PendingPage extends StatefulWidget {
  final String taskId;
  final int imgID;

  const PendingPage({super.key, required this.taskId, required this.imgID});

  @override
  State<PendingPage> createState() => _PendingPageState();
}

class _PendingPageState extends State<PendingPage> {
  bool isLoading = true;
  double progress = 0.0;
  double etaRelative = 0.0;
  int jobNo = 0;
  int jobCount = 0;
  String job = '';
  String currentImage = '';
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    checkStatus();
  }

  @override
  void dispose() {
    isLoading = false;  // 终止轮询
    _timer?.cancel();
    super.dispose();
  }

  Future<void> checkStatus() async {
    final statusUrl = Uri.parse(
        "http://10.105.164.201:8000/api/v1/taskinfo/?task_id=${widget.taskId}");

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final headers = {
      "Content-Type": "application/json",
      "Authorization": token
    };

    while (isLoading) {
      try {
        if (!mounted) return; // 确保页面未被销毁
        final response = await http.get(statusUrl, headers: headers);
        if (response.statusCode == 202) {
          checkProgress();
        } else if (response.statusCode == 200) {
          if (!mounted) return; // 确保页面未被销毁
          // **跳转前终止循环**
          isLoading = false;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => SuccessPage(imgID: widget.imgID)),
          );
          return;
        } else {
          print("Error checking status: $response.statusCode");
          if (!mounted) return; // 确保页面未被销毁
          setState(() {
            isLoading = false;
          });
        }
      } catch (e) {
        print("Error checking status: $e");
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }

  Future<void> checkProgress() async {
    final progressUrl =
        Uri.parse("http://10.105.164.201:8000/api/v1/imgprogress");

    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    final headers = {"Authorization": token};
    try {
      final response = await http.get(progressUrl, headers: headers);
      if (response.statusCode == 200) {
        final progressData = jsonDecode(response.body);
        setState(() {
          progress = progressData['progress'] ?? 0.0;
          etaRelative = progressData['eta_relative'] ?? 0.0;
          job = progressData['state']['job'] ?? '';
          jobNo = progressData['state']['job_no'] + 1;
          jobCount = progressData['state']['job_count'];
          currentImage = progressData['current_image'] ?? '';
        });
      }
    } catch (e) {
      print("Error checking progress: $e");
    }
  }

  Widget buildImage(String base64Image) {
    return Image.memory(
      base64Decode(base64Image),
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("任务进度")),
      body: Center(
        child: isLoading
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 10),
                  currentImage.isNotEmpty
                      ? Container(
                          height: 145.0,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: buildImage(currentImage),
                          ),
                        )
                      : Container(height: 145.0),
                  SizedBox(height: 10),
                  CircularProgressIndicator(value: progress),
                  SizedBox(height: 10),
                  Text("进度: ${(progress * 100).toStringAsFixed(2)}%"),
                  SizedBox(height: 5),
                  Text("当前生成第 $jobNo / $jobCount 张图片"),
                  SizedBox(height: 5),
                  Text("预计剩余时间: ${etaRelative.toStringAsFixed(2)} 秒"),
                  SizedBox(height: 5),
                  Text("任务: $job"),
                ],
              )
            : Text("加载完成"),
      ),
    );
  }
}
