// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:rounded_background_text/rounded_background_text.dart';
//
// enum _HighlightTextType { text }
//
// class PlayInfo extends StatefulWidget {
//   @override
//   _PlayInfo createState() => _PlayInfo();
// }
//
// class _PlayInfo extends State<PlayInfo> {
//
//   TextAlign textAlign = TextAlign.justify;
//   FontWeight fontWeight = FontWeight.bold;
//   _HighlightTextType type = _HighlightTextType.text;
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
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("프리즘 방송 재생정보",
//             style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
//         leading: IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           color: Colors.black,
//           onPressed: () {
//             Navigator.pop(context);
//           },
//         ),
//         centerTitle: true,
//         elevation: 1.0,
//         backgroundColor: Colors.white,
//         toolbarHeight: 60,
//       ),
//       body: Scrollbar(
//         child: SizedBox(
//           height: 2000,
//           child: SingleChildScrollView(
//               scrollDirection: Axis.vertical,
//               child: Material(
//                 child: Column(children: [
//                   Container(
//                     padding: const EdgeInsets.fromLTRB(20, 30, 0, 30),
//                     // color: const Color.fromRGBO(250, 250, 250, 2),
//                     // color: Colors.black,
//                     child: Row(
//                       children: [
//                         Image.asset(
//                           'assets/plant.jpg',
//                           width: 100,
//                         ),
//                         Column(
//                           children: [
//                             const Padding(
//                               padding: EdgeInsets.only(left: 20),
//                               child: Text(
//                                 '화분',
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.bold, fontSize: 20),
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(left: 20, top: 10),
//                               child: Text(
//                                 '김세정',
//                                 style: TextStyle(
//                                     fontSize: 15,
//                                     color: Colors.black.withOpacity(0.3)),
//                               ),
//                             ),
//                           ],
//                         )
//                       ],
//                     ),
//                   ),
//                   Container(
//                     color: Colors.white,
//                     padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
//                     child: Column(children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: const [
//                           Text(
//                             '최신 TV 방송내역',
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       Scrollbar(
//                           child: Container(
//                             width: 2000,
//                             child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(children: [
//                                   Column(
//                                     children: [
//                                       Container(
//                                         width: 170,
//                                         height: 170,
//                                         margin: const EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/tv_logo.jpg'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                             border: Border.all(
//                                                 width: 1,
//                                                 color:
//                                                 Colors.black.withOpacity(0.3))),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                                   () {
//                                                 switch (type) {
//                                                   case _HighlightTextType.text:
//                                                     return RoundedBackgroundText(
//                                                       'TV     ',
//                                                       strutStyle: const StrutStyle(
//                                                           forceStrutHeight: true, leading: 1),
//                                                       backgroundColor: Colors.greenAccent,
//                                                       textAlign: textAlign,
//                                                       style: const TextStyle(
//                                                           fontSize: 15, color: Colors.white),
//                                                       innerRadius: kDefaultInnerFactor,
//                                                       outerRadius: kDefaultOuterFactor,
//                                                     );
//                                                 }
//                                               }(),
//                                               // Text('  tvn')
//                                               Image.asset('assets/tvn.png', width: 40,),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             width: 170,
//                                             child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children:[
//                                                   const Text('어쩌다사장(15회)',
//                                                     style: TextStyle(overflow: TextOverflow.ellipsis,
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 17
//                                                     ),
//                                                   ),
//                                                   Text('2022-04-13', style: TextStyle(
//                                                       color: Colors.black.withOpacity(0.3)
//                                                   ),
//                                                   )
//                                                 ]),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       Container(
//                                         width: 170,
//                                         height: 170,
//                                         margin: const EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/tv_logo.jpg'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                             border: Border.all(
//                                                 width: 1,
//                                                 color:
//                                                 Colors.black.withOpacity(0.3))),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                                   () {
//                                                 switch (type) {
//                                                   case _HighlightTextType.text:
//                                                     return RoundedBackgroundText(
//                                                       'TV     ',
//                                                       strutStyle: const StrutStyle(
//                                                           forceStrutHeight: true, leading: 1),
//                                                       backgroundColor: Colors.greenAccent,
//                                                       textAlign: textAlign,
//                                                       style: const TextStyle(
//                                                           fontSize: 15, color: Colors.white),
//                                                       innerRadius: kDefaultInnerFactor,
//                                                       outerRadius: kDefaultOuterFactor,
//                                                     );
//                                                 }
//                                               }(),
//                                               Image.asset('assets/tvn.png', width: 40,),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             width: 170,
//                                             child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children:[
//                                                   const Text('어쩌다사장(15회)',
//                                                     style: TextStyle(overflow: TextOverflow.ellipsis,
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 17
//                                                     ),
//                                                   ),
//                                                   Text('2022-04-13', style: TextStyle(
//                                                       color: Colors.black.withOpacity(0.3)
//                                                   ),
//                                                   )
//                                                 ]),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       Container(
//                                         width: 170,
//                                         height: 170,
//                                         margin: const EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/tv_logo.jpg'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                             border: Border.all(
//                                                 width: 1,
//                                                 color:
//                                                 Colors.black.withOpacity(0.3))),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                                   () {
//                                                 switch (type) {
//                                                   case _HighlightTextType.text:
//                                                     return RoundedBackgroundText(
//                                                       'TV     ',
//                                                       strutStyle: const StrutStyle(
//                                                           forceStrutHeight: true, leading: 1),
//                                                       backgroundColor: Colors.greenAccent,
//                                                       textAlign: textAlign,
//                                                       style: const TextStyle(
//                                                           fontSize: 15, color: Colors.white),
//                                                       innerRadius: kDefaultInnerFactor,
//                                                       outerRadius: kDefaultOuterFactor,
//                                                     );
//                                                 }
//                                               }(),
//                                               // Text('  tvn')
//                                               Image.asset('assets/tvn.png', width: 40,),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             width: 170,
//                                             child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children:[
//                                                   const Text('어쩌다사장(15회)',
//                                                     style: TextStyle(overflow: TextOverflow.ellipsis,
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 17
//                                                     ),
//                                                   ),
//                                                   Text('2022-04-13', style: TextStyle(
//                                                       color: Colors.black.withOpacity(0.3)
//                                                   ),
//                                                   )
//                                                 ]),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       Container(
//                                         width: 170,
//                                         height: 170,
//                                         margin: const EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/tv_logo.jpg'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                             border: Border.all(
//                                                 width: 1,
//                                                 color:
//                                                 Colors.black.withOpacity(0.3))),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                                   () {
//                                                 switch (type) {
//                                                   case _HighlightTextType.text:
//                                                     return RoundedBackgroundText(
//                                                       'TV     ',
//                                                       strutStyle: const StrutStyle(
//                                                           forceStrutHeight: true, leading: 1),
//                                                       backgroundColor: Colors.greenAccent,
//                                                       textAlign: textAlign,
//                                                       style: const TextStyle(
//                                                           fontSize: 15, color: Colors.white),
//                                                       innerRadius: kDefaultInnerFactor,
//                                                       outerRadius: kDefaultOuterFactor,
//                                                     );
//                                                 }
//                                               }(),
//                                               // Text('  tvn')
//                                               Image.asset('assets/tvn.png', width: 40,),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             width: 170,
//                                             child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children:[
//                                                   const Text('어쩌다사장(15회)',
//                                                     style: TextStyle(overflow: TextOverflow.ellipsis,
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 17
//                                                     ),
//                                                   ),
//                                                   Text('2022-04-13', style: TextStyle(
//                                                       color: Colors.black.withOpacity(0.3)
//                                                   ),
//                                                   )
//                                                 ]),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   )
//                                 ])),
//                           )),
//                     ]),
//                   ),
//                   Container(
//                     color: Colors.white,
//                     padding: const EdgeInsets.fromLTRB(20, 30, 0, 30),
//                     child: Column(children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children:const [
//                           Text(
//                             '최신 RADIO 방송내역',
//                             style: TextStyle(
//                                 fontSize: 20, fontWeight: FontWeight.bold),
//                           ),
//                         ],
//                       ),
//                       Scrollbar(
//                           child: SizedBox(
//                             width: 2000,
//                             child: SingleChildScrollView(
//                                 scrollDirection: Axis.horizontal,
//                                 child: Row(children: [
//                                   Column(
//                                     children: [
//                                       Container(
//                                         width: 170,
//                                         height: 170,
//                                         margin: const EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/radio_logo.jpg'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                             border: Border.all(
//                                                 width: 1,
//                                                 color:
//                                                 Colors.black.withOpacity(0.3))),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                                   () {
//                                                 switch (type) {
//                                                   case _HighlightTextType.text:
//                                                     return RoundedBackgroundText(
//                                                       'RADIO     ',
//                                                       strutStyle: const StrutStyle(
//                                                           forceStrutHeight: true, leading: 1),
//                                                       backgroundColor: Colors.greenAccent,
//                                                       textAlign: textAlign,
//                                                       style: const TextStyle(
//                                                           fontSize: 15, color: Colors.white),
//                                                       innerRadius: kDefaultInnerFactor,
//                                                       outerRadius: kDefaultOuterFactor,
//                                                     );
//                                                 }
//                                               }(),
//                                               Image.asset('assets/sbs.png', width: 50,),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             width: 170,
//                                             child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children:[
//                                                   const Text('두시탈출 컬투쇼(15회)',
//                                                     style: TextStyle(overflow: TextOverflow.ellipsis,
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 17
//                                                     ),
//                                                   ),
//                                                   Text('2022-04-13', style: TextStyle(
//                                                       color: Colors.black.withOpacity(0.3)
//                                                   ),
//                                                   )
//                                                 ]),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       Container(
//                                         width: 170,
//                                         height: 170,
//                                         margin: const EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/radio_logo.jpg'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                             border: Border.all(
//                                                 width: 1,
//                                                 color:
//                                                 Colors.black.withOpacity(0.3))),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                                   () {
//                                                 switch (type) {
//                                                   case _HighlightTextType.text:
//                                                     return RoundedBackgroundText(
//                                                       'RADIO     ',
//                                                       strutStyle: const StrutStyle(
//                                                           forceStrutHeight: true, leading: 1),
//                                                       backgroundColor: Colors.greenAccent,
//                                                       textAlign: textAlign,
//                                                       style: const TextStyle(
//                                                           fontSize: 15, color: Colors.white),
//                                                       innerRadius: kDefaultInnerFactor,
//                                                       outerRadius: kDefaultOuterFactor,
//                                                     );
//                                                 }
//                                               }(),
//                                               Image.asset('assets/sbs.png', width: 50,),
//                                             ],
//                                           ),
//                                           SizedBox(
//                                             width: 170,
//                                             child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children:[
//                                                   const Text('두시탈출 컬투쇼(15회)',
//                                                     style: TextStyle(overflow: TextOverflow.ellipsis,
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 17
//                                                     ),
//                                                   ),
//                                                   Text('2022-04-13', style: TextStyle(
//                                                       color: Colors.black.withOpacity(0.3)
//                                                   ),
//                                                   )
//                                                 ]),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       Container(
//                                         width: 170,
//                                         height: 170,
//                                         margin: const EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/radio_logo.jpg'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                             border: Border.all(
//                                                 width: 1,
//                                                 color:
//                                                 Colors.black.withOpacity(0.3))),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                                   () {
//                                                 switch (type) {
//                                                   case _HighlightTextType.text:
//                                                     return RoundedBackgroundText(
//                                                       'RADIO     ',
//                                                       strutStyle: const StrutStyle(
//                                                           forceStrutHeight: true, leading: 1),
//                                                       backgroundColor: Colors.greenAccent,
//                                                       textAlign: textAlign,
//                                                       style: const TextStyle(
//                                                           fontSize: 15, color: Colors.white),
//                                                       innerRadius: kDefaultInnerFactor,
//                                                       outerRadius: kDefaultOuterFactor,
//                                                     );
//                                                 }
//                                               }(),
//                                               // Text('  tvn')
//                                               Image.asset('assets/sbs.png', width: 50,),
//                                             ],
//                                           ),
//
//                                           SizedBox(
//                                             width: 170,
//                                             child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children:[
//                                                   const Text('두시탈출 컬투쇼(15회)',
//                                                     style: TextStyle(overflow: TextOverflow.ellipsis,
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 17
//                                                     ),
//                                                   ),
//                                                   Text('2022-04-13', style: TextStyle(
//                                                       color: Colors.black.withOpacity(0.3)
//                                                   ),
//                                                   )
//                                                 ]),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   ),
//                                   Column(
//                                     children: [
//                                       Container(
//                                         width: 170,
//                                         height: 170,
//                                         margin: const EdgeInsets.all(10),
//                                         decoration: BoxDecoration(
//                                             image: const DecorationImage(
//                                               image: AssetImage(
//                                                   'assets/radio_logo.jpg'),
//                                               fit: BoxFit.fill,
//                                             ),
//                                             border: Border.all(
//                                                 width: 1,
//                                                 color:
//                                                 Colors.black.withOpacity(0.3))),
//                                       ),
//                                       Column(
//                                         crossAxisAlignment: CrossAxisAlignment.start,
//                                         children: [
//                                           Row(
//                                             children: [
//                                                   () {
//                                                 switch (type) {
//                                                   case _HighlightTextType.text:
//                                                     return RoundedBackgroundText(
//                                                       'Radio     ',
//                                                       strutStyle: const StrutStyle(
//                                                           forceStrutHeight: true, leading: 1),
//                                                       backgroundColor: Colors.greenAccent,
//                                                       textAlign: textAlign,
//                                                       style: const TextStyle(
//                                                           fontSize: 15, color: Colors.white),
//                                                       innerRadius: kDefaultInnerFactor,
//                                                       outerRadius: kDefaultOuterFactor,
//                                                     );
//                                                 }
//                                               }(),
//                                               Image.asset('assets/sbs.png', width: 50,),
//                                             ],
//                                           ),
//
//                                           SizedBox(
//                                             width: 170,
//                                             child: Column(
//                                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                                 children:[
//                                                   const Text('두시탈출 컬투쇼(15회)',
//                                                     style: TextStyle(overflow: TextOverflow.ellipsis,
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 17
//                                                     ),
//                                                   ),
//                                                   Text('2022-04-13', style: TextStyle(
//                                                       color: Colors.black.withOpacity(0.3)
//                                                   ),
//                                                   )
//                                                 ]),
//                                           )
//                                         ],
//                                       )
//                                     ],
//                                   )
//                                 ])),
//                           )),
//                     ]),
//                   )
//                 ]),
//               )),
//         ),
//       ),
//     );
//   }
// }
