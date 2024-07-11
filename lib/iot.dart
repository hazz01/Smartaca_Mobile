import 'package:flutter/material.dart';
import 'package:smartaca_alpha_6/Cahaya.dart';
import 'package:smartaca_alpha_6/home_page.dart';
import 'package:smartaca_alpha_6/main.dart';
import 'package:smartaca_alpha_6/temperature.dart';
import 'package:smartaca_alpha_6/vitamin.dart';
import 'package:smartaca_alpha_6/waterdischarge.dart';

class IoTDashboard extends StatefulWidget {
  const IoTDashboard({super.key});

  @override
  State<IoTDashboard> createState() => _IoTDashboardState();
}

class _IoTDashboardState extends State<IoTDashboard> {
  int currentPage = 1;
  final PageController _pageController = PageController(initialPage: 1);

  List<Widget> pages = const [
    Temperature(),
    WaterDischarge(),
    Vitamin(),
    Cahaya(),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: onPageChanged,
              children: pages,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(0);
                },
                child: Icon(
                  Icons.circle,
                  color: currentPage == 0 ? Colors.green : Colors.black38,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(1);
                },
                child: Icon(
                  Icons.circle,
                  color: currentPage == 1 ? Colors.green : Colors.black38,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(2);
                },
                child: Icon(
                  Icons.circle,
                  color: currentPage == 2 ? Colors.green : Colors.black38,
                ),
              ),
              const SizedBox(width: 10),
              GestureDetector(
                onTap: () {
                  _pageController.jumpToPage(3);
                },
                child: Icon(
                  Icons.circle,
                  color: currentPage == 3 ? Colors.green : Colors.black38,
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBarRaisedInsetFb1(
        currentPage: currentPage,
        onPageChanged: (index) {
          _pageController.jumpToPage(index);
          onPageChanged(index);
        },
      ),
    );
  }
}
