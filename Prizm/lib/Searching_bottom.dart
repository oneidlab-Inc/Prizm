import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:Prizm/Home_NotFound.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Chart.dart';
import 'History.dart';
import 'Home.dart';
import 'main.dart';

class Notfound_Bottom extends StatefulWidget{
  @override
  _BottomState createState() => _BottomState();
}

class _BottomState extends State<Notfound_Bottom> {
  int _selectedIndex = 1;
  final List _pages = [History(), NotFound(), Chart()];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    SystemChrome.setEnabledSystemUIMode(    // 상단 상태바 제거
        SystemUiMode.manual,
        overlays: [
          SystemUiOverlay.bottom
        ]
    );
    SystemChrome.setEnabledSystemUIMode(    // 상단 상태바 제거
        SystemUiMode.manual,
        overlays: [
          SystemUiOverlay.top
        ]
    );
    return Scaffold(
      body: Center(
        child: _pages[_selectedIndex],
      ),
      bottomNavigationBar: StyleProvider(
        style: isDarkMode ? Style_dark() : Style(),
        child: ConvexAppBar(
          items: [
            TabItem(icon: Image.asset('assets/history.png'), title: '히스토리'),
            TabItem(icon: isDarkMode
                ?Image.asset('assets/search_dark.png')
                :Image.asset('assets/search.png')
            ),
            TabItem(icon: Image.asset('assets/chart.png'), title: '차트')
          ],
          onTap: _onItemTapped,
          height: 70,
          initialActiveIndex: null,
          style: TabStyle.fixedCircle,
          elevation: 1,
          backgroundColor: isDarkMode ? Colors.black : Colors.white,
        ),
      ),
    );
  }
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}