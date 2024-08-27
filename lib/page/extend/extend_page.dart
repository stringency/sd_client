import 'package:flutter/material.dart';
import 'package:sd_client/page/extend/anything_txt2imgs/anything_txt2imgs.dart';

class ExtendPage extends StatefulWidget {
  const ExtendPage({super.key});

  @override
  State<ExtendPage> createState() => _ExtendPageState();
}

class _ExtendPageState extends State<ExtendPage> {
  final List<Map<String, dynamic>> _plugins = [
    {
      'image': 'assets/images/pluginimgs/plugin01.png',
      'title': '一键扩图',
      'rating': 4.9,
      'reviews': '99', // Adjusted to a realistic number (1-99)
      'description': '使用AI轻松扩展您的图片，让创意无限延伸。',
    },
    {
      'image': 'assets/images/pluginimgs/plugin02.png',
      'title': '动态图片',
      'rating': 4.7,
      'reviews': '85', // Adjusted to a realistic number (1-99)
      'description': '创建生动的动态图片，为您的内容增添活力。',
    },
    {
      'image': 'assets/images/pluginimgs/plugin03.png',
      'title': '万能生图',
      'rating': 4.8,
      'reviews': '76', // Adjusted to a realistic number (1-99)
      'description': '通过AI技术，轻松修图，让照片更完美。',
    },
    {
      'image': 'assets/images/pluginimgs/plugin04.png',
      'title': 'GPT 辅助',
      'rating': 4.6,
      'reviews': '34', // Adjusted to a realistic number (1-99)
      'description': '借助GPT技术提升工作效率，智能辅助您的日常任务。',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 cards per row
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6, // Aspect ratio to make the cards square
          ),
          itemCount: _plugins.length,
          itemBuilder: (context, index) {
            final plugin = _plugins[index];
            return _buildPluginCard(plugin);
          },
        ),
      ),
    );
  }

  Widget _buildPluginCard(Map<String, dynamic> plugin) {
    return InkWell(
      onTap: () {
        // Handle card tap action
        print('Tapped on ${plugin['title']}');
        if (plugin['title'] == '万能生图') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) {
              return AnythingTxt2Imgs(
                selectedScene: "文生图",
                selectedStyle: ["万能版"],
              );
            }),
          );
        }
      },
      borderRadius: BorderRadius.circular(15.0),
      child: Card(
        color: Color(0xFFF6F5F2), // Set the card's surface color to F6F5F2
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 6, // Increased elevation for more shadow
        shadowColor: Colors.grey.withOpacity(0.7), // Darker shadow color
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  plugin['image'],
                  height: 150, // Increased height to elongate the image
                  width: double.infinity, // Keep width unchanged
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                plugin['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14, // Slightly reduced font size for better fit
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    '${plugin['rating']}',
                    style: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Icon(
                    Icons.star,
                    color: Colors.amber,
                    size: 14, // Reduced icon size
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '(${plugin['reviews']})',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12, // Reduced font size for reviews
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                plugin['description'],
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12, // Reduced font size for description
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
