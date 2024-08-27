import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Txt2ImgsResultTmp2 extends StatefulWidget {
  final Map<String, dynamic> txt2ImgsParams;

  Txt2ImgsResultTmp2({
    super.key,
    required this.txt2ImgsParams,
  });

  @override
  _Txt2ImgsResultTmp2State createState() => _Txt2ImgsResultTmp2State();
}

class _Txt2ImgsResultTmp2State extends State<Txt2ImgsResultTmp2> {
  // String sdurl = "http://10.0.2.2:8000/api/1.0/txt2imgTMP/";
  List<String> images = [];
  String imagePath = "assets/images/sceneimgs/txt11.png";
  String imagePath2 = "assets/images/sceneimgs/txt13res.png";
  bool isLoading = true;
  double progress = 0.0;
  int jobNo = 0;
  int jobCount = 0;
  double etaRelative = 0.0;
  String currentImage = '';
  String job = '';

  @override
  void initState() {
    super.initState();
    generateImages();
    checkProgress();
  }

  Future<void> generateImages() async {
    // final url = Uri.parse("http://10.0.2.2:7860/sdapi/v1/txt2img");
    // final url = Uri.parse(sdurl);

    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode(widget.txt2ImgsParams);

    try {
      await Future.delayed(Duration(seconds: 10));
      // final response1 = await http.post(url, headers: headers, body: body);
      // print("r1:${response1.body}");
      // final response = await http.post(url, headers: headers, body: body);
      // print("r2:${response2.body}");

      if (1 == 1) {
        // final responseData = jsonDecode(response.body);
        setState(() {
          // images = List<String>.from(responseData['images']);
          imagePath = "";
          isLoading = false;
        });
      } else {
        throw Exception('Failed to generate images');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showErrorAndGoBack(e.toString());
    }
  }

  Future<void> checkProgress() async {
    // final progressUrl = Uri.parse(
    //   // "http://10.0.2.2:7860/sdapi/v1/progress?skip_current_image=false",
    //   sdurl,
    // );
    while (isLoading) {
      try {
        // final response = await http.get(progressUrl);

        if (1 == 1) {
          // final progressData = jsonDecode(response.body);
          setState(() {
            // progress = progressData['progress'];
            // etaRelative = progressData['eta_relative'];
            // job = progressData['state']['job'];
            // jobNo = progressData['state']['job_no'] + 1;
            // jobCount = progressData['state']['job_count'];
            // currentImage = progressData['current_image'] ?? '';
          });
        }
      } catch (e) {
        print(e);
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }

  void showErrorAndGoBack(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text("连接错误!\n错误信息:$message"),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop(); // 回到上一个界面
              },
            ),
          ],
        );
      },
    );
  }

  Widget buildImage(String base64Image) {
    return Image.memory(
      base64Decode(base64Image),
      fit: BoxFit.cover,
    );
  }

  Widget buildParamsTable(Map<String, dynamic> params) {
    List<TableRow> rows = [];
    params.forEach((key, value) {
      rows.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                key,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(value.toString()),
            ),
          ],
        ),
      );
    });

    return Table(
      border: TableBorder.all(),
      columnWidths: const <int, TableColumnWidth>{
        0: FixedColumnWidth(150.0),
        1: FlexColumnWidth(),
      },
      children: rows,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("生成结果"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "生成图片:",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),

                  // String imagePath1 = "assets/images/sceneimgs/txt11.png";
                  // String imagePath2 = "assets/images/sceneimgs/txt12res.png";
                  // String imagePath3 = "assets/images/sceneimgs/txt13res.png";
                  Image.asset("assets/images/sceneimgs/txt13res.png", width: 340),

                  SizedBox(height: 20),
                  Text(
                    "生成参数:",
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  buildParamsTable(widget.txt2ImgsParams),
                ],
              ),
            ),
    );
  }
}
