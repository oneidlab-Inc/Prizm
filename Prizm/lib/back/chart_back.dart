// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'Home.dart';
// import 'Search_Result.dart';
// import 'Settings.dart';
// import 'PlayInfo.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import 'main.dart';
//
// class Chart extends StatefulWidget {
//   @override
//   _Chart createState() => _Chart();
// }
//
// class _Chart extends State<Chart> {
//   List persons = [];
//   List original = [];
//
//   void fetchData() async {
//     try {
//       http.Response response = await http.get(Uri.parse(
//           'https://gist.githubusercontent.com/taewon1009/09c353e5cf2306e1af6f581a645b8f0c/raw/dc9dbd1f07fb33b6c27499c55a0d1ba6434fa199/test.json'));
//       String jsonData = response.body;
//       persons = jsonDecode(jsonData.toString());
//       if (response.statusCode != 200) {
//         print('status Code : $response.statusCode');
//       }
//       print(persons);
//
//       original = persons;
//       setState(() {});
//     } catch (e) {
//       print('json 가져오기 실패');
//     }
//   }
//
//   final duplicateItems =
//   List<String>.generate(1000, (i) => "$Container(child:Text $i)");
//   var items = <String>[];
//
//   @override
//   void initState() {
//     items.addAll(duplicateItems);
//     fetchData();
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
//     int len = persons.length;
//     return WillPopScope(
//         onWillPop: () async {
//           return _onBackKey();
//         },
//         child: Scaffold(
//             appBar: AppBar(
//               // shape: const Border(
//               //     bottom: BorderSide(color: Color.fromRGBO(237, 237, 237, 1))
//               // ),
//               elevation: 0.0,
//               title: Text(
//                 '차트',
//                 style: (isDarkMode
//                     ? const TextStyle(color: Colors.white)
//                     : const TextStyle(color: Colors.black)),
//               ),
//               centerTitle: true,
//               toolbarHeight: 60,
//               // backgroundColor: Colors.white,
//               backgroundColor: isDarkMode ? Colors.black : Colors.white,
//               actions: [
//                 IconButton(
//                   icon: ImageIcon(
//                     Image.asset('assets/settings.png').image,
//                   ),
//                   color: Colors.black,
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => Settings()),
//                     );
//                   },
//                 )
//               ],
//             ),
//             body: Container(
//               color: isDarkMode ? Colors.black : Colors.white,
//               width: MediaQuery.of(context).size.width * 1,
//               child: Column(
//                 mainAxisSize: MainAxisSize.max,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     color: isDarkMode ? Colors.black : Colors.white,
//                     margin: const EdgeInsets.all(20),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Container(
//                             padding: const EdgeInsets.only(bottom: 20),
//                             child: Row(
//                               children: const [
//                                 Text(
//                                   '프리즘 방송 차트 ',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20),
//                                 ),
//                               ],
//                             )),
//                       ],
//                     ),
//                   ),
//                   _listView(persons)
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
//
// Widget _listView(persons) {
//   return Expanded(
//       child: ListView.builder(
//           itemCount: persons == null ? 0 : persons.length,
//           itemBuilder: (context, index) {
//             double c_width = MediaQuery.of(context).size.width * 0.4;
//             final person = persons[index];
//             final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//             return GestureDetector(
//                 child: Container(
//                   padding: const EdgeInsets.only(top: 10, bottom: 10),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         width: 120,
//                         child: Image.asset(
//                           person['image'],
//                           width: 80,
//                           height: 80,
//                           fit: BoxFit.contain,
//                         ),
//                       ),
//                       Flexible(
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             SizedBox(
//                               width: MediaQuery.of(context).size.width * 0.5,
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 mainAxisAlignment: MainAxisAlignment.start,
//                                 children: [
//                                   Text(
//                                     person['title'],
//                                     style: const TextStyle(
//                                       overflow: TextOverflow.ellipsis,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 15,
//                                     ),
//                                   ),
//                                   Padding(
//                                     padding: const EdgeInsets.only(top: 10),
//                                     child: Text(
//                                       person['artist'] +
//                                           ' · ' +
//                                           person['album'],
//                                       style: TextStyle(
//                                           color: isDarkMode
//                                               ? Colors.grey.withOpacity(0.8)
//                                               : Colors.black.withOpacity(0.3),
//                                           overflow: TextOverflow.ellipsis),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                             IconButton(
//                               icon: const Icon(Icons.more_vert_sharp, size: 30),
//                               color: Colors.grey,
//                               onPressed: () {
//                                 showModalBottomSheet(
//                                     context: context,
//                                     builder: (BuildContext context) {
//                                       var person = persons[index];
//                                       // return _modal(persons);
//                                       return SizedBox(
//                                           height: 180,
//                                           child: ListView.builder(
//                                               itemCount: 1,
//                                               // itemCount: persons.length,
//                                               itemBuilder: (context, index) {
//                                                 double c_width =
//                                                     MediaQuery.of(context)
//                                                         .size
//                                                         .width *
//                                                         0.5;
//                                                 final isDarkMode =
//                                                     Theme.of(context)
//                                                         .brightness ==
//                                                         Brightness.dark;
//                                                 return Container(
//                                                   color: isDarkMode
//                                                       ? Colors.black
//                                                       : Colors.white,
//                                                   // height: 80,
//                                                   child: Column(
//                                                       crossAxisAlignment:
//                                                       CrossAxisAlignment
//                                                           .start,
//                                                       children: [
//                                                         Container(
//                                                           color: isDarkMode
//                                                               ? const Color
//                                                               .fromRGBO(
//                                                               36, 36, 36, 1)
//                                                               : const Color
//                                                               .fromRGBO(
//                                                               250,
//                                                               250,
//                                                               250,
//                                                               2),
//                                                           padding:
//                                                           const EdgeInsets
//                                                               .fromLTRB(
//                                                               20,
//                                                               20,
//                                                               20,
//                                                               20),
//                                                           child: Column(
//                                                             children: [
//                                                               Row(
//                                                                 children: [
//                                                                   Image.asset(
//                                                                     person[
//                                                                     'image'],
//                                                                     width: 70,
//                                                                   ),
//                                                                   Flexible(
//                                                                       child: Row(
//                                                                           mainAxisAlignment:
//                                                                           MainAxisAlignment.spaceBetween,
//                                                                           children: [
//                                                                             SizedBox(
//                                                                               width:
//                                                                               c_width,
//                                                                               child:
//                                                                               Column(
//                                                                                 crossAxisAlignment:
//                                                                                 CrossAxisAlignment.start,
//                                                                                 children: [
//                                                                                   Padding(
//                                                                                     padding: const EdgeInsets.only(left: 20),
//                                                                                     child: Text(
//                                                                                       person['title'],
//                                                                                       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                                                                                     ),
//                                                                                   ),
//                                                                                   Padding(
//                                                                                     // padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
//                                                                                     padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
//                                                                                     child: Text(
//                                                                                       person['artist'],
//                                                                                       style: TextStyle(color: isDarkMode ? Colors.grey.withOpacity(0.8) : Colors.black.withOpacity(0.2)),
//                                                                                     ),
//                                                                                   ),
//                                                                                 ],
//                                                                               ),
//                                                                             ),
//                                                                             IconButton(
//                                                                               // padding:
//                                                                               // const EdgeInsets.only(bottom: 50),
//                                                                                 icon:
//                                                                                 ImageIcon(Image.asset('assets/x_icon.png').image, size: 20),
//                                                                                 color: Colors.grey,
//                                                                                 onPressed: () {
//                                                                                   Navigator.pop(context);
//                                                                                 })
//                                                                           ])),
//                                                                 ],
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         ),
//                                                         Container(
//                                                           padding:
//                                                           const EdgeInsets
//                                                               .all(20),
//                                                           color: isDarkMode
//                                                               ? Colors.black
//                                                               : Colors.white,
//                                                           child: Column(
//                                                             children: [
//                                                               GestureDetector(
//                                                                 onTap: () {
//                                                                   Navigator.push(
//                                                                       context,
//                                                                       MaterialPageRoute(
//                                                                           builder: (context) =>
//                                                                               PlayInfo()));
//                                                                 },
//                                                                 child: Row(
//                                                                   children: [
//                                                                     IconButton(
//                                                                       padding: const EdgeInsets
//                                                                           .only(right: 20),
//                                                                       icon: ImageIcon(
//                                                                           Image.asset('assets/list.png')
//                                                                               .image,
//                                                                           size:
//                                                                           20),
//                                                                       color: const Color
//                                                                           .fromRGBO(
//                                                                           64,
//                                                                           220,
//                                                                           196,
//                                                                           1),
//                                                                       onPressed:
//                                                                           () {
//                                                                         Navigator.push(
//                                                                             context,
//                                                                             MaterialPageRoute(builder: (context) => PlayInfo()));
//                                                                       },
//                                                                     ),
//                                                                     const Text(
//                                                                       '프리즘 방송 재생정보',
//                                                                       style: TextStyle(
//                                                                           fontSize:
//                                                                           15,
//                                                                           fontWeight:
//                                                                           FontWeight.w300),
//                                                                     )
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                             ],
//                                                           ),
//                                                         )
//                                                       ]),
//                                                 );
//                                               }));
//                                     });
//                               },
//                             )
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 onTap: () {
//                   showModalBottomSheet(
//                       context: context,
//                       builder: (BuildContext context) {
//                         var person = persons[index];
//                         // return _modal(persons);
//                         return SizedBox(
//                             height: 180,
//                             child: ListView.builder(
//                                 itemCount: 1,
//                                 // itemCount: persons.length,
//                                 itemBuilder: (context, index) {
//                                   double c_width =
//                                       MediaQuery.of(context).size.width * 0.5;
//                                   final isDarkMode =
//                                       Theme.of(context).brightness ==
//                                           Brightness.dark;
//                                   return Container(
//                                     color: isDarkMode
//                                         ? Colors.black
//                                         : Colors.white,
//                                     // height: 80,
//                                     child: Column(
//                                         crossAxisAlignment:
//                                         CrossAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             color: isDarkMode
//                                                 ? const Color.fromRGBO(
//                                                 36, 36, 36, 1)
//                                                 : const Color.fromRGBO(
//                                                 250, 250, 250, 2),
//                                             padding: const EdgeInsets.fromLTRB(
//                                                 20, 20, 20, 20),
//                                             child: Column(
//                                               children: [
//                                                 Row(
//                                                   children: [
//                                                     Image.asset(
//                                                       person['image'],
//                                                       width: 70,
//                                                     ),
//                                                     Flexible(
//                                                         child: Row(
//                                                             mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .spaceBetween,
//                                                             children: [
//                                                               SizedBox(
//                                                                 width: c_width,
//                                                                 child: Column(
//                                                                   crossAxisAlignment:
//                                                                   CrossAxisAlignment
//                                                                       .start,
//                                                                   children: [
//                                                                     Padding(
//                                                                       padding: const EdgeInsets
//                                                                           .only(
//                                                                           left: 20),
//                                                                       child: Text(
//                                                                         person[
//                                                                         'title'],
//                                                                         style: const TextStyle(
//                                                                             fontWeight:
//                                                                             FontWeight
//                                                                                 .bold,
//                                                                             fontSize:
//                                                                             20),
//                                                                       ),
//                                                                     ),
//                                                                     Padding(
//                                                                       // padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
//                                                                       padding:
//                                                                       const EdgeInsets
//                                                                           .fromLTRB(
//                                                                           20,
//                                                                           0,
//                                                                           0,
//                                                                           0),
//                                                                       child: Text(
//                                                                         person[
//                                                                         'artist'],
//                                                                         style: TextStyle(
//                                                                             color: isDarkMode
//                                                                                 ? Colors.grey.withOpacity(0.8)
//                                                                                 : Colors.black.withOpacity(0.2)),
//                                                                       ),
//                                                                     ),
//                                                                   ],
//                                                                 ),
//                                                               ),
//                                                               IconButton(
//                                                                 // padding:
//                                                                 // const EdgeInsets.only(bottom: 50),
//                                                                   icon: ImageIcon(
//                                                                       Image.asset(
//                                                                           'assets/x_icon.png')
//                                                                           .image,
//                                                                       size: 20),
//                                                                   color:
//                                                                   Colors.grey,
//                                                                   onPressed: () {
//                                                                     Navigator.pop(
//                                                                         context);
//                                                                   })
//                                                             ])),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ),
//                                           Container(
//                                             padding: const EdgeInsets.all(20),
//                                             color: isDarkMode
//                                                 ? Colors.black
//                                                 : Colors.white,
//                                             child: Column(
//                                               children: [
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                             builder: (context) =>
//                                                                 PlayInfo()));
//                                                   },
//                                                   child: Row(
//                                                     children: [
//                                                       IconButton(
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .only(right: 20),
//                                                         icon: ImageIcon(
//                                                             Image.asset(
//                                                                 'assets/list.png')
//                                                                 .image,
//                                                             size: 20),
//                                                         color: const Color
//                                                             .fromRGBO(
//                                                             64, 220, 196, 1),
//                                                         onPressed: () {
//                                                           Navigator.push(
//                                                               context,
//                                                               MaterialPageRoute(
//                                                                   builder:
//                                                                       (context) =>
//                                                                       PlayInfo()));
//                                                         },
//                                                       ),
//                                                       const Text(
//                                                         '프리즘 방송 재생정보',
//                                                         style: TextStyle(
//                                                             fontSize: 15,
//                                                             fontWeight:
//                                                             FontWeight
//                                                                 .w300),
//                                                       )
//                                                     ],
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           )
//                                         ]),
//                                   );
//                                 }));
//                       });
//                 });
//           }));
// }
//
// /*Widget _modal(persons) {
//   return SizedBox(
//       height: 200,
//       child: ListView.builder(
//           itemCount: 1,
//           // itemCount: persons.length,
//           itemBuilder: (context, index) {
//             var person = persons[index];
//             double c_width =
//                 MediaQuery.of(context)
//                     .size
//                     .width *
//                     0.5;
//             final isDarkMode =
//                 Theme.of(context)
//                     .brightness ==
//                     Brightness.dark;
//             return SizedBox(
//               height: 200,
//               child: Column(
//                   crossAxisAlignment:
//                   CrossAxisAlignment
//                       .start,
//                   children: [
//                     Container(
//                       padding:
//                       const EdgeInsets
//                           .all(20),
//                       // color: const Color.fromRGBO(250, 250, 250, 2),
//                       child: Column(
//                         children: [
//                           Row(
//                             children: [
//                               Image.asset(
//                                 person[
//                                 'image'],
//                                 width: 100,
//                               ),
//                               Flexible(
//                                   child: Row(
//                                       mainAxisAlignment:
//                                       MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         SizedBox(
//                                           width:
//                                           c_width,
//                                           child:
//                                           Column(
//                                             crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                             children: [
//                                               Padding(
//                                                 padding: const EdgeInsets.only(left: 20),
//                                                 child: Text(
//                                                   person['title'],
//                                                   style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                                                 ),
//                                               ),
//                                               Padding(
//                                                 padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
//                                                 child: Text(
//                                                   person['artist'],
//                                                   style: TextStyle(color: isDarkMode ? Colors.grey.withOpacity(0.8) : Colors.black.withOpacity(0.2)),
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         IconButton(
//                                             padding: const EdgeInsets.only(
//                                                 bottom:
//                                                 50),
//                                             icon: ImageIcon(Image.asset('assets/x_icon.png').image,
//                                                 size:
//                                                 20),
//                                             color: Colors
//                                                 .grey,
//                                             onPressed:
//                                                 () {
//                                               Navigator.pop(context);
//                                             })
//                                       ])),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       height: 156,
//                       padding:
//                       const EdgeInsets
//                           .all(20),
//                       child: Column(
//                         children: [
//                           GestureDetector(
//                               onTap: () {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (context) =>
//                                             PlayInfo()));
//                               },
//                               child: Column(
//                                   children: [
//                                     Row(
//                                       children: [
//                                         IconButton(
//                                           padding:
//                                           const EdgeInsets.only(right: 30),
//                                           icon:
//                                           ImageIcon(Image.asset('assets/list.png').image, size: 40),
//                                           color: const Color.fromRGBO(
//                                               64,
//                                               220,
//                                               196,
//                                               1),
//                                           onPressed:
//                                               () {
//                                             Navigator.push(context, MaterialPageRoute(builder: (context) => PlayInfo()));
//                                           },
//                                         ),
//                                         const Text(
//                                           '프리즘 방송 재생정보',
//                                           style:
//                                           TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
//                                         )
//                                       ],
//                                     ),
//                                   ])),
//                         ],
//                       ),
//                     )
//                   ]),
//             );
//           }));
// }*/
