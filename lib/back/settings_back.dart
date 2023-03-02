// import 'package:darkmode/Home.dart';
// import 'package:material_color_generator/material_color_generator.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'main.dart';
// import 'package:rounded_background_text/rounded_background_text.dart';
//
// enum _HighlightTextType { text }
//
// enum Style { light, dark }
//
// class Settings extends StatefulWidget {
//   const Settings({Key? key}) : super(key: key);
//
//   @override
//   _Settings createState() => _Settings();
// }
//
// class Setting extends StatelessWidget {
//   static final ValueNotifier<ThemeMode> themeNotifier =
//   ValueNotifier(ThemeMode.light);
//
//   Setting({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<ThemeMode>(
//         valueListenable: themeNotifier,
//         builder: (_, ThemeMode currentMode, __) {
//           return MaterialApp(
//             // Remove the debug banner
//             debugShowCheckedModeBanner: false,
//             theme: ThemeData(
//                 primarySwatch: generateMaterialColor(color: Colors.white)),
//             darkTheme: ThemeData.dark(),
//             themeMode: currentMode,
//             home: Setting(),
//           );
//         });
//   }
// }
//
// class _Settings extends State<Settings> {
//   final controller = TextEditingController();
//   final colorsController = ScrollController();
//
//   double innerRadius = kDefaultInnerFactor;
//   double outerRadius = kDefaultOuterFactor;
//
//   TextAlign textAlign = TextAlign.justify;
//   FontWeight fontWeight = FontWeight.bold;
//   _HighlightTextType type = _HighlightTextType.text;
//
//   Color selectedColor = Colors.greenAccent;
//
//   Style _style = Style.light;
//
//   get _radio => null;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//
//     return WillPopScope(
//         onWillPop: () async {
//           return _onBackKey();
//         },
//         child: Scaffold(
//             appBar: AppBar(
//               // backgroundColor: Colors.white,
//               title: Text(
//                 '설정',
//                 style: (isDarkMode
//                     ? const TextStyle(color: Colors.white)
//                     : const TextStyle(color: Colors.black)),
//               ),
//               leading: IconButton(
//                 icon: const Icon(Icons.arrow_back_ios),
//                 color: Colors.grey,
//                 onPressed: () {
//                   Navigator.pop(context);
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => TabPage()),
//                   );
//                 },
//               ),
//               backgroundColor: isDarkMode
//                   ? Colors.black
//                   :Colors.white,
//               centerTitle: true,
//               elevation: 0.3,
//               toolbarHeight: 60,
//             ),
//             body: Container(
//               // color: Colors.white,
//               child: ListView(
//                 padding: const EdgeInsets.all(8),
//                 children: <Widget>[
//                   Container(
//                     height: 50,
//                     margin: const EdgeInsets.fromLTRB(30, 20, 0, 0),
//                     child: Row(
//                       children: [
//                         ImageIcon(
//                           Image.asset('assets/customer_center.png')
//                               .image,
//                           color: Colors.greenAccent,
//                           size: 25,
//                         ),
//                         const Text(
//                           '  고객센터',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 50,
//                     margin: const EdgeInsets.fromLTRB(30, 10, 20, 0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                           onPressed: () {
//                             // Navigator.push(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //         builder: (context) => History()));
//                           },
//                           child: Text('이용약관',
//                               style: (isDarkMode
//                                   ? const TextStyle(
//                                   fontSize: 17, color: Colors.white)
//                                   : const TextStyle(
//                                   fontSize: 17, color: Colors.black))),
//                         ),
//                         Align(
//                           child: Image.asset(
//                             'assets/move.png',
//                             width: 10,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 50,
//                     margin: const EdgeInsets.fromLTRB(30, 0, 20, 0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         TextButton(
//                           onPressed: () {
//                             //   Navigator.push(context, MaterialPageRoute(builder: (context)=> Private())
//                             //   );
//                           },
//                           child: Text(
//                             '개인정보 처리방침',
//                             style: TextStyle(fontSize: 17, color: Colors.black),
//                           ),
//                         ),
//                         Align(
//                           child: Image.asset(
//                             'assets/move.png',
//                             width: 10,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 50,
//                     margin: const EdgeInsets.fromLTRB(30, 0, 20, 0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '이용가이드',
//                           style: TextStyle(fontSize: 17),
//                         ),
//                         Align(
//                           child: Image.asset(
//                             'assets/move.png',
//                             width: 10,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                         border: Border(
//                           bottom: BorderSide(color: Colors.grey.withOpacity(0.3)),
//                         )),
//                   ),
//                   Container(
//                     height: 50,
//                     margin: const EdgeInsets.fromLTRB(30, 40, 0, 0),
//                     child: Row(
//                       children: [
//                         ImageIcon(
//                           Image.asset('assets/app_setting.png').image,
//                           color: Colors.greenAccent,
//                           size: 25,
//                         ),
//                         const Text(
//                           '  앱 설정 및 정보',
//                           style: TextStyle(
//                               fontSize: 20, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 50,
//                     margin: const EdgeInsets.fromLTRB(30, 10, 10, 0),
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.start,
//                         children: <Widget>[
//                           const Text(
//                             '화면스타일',
//                             style: TextStyle(fontSize: 17),
//                           ),
//                           Expanded(
//                             child: Theme(
//                                 data: Theme.of(context).copyWith(
//                                     unselectedWidgetColor:
//                                     const Color.fromRGBO(221, 221, 221, 1),
//                                     disabledColor: Colors.blue),
//                                 child: ListTile(
//                                   contentPadding:
//                                   const EdgeInsets.fromLTRB(22, 0, 0, 0),
//                                   // title: const Text('라이트'),
//                                   title: const Align(
//                                     alignment: Alignment(-12,0),
//                                     child: Text('라이트'),
//                                   ),
//                                   leading: Radio(
//                                     value: Style.light,
//                                     groupValue: _style,
//                                     onChanged: (Style? value) {
//                                       setState(() {
//                                         _style = value!;
//                                         print('lightMode');
//                                         // theme.setLightMode();
//                                         // Get.isDarkMode? Get.changeTheme(ThemeData.light()):Get.changeTheme(ThemeData.dark());
//                                       });
//                                     },
//                                     activeColor:
//                                     const Color.fromRGBO(64, 220, 196, 1),
//                                   ),
//                                 )),
//                           ),
//                           Expanded(
//                             child: Theme(
//                                 data: Theme.of(context).copyWith(
//                                     unselectedWidgetColor:
//                                     const Color.fromRGBO(221, 221, 221, 1),
//                                     disabledColor: Colors.blue),
//                                 child: RadioListTile<Style>(
//                                   contentPadding:
//                                   const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                                   // title: const Text('다크'),
//                                   title: const Align(
//                                     alignment: Alignment(-1.5,0),
//                                     child: Text('다크'),
//                                   ),
//                                   groupValue: _style,
//                                   value: Style.dark,
//                                   onChanged: (Style? value) {
//                                     setState(() {
//                                       print('darkMode');
//                                       _style = Style.dark;
//                                       // Get.isDarkMode
//                                       //     ? Get.changeTheme(ThemeData.light())
//                                       //     : Get.changeTheme(ThemeData.dark());
//                                     });
//                                   },
//                                   activeColor:
//                                   const Color.fromRGBO(64, 220, 196, 1),
//                                 )),
//                           )
//                         ]),
//                   ), //Radio Container End
//                   GestureDetector(
//                     onTap: () {
//                       showDialog(
//                           context: context,
//                           builder: (BuildContext context) {
//                             return Dialog(
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10),
//                                 ),
//                                 child: Container(
//                                   margin: const EdgeInsets.only(
//                                       top: 20, bottom: 20),
//                                   height: 130,
//                                   color: Colors.white,
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.start,
//                                     children: [
//                                       const SizedBox(
//                                         height: 80,
//                                         child: Center(
//                                           child: Text(
//                                             '검색내역을 삭제하시겠습니까?',
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.bold,
//                                                 fontSize: 18),
//                                           ),
//                                         ),
//                                       ),
//                                       Container(
//                                         decoration: BoxDecoration(
//                                             border: Border(
//                                                 top: BorderSide(
//                                                     color: Colors.black
//                                                         .withOpacity(0.1)))),
//                                         child: Row(
//                                           children: [
//                                             SizedBox(
//                                               width: 165.7,
//                                               child: Padding(
//                                                   padding:
//                                                   const EdgeInsets.only(
//                                                       left: 30, top: 1),
//                                                   child: TextButton(
//                                                     onPressed: () {
//                                                       Navigator.pop(context);
//                                                     },
//                                                     child: Text(
//                                                       '취소',
//                                                       style: TextStyle(
//                                                           fontSize: 20,
//                                                           color: Colors.black
//                                                               .withOpacity(
//                                                               0.3)),
//                                                     ),
//                                                   )),
//                                             ),
//                                             SizedBox(
//                                                 width: 165.7,
//                                                 child: Padding(
//                                                   padding:
//                                                   const EdgeInsets.only(
//                                                       top: 1, right: 30),
//                                                   child: TextButton(
//                                                     onPressed: () {
//                                                       print('delete_history');
//                                                     },
//                                                     child: const Text(
//                                                       '삭제',
//                                                       style: TextStyle(
//                                                         fontSize: 20,
//                                                         color: Color.fromRGBO(
//                                                             64, 220, 196, 1),
//                                                       ),
//                                                     ),
//                                                   ),
//                                                 )),
//                                           ],
//                                         ),
//                                       )
//                                     ],
//                                   ),
//                                 ));
//                           });
//                       Container(
//                         height: 200,
//                         color: Colors.white,
//                         child: Column(
//                           children: [
//                             const Center(
//                               child: Text(
//                                 '검색내역을 삭제하시겠습니까?',
//                                 style: TextStyle(fontWeight: FontWeight.bold),
//                               ),
//                             ),
//                             Row(
//                               children: [
//                                 Center(
//                                   child: Text('취소',
//                                       style: TextStyle(
//                                           color:
//                                           Colors.black.withOpacity(0.3))),
//                                 ),
//                                 Center(
//                                     child: TextButton(
//                                       onPressed: () {},
//                                       child: const Text(
//                                         '삭제',
//                                         style: TextStyle(
//                                           color: Color.fromRGBO(64, 220, 196, 1),
//                                         ),
//                                       ),
//                                     ))
//                               ],
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                     child: Container(
//                       height: 50,
//                       margin: const EdgeInsets.fromLTRB(30, 0, 20, 0),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             '검색내역 삭제',
//                             style: TextStyle(fontSize: 17),
//                           ),
//                           Align(
//                             child: Image.asset(
//                               'assets/move.png',
//                               width: 10,
//                             ),
//                           )
//                         ],
//                       ),
//                     ),
//                   ),
//                   Container(
//                     height: 50,
//                     margin: const EdgeInsets.fromLTRB(30, 0, 20, 0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           '임시파일 삭제',
//                           style: TextStyle(fontSize: 17),
//                         ),
//                         Align(
//                           child: Image.asset(
//                             'assets/move.png',
//                             width: 10,
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     height: 32,
//                     margin: const EdgeInsets.fromLTRB(30, 0, 0, 0),
//                     child: Center(
//                         child: Row(
//                           children: [
//                             const Text(
//                               '현재버전 V.1.0.1',
//                               style: TextStyle(fontSize: 17),
//                             ),
//                             Container(
//                               margin: const EdgeInsets.only(left: 150),
//                               padding: const EdgeInsets.only(left: 15, right: 15,bottom: 0),
//                               decoration: BoxDecoration(
//                                   border: Border.all(
//                                       width: 1, color: Colors.greenAccent),
//                                   borderRadius:
//                                   const BorderRadius.all(Radius.circular(10))),
//                               child: Row(
//                                 children: [
//                                       () {
//                                     switch (type) {
//                                       case _HighlightTextType.text:
//                                         return RoundedBackgroundText(
//                                           '업데이트',
//                                           strutStyle: const StrutStyle(
//                                               forceStrutHeight: true, leading: 1),
//                                           // backgroundColor: Colors.white,
//                                           textAlign: textAlign,
//                                           style: const TextStyle(
//                                               fontSize: 13,
//                                               color: Colors.greenAccent),
//                                           innerRadius: kDefaultInnerFactor,
//                                           outerRadius: kDefaultOuterFactor,
//                                         );
//                                     }
//                                   }(),
//                                 ],
//                               ),
//                             )
//                           ],
//                         )),
//                   )
//                 ],
//               ),
//             )));
//   }
//
//   Future<bool> _onBackKey() async {
//     return await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return TabPage();
//         });
//   }
// }
