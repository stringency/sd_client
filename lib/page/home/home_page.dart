import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _selectedTagIndex = 0;

  final List<String> _tags = ["中秋节", "七夕", "万圣节", "奥运会", "更多"];

  // Define the new colors for each tag
  final List<Color> _backgroundColors = [
    Color(0xFFF9DBBA), // Light peach for Mid-Autumn
    Color(0xFFB4D6CD), // Light green-blue for Qixi
    Color(0xFFFFD18E), // Light pumpkin color for Halloween
    Color(0xFFCAF4FF), // Light blue for Olympics
    Color(0xFFD3D3D3), // Light grey for "更多"
  ];

  // Define the colors for each button
  final List<Color> _buttonColors = [
    Color(0xFFF1F1F1), // Light grey for Button 1
    Color(0xFFF1F1F1), // Light grey for Button 2
    Color(0xFFF1F1F1), // Light grey for Button 3
    Color(0xFFF1F1F1), // Light grey for Button 4
  ];

  // Define the dark colors for the tag text when selected
  final List<Color> _darkTextColors = [
    Color(0xFF5D4037), // Very dark brown version for Mid-Autumn
    Color(0xFF004D40), // Very dark teal version for Qixi
    Color(0xFFBF360C), // Very dark orange version for Halloween
    Color(0xFF01579B), // Very dark blue version for Olympics
    Color(0xFF424242), // Very dark grey version for "更多"
  ];

  @override
  void initState() {
    super.initState();
    // Automatically transition the slider every 2 seconds
    _startAutoSlide();
  }

  void _startAutoSlide() {
    Future.delayed(const Duration(seconds: 3), () {
      if (_pageController.hasClients) {
        int nextPage = _pageController.page!.round() + 1;
        if (nextPage == 3) {
          nextPage = 0; // Loop back to the first page
        }
        _pageController.animateToPage(
          nextPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        _startAutoSlide(); // Continue the cycle
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color to white
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Top part with PageView for images
                Container(
                  height: screenHeight / 4, // 1/4 of the screen height
                  child: Column(
                    children: [
                      Expanded(
                        child: PageView(
                          controller: _pageController,
                          children: List.generate(3, (index) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/homeimgs/slider/slider-0${index + 1}.png',
                                fit: BoxFit.cover,
                              ),
                            );
                          }),
                        ),
                      ),
                      SizedBox(height: 10), // Added space between the PageView and the indicator
                      SmoothPageIndicator(
                        controller: _pageController,
                        count: 3,
                        effect: WormEffect(
                            dotHeight: 10,
                            dotWidth: 10,
                            dotColor: Colors.grey[300]!,
                            activeDotColor: Colors.teal[700]!),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                // Middle part with buttons
                GridView.count(
                  crossAxisCount: 2, // 2 columns
                  childAspectRatio: 3, // Reduced button height by increasing aspect ratio
                  mainAxisSpacing: 12.0, // Increased space between rows
                  crossAxisSpacing: 12.0, // Increased space between columns
                  padding: EdgeInsets.all(8.0), // Optional padding around the grid
                  shrinkWrap: true, // Use this to make GridView take only necessary space
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling in GridView
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.campaign, color: Colors.grey[800]), // Icon for Task 1
                      label: Text(
                        "快速生成海报",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _buttonColors[0],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Increased corner radius
                        ),
                        shadowColor: Colors.grey.withOpacity(0.5), // Add shadow color
                        elevation: 4, // Add elevation to create shadow
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.share, color: Colors.grey[800]), // Icon for Task 2
                      label: Text(
                        "一键宣传产品",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _buttonColors[1],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Increased corner radius
                        ),
                        shadowColor: Colors.grey.withOpacity(0.5), // Add shadow color
                        elevation: 4, // Add elevation to create shadow
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.explore, color: Colors.grey[800]), // Icon for Task 3
                      label: Text(
                        "探索丰富社区",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _buttonColors[2],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Increased corner radius
                        ),
                        shadowColor: Colors.grey.withOpacity(0.5), // Add shadow color
                        elevation: 4, // Add elevation to create shadow
                      ),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.bookmark, color: Colors.grey[800]), // Icon for Task 4
                      label: Text(
                        "我的主页",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.grey[800]),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _buttonColors[3],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Increased corner radius
                        ),
                        shadowColor: Colors.grey.withOpacity(0.5), // Add shadow color
                        elevation: 4, // Add elevation to create shadow
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // Bottom part (remaining section with tags)
                Wrap(
                  spacing: 10.0,
                  runSpacing: 10.0,
                  alignment: WrapAlignment.center,
                  children: List.generate(_tags.length, (index) {
                    final isSelected = _selectedTagIndex == index;
                    return InkWell(
                      onTap: () {
                        setState(() {
                          _selectedTagIndex = index;
                        });
                      },
                      borderRadius: BorderRadius.circular(12.0), // Smaller corner radius
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        decoration: BoxDecoration(
                          color: isSelected ? _backgroundColors[index] : Colors.transparent,
                          borderRadius: BorderRadius.circular(12.0),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 3,
                                    offset: Offset(0, 2), // changes position of shadow
                                  ),
                                ]
                              : [],
                        ),
                        child: Text(
                          _tags[index],
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal, // Bold only when selected
                            color: isSelected ? _darkTextColors[index] : Colors.grey[600],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                SizedBox(height: 10),
                // Grid of images based on selected tag
                GridView.builder(
                  padding: EdgeInsets.all(10),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 columns
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    childAspectRatio: 1, // Square aspect ratio (1:1)
                  ),
                  shrinkWrap: true, // Ensure GridView takes only the space it needs
                  physics: NeverScrollableScrollPhysics(), // Disable scrolling in GridView
                  itemCount: 8, // Show 8 boxes (4x2)
                  itemBuilder: (context, index) {
                    if (_selectedTagIndex == 0) { // Mid-Autumn tag
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0), // Small rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/homeimgs/mid-autumn/mid-autumn-0${index + 1}.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else if (_selectedTagIndex == 1) { // Qixi tag
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0), // Small rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/homeimgs/qixi/qixi-0${index + 1}.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else if (_selectedTagIndex == 2) { // Halloween tag
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0), // Small rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/homeimgs/halloween/halloween-0${index + 1}.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else if (_selectedTagIndex == 3) { // Olympics tag
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0), // Small rounded corners
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.asset(
                            'assets/images/homeimgs/olym/olym-0${index + 1}.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    } else if (_selectedTagIndex == 4) { // More tag
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "No Images",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "No Images",
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
