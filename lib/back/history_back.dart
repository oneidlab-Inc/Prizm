// import 'dart:async';
// import 'dart:ffi';
// import 'package:darkmode/Settings.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'Home.dart';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'PlayInfo.dart';
// import 'main.dart';
//
// class History extends StatefulWidget {
//   @override
//   _History createState() => new _History();
//
// // const History({Key? key}) : super(key: key);
// }
//
// class _History extends State<History> {
//   TextEditingController txtQuery = TextEditingController();
//
//   List persons = [];
//   List original = [];
//
//   static RegExp basicReg = (RegExp(
//       r'[a-z|A-Z|0-9|ㄱ-ㅎ|ㅏ-ㅣ|가-힣|ᆞ|ᆢ|ㆍ|ᆢ|ᄀᆞ|ᄂᆞ|ᄃᆞ|ᄅᆞ|ᄆᆞ|ᄇᆞ|ᄉᆞ|ᄋᆞ|ᄌᆞ|ᄎᆞ|ᄏᆞ|ᄐᆞ|ᄑᆞ|ᄒᆞ]'));
//
//   fetchData() async {
//     http.Response response = await http.get(Uri.parse(
//         'http://dev.przm.kr/album/get_ifrmae_varna/json?sch_val=%ED%81%B4%EB%9E%98%EC%8B%9D&page=2'));
//     int statuscode = response.statusCode;
//     try {
//       print('들어와?');
//       http.Response response = await http.get(Uri.parse('http://dev.przm.kr/album/get_ifrmae_varna/json'));
//       //http.get(Uri.parse( 'http://dev.przm.kr/album/get_ifrmae_varna/json?sch_val=%ED%81%B4%EB%9E%98%EC%8B%9D&page=2'));
//       // 'https://gist.githubusercontent.com/taewon1009/09c353e5cf2306e1af6f581a645b8f0c/raw/dc9dbd1f07fb33b6c27499c55a0d1ba6434fa199/test.json'));
//       // 'https://gist.githubusercontent.com/taewon1009/03ec547a52457c16000b4c85e50f9c79/raw/dcea9eaf187fd3d4bd64636f2ded88a01d281291/list_test'));
//       // 'http://dev.przm.kr/album/get_ifrmae_varna/json?sch_val=%ED%81%B4%EB%9E%98%EC%8B%9D&page=2'));
//       // print(Uri.parse( 'http://dev.przm.kr/album/get_ifrmae_varna/json?sch_val=%ED%81%B4%EB%9E%98%EC%8B%9D&page=2'));
//       String jsonData = response.body;
//       print(jsonData.toString() );
//
//       print("1");
//       persons = jsonDecode(jsonData.toString());
//       // persons = jsonDecode(jsonData);
//       print("2");
//       print(persons);
//       original = persons;
//       setState(() {});
//     } catch (e) {
//       print('status code:  $statuscode');
//       print('실패');
//     }
//   }
//
//   void search(String query) {
//     if (query.isEmpty) {
//       persons = original;
//       setState(() {});
//       return;
//     } else {
//       persons = original;
//       setState(() {});
//     }
//
//     //for (var p in persons)
//     query = query.toLowerCase();
//     print(query);
//     List result = [];
//     for (var p in persons) {
//       // print('검색결과  : ' + p['title']);
//       // var title = p["title"].toString().toLowerCase();
//       // if (title.contains(query)) {
//       //   result.add(p);
//       // }
//       var F_TITLE = p["F_TITLE"].toString().toLowerCase();
//       if(F_TITLE.contains(query)) {
//         result.add(p);
//       }
//       var F_ARTIST = p["F_ARTIST"].toString().toLowerCase();
//       if(F_TITLE.contains(query)) {
//         result.add(p);
//       }
//       // var artist = p["artist"].toString().toLowerCase();
//       // if (artist.contains(query)) {
//       //   result.add(p);
//       // }
//       var album = p['album'].toString().toLowerCase();
//       if (album.contains(query)) {
//         result.add(p);
//       }
//     }
//
//     persons = result;
//     setState(() {});
//   }
//
//   /* ----------------------------------------------------- */
//
//   final duplicateItems = List<String>.generate(10000, (i) => "Item $i");
//
//   // final duplicateItems =
//   //     List<String>.generate(1000, (i) => "$Container(child:Text $i)");
//   var items = <String>[];
//
//   _printLatestValue() {
//     print('Latest text value : ${txtQuery.text}');
//     List<String> SearchList = <String>[];
//     SearchList.addAll(duplicateItems);
//   }
//
//   @override
//   void initState() {
//     items.addAll(duplicateItems);
//     txtQuery.addListener(_printLatestValue);
//     super.initState();
//
//     fetchData();
//     print(original);
//   }
//
//   /*-------------------------------------------------------------*/
//
//   /*-------------------------------------------------------------*/
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   void filterSearchResults(String query) {
//     List<String> SearchList = <String>[];
//     SearchList.addAll(duplicateItems);
//     if (query.isNotEmpty) {
//       List<String> ListData = <String>[];
//       SearchList.forEach((item) {
//         if (item.contains(query)) {
//           ListData.add(item);
//         }
//       });
//       setState(() {
//         items.clear();
//         items.addAll(ListData);
//       });
//       return;
//     } else {
//       setState(() {
//         items.clear();
//         items.addAll(duplicateItems);
//       });
//     }
//   }
//
//   /* ----------------------------------------------------- */
//
//   @override
//   Widget build(BuildContext context) {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     int len = persons.length;
//     return WillPopScope(
//         onWillPop: () async
//         // => false,
//             {
//           return _onBackKey();
//         },
//         child: Scaffold(
//             appBar: AppBar(
//               title: Text(
//                 '히스토리',
//                 style: (isDarkMode
//                     ? const TextStyle(
//                     color: Colors.white, fontWeight: FontWeight.bold)
//                     : const TextStyle(
//                     color: Colors.black, fontWeight: FontWeight.bold)),
//               ),
//               centerTitle: true,
//               backgroundColor: isDarkMode ? Colors.black : Colors.white,
//               toolbarHeight: 70,
//               elevation: 0.1,
//               automaticallyImplyLeading: false,
//               actions: [
//                 IconButton(
//                   icon: ImageIcon(Image.asset('assets/settings.png').image),
//                   color: isDarkMode ? Colors.white : Colors.black,
//                   onPressed: () {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (context) => const Settings()));
//                   },
//                 )
//               ],
//             ),
//             body: Container(
//               color: isDarkMode ? Colors.black : Colors.white,
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
//                               children: [
//                                 const Text(
//                                   '발견한 노래 ',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20),
//                                 ),
//                                 Text(
//                                   // '$persons.length',
//                                   '$len',
//                                   style: const TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20),
//                                 ),
//                                 const Text(
//                                   ' 곡',
//                                   style: TextStyle(
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 20),
//                                 ),
//                               ],
//                             )),
//                         TextFormField(
//                           // autofocus: true,
//                             controller: txtQuery,
//                             inputFormatters: [
//                               FilteringTextInputFormatter.allow(basicReg),
//                             ],
//                             onChanged: search,
//                             // onChanged: change,
//                             textInputAction: TextInputAction.search,
//                             onFieldSubmitted: (value) {
//                               print('text : ' + txtQuery.text);
//                             },
//                             decoration: InputDecoration(
//                                 contentPadding:
//                                 const EdgeInsets.symmetric(vertical: 0),
//                                 labelText: '곡/가수/앨범명으로 검색해주세요',
//                                 labelStyle: TextStyle(
//                                     color: isDarkMode
//                                         ? Colors.grey.withOpacity(0.8)
//                                         : Colors.black.withOpacity(0.2),
//                                     // color: Colors.black.withOpacity(0.2),
//                                     fontSize: 15),
//                                 enabledBorder: const OutlineInputBorder(
//                                     borderRadius:
//                                     BorderRadius.all(Radius.circular(10)),
//                                     borderSide: BorderSide(
//                                       color: Colors.greenAccent,
//                                     )),
//                                 focusedBorder: const OutlineInputBorder(
//                                     borderSide:
//                                     BorderSide(color: Colors.greenAccent)),
//                                 prefixIcon: const Icon(
//                                   Icons.search,
//                                   color: Colors.greenAccent,
//                                 ),
//                                 suffixIcon: txtQuery.text.isNotEmpty
//                                     ? IconButton(
//                                   icon: Icon(
//                                     Icons.clear,
//                                     color: isDarkMode
//                                         ? Colors.grey.withOpacity(0.8)
//                                         : Colors.black.withOpacity(0.2),
//                                   ),
//                                   onPressed: () {
//                                     txtQuery.text = '';
//                                     search(txtQuery.text);
//                                   },
//                                 )
//                                     : null)),
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
//
//   void showDialogPop() {
//     final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//     showDialog(
//       context: context,
//       barrierDismissible:
//       false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
//       builder: (BuildContext context) {
//         return Dialog(
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             child: Container(
//               margin: const EdgeInsets.only(top: 20, bottom: 20),
//               height: 130,
//               color: isDarkMode ? Colors.black : Colors.white,
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   const SizedBox(
//                     height: 80,
//                     child: Center(
//                       child: Text(
//                         '이 항목을 삭제하시겠습니까?',
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 18),
//                       ),
//                     ),
//                   ),
//                   Container(
//                     decoration: BoxDecoration(
//                         border: Border(
//                             top: BorderSide(
//                                 color: Colors.black.withOpacity(0.1)))),
//                     child: Row(
//                       children: [
//                         SizedBox(
//                           width: 165.7,
//                           child: Padding(
//                               padding: const EdgeInsets.only(left: 30, top: 1),
//                               child: TextButton(
//                                 onPressed: () {
//                                   Navigator.pop(context);
//                                 },
//                                 child: Text(
//                                   '취소',
//                                   style: TextStyle(
//                                     fontSize: 20,
//                                     color: Colors.black.withOpacity(0.3),
//                                   ),
//                                 ),
//                               )),
//                         ),
//                         SizedBox(
//                             width: 165.7,
//                             child: Padding(
//                               padding: const EdgeInsets.only(top: 1, right: 30),
//                               child: TextButton(
//                                 onPressed: () {},
//                                 child: const Text(
//                                   '삭제',
//                                   style: TextStyle(
//                                       fontSize: 20,
//                                       color: Color.fromRGBO(64, 220, 196, 1)),
//                                 ),
//                               ),
//                             )),
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
// Widget _listView(persons) {
//   return Expanded(
//       child: ListView.builder(
//         // itemCount: persons.length,
//           itemCount: persons == null ? 0 : persons.length,
//           itemBuilder: (context, index) {
//             double c_width = MediaQuery.of(context).size.width * 0.35;
//             final person = persons[index];
//             final isDarkMode = Theme.of(context).brightness == Brightness.dark;
//             return GestureDetector(
//               child: Container(
//                 padding: const EdgeInsets.only(top: 10, bottom: 10),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(
//                       width: 160,
//                       child: Image.asset(
//                         person['image'],
//                         width: 100,
//                         height: 100,
//                         fit: BoxFit.contain,
//                       ),
//                     ),
//                     Flexible(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           SizedBox(
//                             width: c_width,
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               mainAxisAlignment: MainAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   // person['title'],
//                                   person['F_TITLE'],
//                                   style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 15,
//                                   ),
//                                 ),
//                                 Padding(
//                                   padding:
//                                   const EdgeInsets.fromLTRB(0, 10, 0, 0),
//                                   child: Text(
//                                     // person['artist'],
//                                     person['F_ARTIST'],
//                                     style: TextStyle(
//                                         color: isDarkMode
//                                             ? Colors.grey.withOpacity(0.8)
//                                             : Colors.black.withOpacity(0.3)),
//                                   ),
//                                 ),
//                                 Text(
//                                   person['album'],
//                                   style: TextStyle(
//                                     color: Colors.black.withOpacity(0.3),
//                                   ),
//                                 ),
//                                 Text(
//                                   person['date'],
//                                   style: TextStyle(
//                                     color: isDarkMode
//                                         ? Colors.greenAccent.withOpacity(0.8)
//                                         : Colors.greenAccent,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           IconButton(
//                             icon: const Icon(Icons.more_vert_sharp, size: 30),
//                             color: Colors.grey,
//                             onPressed: () {
//                               showModalBottomSheet(
//                                   context: context,
//                                   builder: (BuildContext context) {
//                                     var person = persons[index];
//                                     // return _modal(persons);
//                                     return SizedBox(
//                                         height: 300,
//                                         child: ListView.builder(
//                                             itemCount: 1,
//                                             // itemCount: persons.length,
//                                             itemBuilder: (context, index) {
//                                               double c_width =
//                                                   MediaQuery.of(context)
//                                                       .size
//                                                       .width *
//                                                       0.5;
//                                               final isDarkMode =
//                                                   Theme.of(context)
//                                                       .brightness ==
//                                                       Brightness.dark;
//                                               return SizedBox(
//                                                 height: 300,
//                                                 child: Column(
//                                                     crossAxisAlignment:
//                                                     CrossAxisAlignment
//                                                         .start,
//                                                     children: [
//                                                       Container(
//                                                         color: isDarkMode
//                                                             ? const Color
//                                                             .fromRGBO(
//                                                             36, 36, 36, 1)
//                                                             : const Color
//                                                             .fromRGBO(
//                                                             250,
//                                                             250,
//                                                             250,
//                                                             2),
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .all(20),
//                                                         // color: const Color.fromRGBO(250, 250, 250, 2),
//                                                         child: Column(
//                                                           children: [
//                                                             Row(
//                                                               children: [
//                                                                 Image.asset(
//                                                                   person[
//                                                                   'image'],
//                                                                   width: 100,
//                                                                 ),
//                                                                 Flexible(
//                                                                     child: Row(
//                                                                         mainAxisAlignment:
//                                                                         MainAxisAlignment.spaceBetween,
//                                                                         children: [
//                                                                           SizedBox(
//                                                                             width:
//                                                                             c_width,
//                                                                             child:
//                                                                             Column(
//                                                                               crossAxisAlignment:
//                                                                               CrossAxisAlignment.start,
//                                                                               children: [
//                                                                                 Padding(
//                                                                                   padding: const EdgeInsets.only(left: 20),
//                                                                                   child: Text(
//                                                                                     person['F_TITLE'],
//                                                                                     style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
//                                                                                   ),
//                                                                                 ),
//                                                                                 Padding(
//                                                                                   padding: const EdgeInsets.fromLTRB(20, 10, 0, 0),
//                                                                                   child: Text(
//                                                                                     // person['artist'],
//                                                                                     person['F_ARTIST'],
//                                                                                     style: TextStyle(color: isDarkMode ? Colors.grey.withOpacity(0.8) : Colors.black.withOpacity(0.2)),
//                                                                                   ),
//                                                                                 ),
//                                                                               ],
//                                                                             ),
//                                                                           ),
//                                                                           IconButton(
//                                                                               padding: const EdgeInsets.only(
//                                                                                   bottom:
//                                                                                   50),
//                                                                               icon: ImageIcon(Image.asset('assets/x_icon.png').image,
//                                                                                   size:
//                                                                                   20),
//                                                                               color: Colors
//                                                                                   .grey,
//                                                                               onPressed:
//                                                                                   () {
//                                                                                 Navigator.pop(context);
//                                                                               })
//                                                                         ])),
//                                                               ],
//                                                             ),
//                                                           ],
//                                                         ),
//                                                       ),
//                                                       Container(
//                                                         color: isDarkMode
//                                                             ? Colors.black
//                                                             : Colors.white,
//                                                         height: 156,
//                                                         padding:
//                                                         const EdgeInsets
//                                                             .all(20),
//                                                         child: Column(
//                                                           children: [
//                                                             GestureDetector(
//                                                                 onTap: () {
//                                                                   Navigator.push(
//                                                                       context,
//                                                                       MaterialPageRoute(
//                                                                           builder: (context) =>
//                                                                               PlayInfo()));
//                                                                 },
//                                                                 child: Column(
//                                                                     children: [
//                                                                       Row(
//                                                                         children: [
//                                                                           IconButton(
//                                                                             padding:
//                                                                             const EdgeInsets.only(right: 30),
//                                                                             icon:
//                                                                             ImageIcon(Image.asset('assets/list.png').image, size: 40),
//                                                                             color: const Color.fromRGBO(
//                                                                                 64,
//                                                                                 220,
//                                                                                 196,
//                                                                                 1),
//                                                                             onPressed:
//                                                                                 () {
//                                                                               Navigator.push(context, MaterialPageRoute(builder: (context) => PlayInfo()));
//                                                                             },
//                                                                           ),
//                                                                           const Text(
//                                                                             '프리즘 방송 재생정보',
//                                                                             style:
//                                                                             TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
//                                                                           )
//                                                                         ],
//                                                                       ),
//                                                                     ])),
//                                                             GestureDetector(
//                                                                 onTap: () {
//                                                                   // showDialogPop();
//                                                                 },
//                                                                 child:
//                                                                 Container(
//                                                                   padding: const EdgeInsets
//                                                                       .only(
//                                                                       top: 20),
//                                                                   child: Row(
//                                                                     children: [
//                                                                       IconButton(
//                                                                         padding:
//                                                                         const EdgeInsets.only(right: 30),
//                                                                         icon: ImageIcon(
//                                                                             Image.asset('assets/trash.png')
//                                                                                 .image,
//                                                                             size:
//                                                                             40),
//                                                                         color: const Color.fromRGBO(
//                                                                             64,
//                                                                             220,
//                                                                             196,
//                                                                             1),
//                                                                         onPressed:
//                                                                             () {},
//                                                                       ),
//                                                                       const Text(
//                                                                         '히스토리에서 삭제',
//                                                                         style: TextStyle(
//                                                                             fontSize:
//                                                                             20,
//                                                                             fontWeight:
//                                                                             FontWeight.w300),
//                                                                       )
//                                                                     ],
//                                                                   ),
//                                                                 ))
//                                                           ],
//                                                         ),
//                                                       )
//                                                     ]),
//                                               );
//                                             }));
//                                   });
//                             },
//                           )
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               onTap: () {
//                 showModalBottomSheet(
//                     context: context,
//                     builder: (BuildContext context) {
//                       var person = persons[index];
//                       // return _modal(persons);
//                       return SizedBox(
//                           height: 300,
//                           child: ListView.builder(
//                               itemCount: 1,
//                               // itemCount: persons.length,
//                               itemBuilder: (context, index) {
//                                 double c_width =
//                                     MediaQuery.of(context).size.width * 0.5;
//                                 final isDarkMode =
//                                     Theme.of(context).brightness ==
//                                         Brightness.dark;
//                                 return SizedBox(
//                                   height: 300,
//                                   child: Column(
//                                       crossAxisAlignment:
//                                       CrossAxisAlignment.start,
//                                       children: [
//                                         Container(
//                                           padding: const EdgeInsets.all(20),
//                                           color: isDarkMode
//                                               ? const Color.fromRGBO(
//                                               36, 36, 36, 1)
//                                               : const Color.fromRGBO(
//                                               250, 250, 250, 2),
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 children: [
//                                                   Image.asset(
//                                                     person['image'],
//                                                     width: 100,
//                                                   ),
//                                                   Flexible(
//                                                       child: Row(
//                                                           mainAxisAlignment:
//                                                           MainAxisAlignment
//                                                               .spaceBetween,
//                                                           children: [
//                                                             SizedBox(
//                                                               width: c_width,
//                                                               child: Column(
//                                                                 crossAxisAlignment:
//                                                                 CrossAxisAlignment
//                                                                     .start,
//                                                                 children: [
//                                                                   Padding(
//                                                                     padding:
//                                                                     const EdgeInsets
//                                                                         .only(
//                                                                         left:
//                                                                         20),
//                                                                     child: Text(
//                                                                       person[
//                                                                       'F_TITLE'],
//                                                                       style: const TextStyle(
//                                                                           fontWeight:
//                                                                           FontWeight
//                                                                               .bold,
//                                                                           fontSize:
//                                                                           20),
//                                                                     ),
//                                                                   ),
//                                                                   Padding(
//                                                                     padding:
//                                                                     const EdgeInsets
//                                                                         .fromLTRB(
//                                                                         20,
//                                                                         10,
//                                                                         0,
//                                                                         0),
//                                                                     child: Text(
//                                                                       person[
//                                                                       'F_ARTIST'],
//                                                                       style: TextStyle(
//                                                                           color: isDarkMode
//                                                                               ? Colors.grey.withOpacity(
//                                                                               0.8)
//                                                                               : Colors
//                                                                               .black
//                                                                               .withOpacity(0.2)),
//                                                                     ),
//                                                                   ),
//                                                                 ],
//                                                               ),
//                                                             ),
//                                                             IconButton(
//                                                                 padding:
//                                                                 const EdgeInsets
//                                                                     .only(
//                                                                     bottom: 50),
//                                                                 icon: ImageIcon(
//                                                                     Image.asset(
//                                                                         'assets/x_icon.png')
//                                                                         .image,
//                                                                     size: 20),
//                                                                 color: Colors.grey,
//                                                                 onPressed: () {
//                                                                   Navigator.pop(
//                                                                       context);
//                                                                 })
//                                                           ])),
//                                                 ],
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                         Container(
//                                           color: isDarkMode
//                                               ? Colors.black
//                                               : Colors.white,
//                                           height: 156,
//                                           padding: const EdgeInsets.all(20),
//                                           child: Column(
//                                             children: [
//                                               GestureDetector(
//                                                   onTap: () {
//                                                     Navigator.push(
//                                                         context,
//                                                         MaterialPageRoute(
//                                                             builder: (context) =>
//                                                                 PlayInfo()));
//                                                   },
//                                                   child: Column(children: [
//                                                     Row(
//                                                       children: [
//                                                         IconButton(
//                                                           padding:
//                                                           const EdgeInsets
//                                                               .only(
//                                                               right: 30),
//                                                           icon: ImageIcon(
//                                                               Image.asset(
//                                                                   'assets/list.png')
//                                                                   .image,
//                                                               size: 40),
//                                                           color: const Color
//                                                               .fromRGBO(
//                                                               64, 220, 196, 1),
//                                                           onPressed: () {
//                                                             Navigator.push(
//                                                                 context,
//                                                                 MaterialPageRoute(
//                                                                     builder:
//                                                                         (context) =>
//                                                                         PlayInfo()));
//                                                           },
//                                                         ),
//                                                         const Text(
//                                                           '프리즘 방송 재생정보',
//                                                           style: TextStyle(
//                                                               fontSize: 20,
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .w300),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ])),
//                                               GestureDetector(
//                                                   onTap: () {
//                                                     // showDialogPop();
//                                                   },
//                                                   child: Container(
//                                                     padding:
//                                                     const EdgeInsets.only(
//                                                         top: 20),
//                                                     child: Row(
//                                                       children: [
//                                                         IconButton(
//                                                           padding:
//                                                           const EdgeInsets
//                                                               .only(
//                                                               right: 30),
//                                                           icon: ImageIcon(
//                                                               Image.asset(
//                                                                   'assets/trash.png')
//                                                                   .image,
//                                                               size: 40),
//                                                           color: const Color
//                                                               .fromRGBO(
//                                                               64, 220, 196, 1),
//                                                           onPressed: () {},
//                                                         ),
//                                                         const Text(
//                                                           '히스토리에서 삭제',
//                                                           style: TextStyle(
//                                                               fontSize: 20,
//                                                               fontWeight:
//                                                               FontWeight
//                                                                   .w300),
//                                                         )
//                                                       ],
//                                                     ),
//                                                   ))
//                                             ],
//                                           ),
//                                         )
//                                       ]),
//                                 );
//                               }));
//                     });
//               },
//             );
//           }));
// }
//
// // Widget _modal(persons) {
// // return SizedBox(
// //     height: 300,
// //     child: ListView.builder(
// //
// //         itemCount: 1,
// //         // itemCount: persons.length,
// //         itemBuilder: (context, index) {
// //           double c_width = MediaQuery.of(context).size.width * 0.5;
// //           var person = persons[index];
// //           final isDarkMode = Theme.of(context).brightness == Brightness.dark;
// //           return SizedBox(
// //             height: 300,
// //             child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(20),
// //                     // color: const Color.fromRGBO(250, 250, 250, 2),
// //                     child: Column(
// //                       children: [
// //                         Row(
// //                           children: [
// //                             Image.asset(
// //                               person['image'],
// //                               width: 100,
// //                             ),
// //                             Flexible(
// //                                 child: Row(
// //                                     mainAxisAlignment:
// //                                         MainAxisAlignment.spaceBetween,
// //                                     children: [
// //                                   SizedBox(
// //                                     width: c_width,
// //                                     child: Column(
// //                                       crossAxisAlignment:
// //                                           CrossAxisAlignment.start,
// //                                       children: [
// //                                         Padding(
// //                                           padding:
// //                                               const EdgeInsets.only(left: 20),
// //                                           child: Text(
// //                                             person['title'],
// //                                             style: const TextStyle(
// //                                                 fontWeight: FontWeight.bold,
// //                                                 fontSize: 20),
// //                                           ),
// //                                         ),
// //                                         Padding(
// //                                           padding: const EdgeInsets.fromLTRB(
// //                                               20, 10, 0, 0),
// //                                           child: Text(
// //                                             person['artist'],
// //                                             style: TextStyle(
// //                                                 color: isDarkMode
// //                                                     ? Colors.grey
// //                                                         .withOpacity(0.8)
// //                                                     : Colors.black
// //                                                         .withOpacity(0.2)),
// //                                           ),
// //                                         ),
// //                                       ],
// //                                     ),
// //                                   ),
// //                                   IconButton(
// //                                       padding:
// //                                           const EdgeInsets.only(bottom: 50),
// //                                       icon: ImageIcon(
// //                                           Image.asset('assets/x_icon.png')
// //                                               .image,
// //                                           size: 20),
// //                                       color: Colors.grey,
// //                                       onPressed: () {
// //                                         Navigator.pop(context);
// //                                       })
// //                                 ])),
// //                           ],
// //                         ),
// //                       ],
// //                     ),
// //                   ),
// //                   Container(
// //                     height: 156,
// //                     padding: const EdgeInsets.all(20),
// //                     child: Column(
// //                       children: [
// //                         GestureDetector(
// //                             onTap: () {
// //                               Navigator.push(
// //                                   context,
// //                                   MaterialPageRoute(
// //                                       builder: (context) => PlayInfo()));
// //                             },
// //                             child: Column(children: [
// //                               Row(
// //                                 children: [
// //                                   IconButton(
// //                                     padding: const EdgeInsets.only(right: 30),
// //                                     icon: ImageIcon(
// //                                         Image.asset('assets/list.png').image,
// //                                         size: 40),
// //                                     color:
// //                                         const Color.fromRGBO(64, 220, 196, 1),
// //                                     onPressed: () {
// //                                       Navigator.push(
// //                                           context,
// //                                           MaterialPageRoute(
// //                                               builder: (context) =>
// //                                                   PlayInfo()));
// //                                     },
// //                                   ),
// //                                   const Text(
// //                                     '프리즘 방송 재생정보',
// //                                     style: TextStyle(
// //                                         fontSize: 20,
// //                                         fontWeight: FontWeight.w300),
// //                                   )
// //                                 ],
// //                               ),
// //                             ])),
// //                         GestureDetector(
// //                             onTap: () {
// //                               // showDialogPop();
// //                             },
// //                             child: Container(
// //                               padding: const EdgeInsets.only(top: 20),
// //                               child: Row(
// //                                 children: [
// //                                   IconButton(
// //                                     padding: const EdgeInsets.only(right: 30),
// //                                     icon: ImageIcon(
// //                                         Image.asset('assets/trash.png').image,
// //                                         size: 40),
// //                                     color:
// //                                         const Color.fromRGBO(64, 220, 196, 1),
// //                                     onPressed: () {},
// //                                   ),
// //                                   const Text(
// //                                     '히스토리에서 삭제',
// //                                     style: TextStyle(
// //                                         fontSize: 20,
// //                                         fontWeight: FontWeight.w300),
// //                                   )
// //                                 ],
// //                               ),
// //                             ))
// //                       ],
// //                     ),
// //                   )
// //                 ]),
// //           );
// //         }));
// // }
