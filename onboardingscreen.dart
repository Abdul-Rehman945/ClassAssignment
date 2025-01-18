import 'package:flutter/material.dart';

class OnBoardingScreenCopy extends StatelessWidget {
  OnBoardingScreenCopy({super.key});

  final PageController _pageController = PageController(); // Added PageController
  int changePageIndex = 0;

  final List<Map<String, dynamic>> pageList = [
    {"image": "https://images.unsplash.com/photo-1736264335209-05960b7aa567?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwyfHx8ZW58MHx8fHx8", "pageName": "First Page"},
    {"image": "https://images.unsplash.com/photo-1735287367310-2648443f086f?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxMnx8fGVufDB8fHx8fA%3D%3D", "pageName": "Second Page"},
    {"image": "https://images.unsplash.com/photo-1735669356374-8ea7506cd1d2?w=500&auto=format&fit=crop&q=60&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxmZWF0dXJlZC1waG90b3MtZmVlZHwxMDN8fHxlbnwwfHx8fHw%3D", "pageName": "Third Page"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(150, 58, 69, 73),
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController, // Bind the controller
              onPageChanged: (index) {
                changePageIndex = index;
              },
              reverse: true,
              physics: BouncingScrollPhysics(),
              pageSnapping: true,
              scrollDirection: Axis.vertical,
              itemCount: pageList.length,
              itemBuilder: (context, index) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                           Image.network(
                        pageList[index]["image"], // Load the image from URL
                        width: 250,
                        height: 300,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.error,
                            size: 200,
                            color: Colors.red,
                          ); // Display an error icon on failure
                        },
                      ),
                      SizedBox(height: 20),
                              Text("My ${pageList[index]["pageName"]}"),
                            ],
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Dot(
                          currentIndex: index,
                          pageCount: pageList.length,
                          onDotTapped: (pageIndex) {
                            _pageController.jumpToPage(pageIndex); // Navigate to the tapped page
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class Dot extends StatelessWidget {
  final int currentIndex;
  final int pageCount;
  final Function(int) onDotTapped;

  const Dot({
    super.key,
    required this.currentIndex,
    required this.pageCount,
    required this.onDotTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageCount, (index) {
        return GestureDetector(
          onTap: () => onDotTapped(index), // Handle tap event
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: CircleAvatar(
              backgroundColor: currentIndex == index
                  ? const Color.fromARGB(255, 243, 6, 192)
                  : const Color.fromARGB(255, 247, 209, 253),
              radius: 25,
            ),
          ),
        );
      }),
    );
  }
}
