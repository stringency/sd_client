import 'package:flutter/material.dart';
import 'dart:math';

class CommunityPage extends StatefulWidget {
  const CommunityPage({super.key});

  @override
  State<CommunityPage> createState() => _CommunityPageState();
}

class _CommunityPageState extends State<CommunityPage> {
  final Random _random = Random();

  // Example data list to populate the grid
  final List<Map<String, dynamic>> _items = [];

  @override
  void initState() {
    super.initState();
    _initializeItems();
  }

  void _initializeItems() {
    // Titles for each item
    final titles = [
      '电影海报',
      '泡泡名单',
      '机甲背身',
      '黑色背包产品图',
      '未来生活',
      'DJ Set',
      '石王',
      '芭比日',
      '梅果自由',
      '曲奇曲奇',
      '清凉一夏',
      'HORROR HARE',
      '篮球 FUN',
      '球鞋渲染',
      '在游戏',
    ];

    for (int index = 0; index < titles.length; index++) {
      _items.add({
        'image': '../../assets/images/communityimgs/com${(index + 1).toString().padLeft(2, '0')}.png', // Image path
        'title': titles[index],
        'likes': _random.nextInt(31), // Random like count (0-30)
        'comments': _random.nextInt(31), // Random comment count (0-30)
        'isLiked': false, // Initial like state
      });
    }
  }

  void _onLikeTapped(int index) {
    setState(() {
      _items[index]['likes'] += 1;
      _items[index]['isLiked'] = !_items[index]['isLiked'];
    });
  }

  void _onCommentTapped(int index) {
    // Implement comment action here
    print("Comment tapped on item $index");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, // Two items per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 5 / 10, // Aspect ratio for each item (5:10)
        ),
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return _buildGridCard(index);
        },
      ),
    );
  }

  Widget _buildGridCard(int index) {
    final item = _items[index];
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3), // Changes position of shadow
          ),
        ],
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                item['image'], // Image path placeholder
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item['title'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      InkWell(
                        onTap: () => _onLikeTapped(index),
                        borderRadius: BorderRadius.circular(50),
                        child: AnimatedScale(
                          scale: item['isLiked'] ? 1.1 : 1.0, // Smaller scale effect
                          duration: const Duration(milliseconds: 200),
                          child: Row(
                            children: [
                              Icon(
                                Icons.thumb_up,
                                size: 12, // Smaller icon size
                                color: item['isLiked'] ? Colors.blue : Colors.black,
                              ),
                              const SizedBox(width: 5),
                              AnimatedOpacity(
                                opacity: item['isLiked'] ? 1.0 : 0.7,
                                duration: const Duration(milliseconds: 200),
                                child: Text('${item['likes']}'),
                              ),
                            ],
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => _onCommentTapped(index),
                        borderRadius: BorderRadius.circular(50),
                        child: Row(
                          children: [
                            const Icon(Icons.comment, size: 16), // Comment icon remains unchanged
                            const SizedBox(width: 5),
                            Text('${item['comments']}'),
                          ],
                        ),
                      ),
                    ],
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
