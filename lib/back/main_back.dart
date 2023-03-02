// import 'dart:io';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:darkmode/vmidc.dart';
// import 'package:device_info_plus/device_info_plus.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:material_color_generator/material_color_generator.dart';
// import 'Chart.dart';
// import 'History.dart';
// import 'Home.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await SystemChrome.setPreferredOrientations([
//     DeviceOrientation.portraitUp,
//     DeviceOrientation.portraitDown
//   ]);
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   // Using "static" so that we can easily access it later
//   static final ValueNotifier<ThemeMode> themeNotifier =
//   ValueNotifier(ThemeMode.light);
//
//   MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<ThemeMode>(
//         valueListenable: themeNotifier,
//         builder: (_, ThemeMode currentMode, __) {
//           return MaterialApp(
//             localizationsDelegates: const [
//               GlobalMaterialLocalizations.delegate,
//               GlobalWidgetsLocalizations.delegate,
//               GlobalCupertinoLocalizations.delegate,
//             ],
//             supportedLocales: const [
//               Locale('en', ''),
//               Locale('ko', ''),
//             ],
//             // Remove the debug banner
//             debugShowCheckedModeBanner: false,
//             navigatorKey: VMIDC.navigatorState,
//             theme: ThemeData(
//                 primarySwatch: generateMaterialColor(color: Colors.white)),
//             darkTheme: ThemeData.dark(),
//             themeMode: currentMode,
//             home: TabPage(),
//           );
//         });
//   }
// }
//
// class TabPage extends StatefulWidget {
//   @override
//   _TabPageState createState() => _TabPageState();
// }
//
// class _TabPageState extends State<TabPage> {
//   int _selectedIndex = 1; // 처음에 나올 화면 지정
//
//   static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//   var deviceData;
//   var _deviceData;
//
//   Future<void> initPlatformState() async {
//     var deviceData;
//     if (Platform.isAndroid) {
//       deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
//     }
//     setState(() {
//       _deviceData = deviceData;
//     });
//   }
//
//   double _readAndroidBuildData(AndroidDeviceInfo build) {
//     return build.displayMetrics.widthPx;
//   }
//
//   final List _pages = [History(), Home(), Chart()];
//
//   @override
//   void initState() {
//     initPlatformState();
//     super.initState();
//   }
//
//   PageController pageController = PageController(
//       initialPage: 1
//   );
//
//   Widget buildPageView() {
//     return PageView(
//       controller: pageController,
//       children: <Widget>[
//         _pages[0],
//         _pages[1],
//         _pages[2],
//       ],
//     );
//   }
//
//   void pageChanged(int index) {
//     setState(() {
//       _selectedIndex = index;
//       pageController.animateToPage(index,
//           duration: const Duration(milliseconds: 500), curve: Curves.ease);
//       pageController.jumpToPage(_selectedIndex);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = MyApp.themeNotifier.value == ThemeMode.dark;
//
//     return WillPopScope(onWillPop: (){
//       if(_selectedIndex == 1 && this.pageController.offset == _deviceData /3) {
//         return _onBackKey();
//       } else {
//         return _backToHome();
//       }
//     },
//         child: Scaffold(
//             body: Center(
//               child: buildPageView(), // 페이지와 연결
//             ),
//             // BottomNavigationBar 위젯
//             bottomNavigationBar: StyleProvider(
//               // style: isDarkMode ? Style_dark() : Style(),
//                 style: MyApp.themeNotifier.value == ThemeMode.dark
//                     ? Style_dark()
//                     : Style(),
//                 child: ConvexAppBar(
//                   // type: BottomNavigationBarType.fixed, // bottomNavigationBar item이 4개 이상일 경우
//                   // 클릭 이벤트
//                   // currentIndex: _selectedIndex, // 현재 선택된 index
//                   // BottomNavigationBarItem 위젯
//                   items: [
//                     TabItem(
//                       icon: Image.asset(
//                         'assets/history.png',
//                       ),
//                       title: '히스토리',
//                     ),
//                     TabItem(
//                       icon: isDarkMode
//                           ? Image.asset('assets/search_dark.png')
//                           : Image.asset('assets/search.png'),
//                     ),
//                     TabItem(
//                       title: '차트',
//                       icon: Image.asset(
//                         'assets/chart.png',
//                         width: 50,
//                       ),
//                     ),
//                   ],
//                   onTap: pageChanged,
//                   height: 70,
//                   initialActiveIndex: _selectedIndex,
//                   style: TabStyle.fixedCircle,
//                   // cornerRadius: 20,
//                   curveSize: 100,
//                   elevation: 1.0,
//                   backgroundColor: isDarkMode ? Colors.black : Colors.white,
//                 ))));
//   }
//
//   /* =======================================================*/
//
//   Future<bool> onBackKey() async {
//     double d_width = MediaQuery.of(context).size.width * 0.5;
//     return await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return Dialog(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(10),
//               ),
//               child: Container(
//                 margin: const EdgeInsets.only(top: 20, bottom: 20),
//                 height: 130,
//                 color: Colors.white,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: 80,
//                       child: Center(
//                         child: Text(
//                           '종료?',
//                           style: TextStyle(
//                               fontWeight: FontWeight.bold, fontSize: 18),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       decoration: BoxDecoration(
//                           border: Border(
//                               top: BorderSide(
//                                   color: Colors.black.withOpacity(0.1)))),
//                       child: Row(
//                         children: [
//                           SizedBox(
//                             width: d_width,
//                             child: Padding(
//                                 padding:
//                                 const EdgeInsets.only(left: 30, top: 1),
//                                 child: TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).pop(true);
//                                     SystemNavigator.pop();
//                                     exit(0);
//                                   },
//                                   child: const Text(
//                                     '종료',
//                                     style: TextStyle(
//                                         fontSize: 20,
//                                         color: Color.fromRGBO(64, 220, 196, 1)),
//                                   ),
//                                 )),
//                           ),
//                           SizedBox(
//                               width: 165.7,
//                               child: Padding(
//                                 padding:
//                                 const EdgeInsets.only(top: 1, right: 30),
//                                 child: TextButton(
//                                   onPressed: () {
//                                     Navigator.pop(context);
//                                   },
//                                   child: Text(
//                                     '취소',
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       color: Colors.black.withOpacity(0.3),
//                                     ),
//                                   ),
//                                 ),
//                               )),
//                         ],
//                       ),
//                     )
//                   ],
//                 ),
//               ));
//         });
//   }
//
// /* ========================================================*/
//
//   void _onItemTapped(int index) {
//     setState(() {
//       _selectedIndex = index; // index는 item 순서로 0, 1, 2로 구성
//     });
//   }
//
//   Future<bool> _backToHome() async {
//     return await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return TabPage();
//         });
//   }
//
//   Future<bool> _onBackKey() async {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     return await showDialog(
//       context: context,
//       barrierDismissible:
//       false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
//       builder: (BuildContext context) {
//         double c_height = MediaQuery.of(context).size.height;
//         double c_width = MediaQuery.of(context).size.width;
//         return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Container(
// // width: 400,
// // height: 150,
//               height: c_height * 0.18,
//               width: c_width * 0.8,
// // margin: const EdgeInsets.only(top: 20, bottom: 20),
//               margin: const EdgeInsets.only(top: 20, bottom: 20),
//               color: isDarkMode
//                   ? const Color.fromRGBO(66, 66, 66, 1)
//                   : Colors.white,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   SizedBox(
// // width: 200,
// // height: 90,
//                     height: c_height * 0.12,
//                     child: const Center(
//                       child: Text(
//                         '종료?',
//                         style: TextStyle(fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border(
//                             top: BorderSide(
//                                 color: isDarkMode
//                                     ? const Color.fromRGBO(94, 94, 94, 1)
//                                     : Colors.black.withOpacity(0.1)))),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         SizedBox(
// // width: 200,
// // height: 78,
//                           width: c_width * 0.4,
//                           height: c_height *0.08,
//                           child: Container(
//                               decoration: BoxDecoration(
//                                   color: isDarkMode
//                                       ? const Color.fromRGBO(66, 66, 66, 1)
//                                       : Colors.white,
//                                   border: Border(
//                                       right: BorderSide(
//                                           color: isDarkMode
//                                               ? const Color.fromRGBO(94, 94, 94, 1)
//                                               : Colors.black.withOpacity(0.1)
//                                       )
//                                   )
//                               ),
//                               margin: const EdgeInsets.only(left: 20),
//                               child: TextButton(
//                                   onPressed: () {
//                                     exit(0);
//                                   },
//                                   child: const Text(
//                                     '종료',
//                                     style: TextStyle(
//                                         fontSize: 20, color: Colors.red),
// // ),
//                                   ))),
//                         ),
//                         Container(
//                             margin: const EdgeInsets.only(right: 20),
//                             color: isDarkMode
//                                 ? const Color.fromRGBO(66, 66, 66, 1)
//                                 : Colors.white,
// // width: 180,
// // height: 78,
//                             width: c_width * 0.345,
//                             height: c_height * 0.08,
//                             child: TextButton(
//                               onPressed: () {
//                                 Navigator.pop(context);
//                               },
//                               child: Text(
//                                 '취소',
//                                 style: TextStyle(
//                                   fontSize: 20,
//                                   color: isDarkMode
//                                       ? Colors.white.withOpacity(0.8)
//                                       : Colors.black.withOpacity(0.3),
//                                 ),
//                               ),
//                             )
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//             ));
//       },
//     );
//   }
// }
//
// class Style_dark extends StyleHook {
//   @override
//   double get activeIconMargin => 10;
//
//   @override
//   double get activeIconSize => 30;
//
//   @override
//   double? get iconSize => 40;
//
//   @override
//   TextStyle textStyle(Color color, String? fontFamily) {
//     return const TextStyle(fontSize: 14, color: Colors.white);
//   }
//
// // @override
// // TextStyle textStyle(Color color) {
// //   return const TextStyle(fontSize: 14, color: Colors.white);
// // }
//
// }
//
// class Style extends StyleHook {
//   @override
//   double get activeIconMargin => 10;
//
//   @override
//   double get activeIconSize => 30;
//
//   @override
//   double? get iconSize => 40;
//
//   @override
//   TextStyle textStyle(Color color, String? fontFamily) {
//     return const TextStyle(fontSize: 14, color: Colors.black);
//   }
//
// }
