import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Txt2ImgsResultTmp extends StatefulWidget {
  final Map<String, dynamic> txt2ImgsParams;

  Txt2ImgsResultTmp({
    super.key,
    required this.txt2ImgsParams,
  });

  @override
  _Txt2ImgsResultTmpState createState() => _Txt2ImgsResultTmpState();
}

class _Txt2ImgsResultTmpState extends State<Txt2ImgsResultTmp> {
  List<String> images = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    generateImages();
  }

  Future<void> generateImages() async {
    final url = Uri.parse('http://192.168.123.17:7860/sdapi/v1/txt2img');
    final headers = {"Content-Type": "application/json"};
    final body = jsonEncode(widget.txt2ImgsParams);
    print(body);

    try {
      final response = await http.post(url, headers: headers, body: body);
      print(response.statusCode);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        setState(() {
          images = List<String>.from(responseData['images']);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to generate images');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // Handle error
      print(e);
    }
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
                  Column(
                    children: images
                        .map((base64Image) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: buildImage(base64Image),
                            ))
                        .toList(),
                  ),
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
