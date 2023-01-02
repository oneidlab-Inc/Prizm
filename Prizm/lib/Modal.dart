// import 'package:flutter/material.dart';
//
// class Modal extends StatefulWidget{
//   @override
//   _Modal createState() => new _Modal();
// }
//
// class _Modal extends State<Modal> {
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         onWillPop:  () async {
//           return _onBackKey();
//         },
//         child:Scaffold(
//           body: Container(
//             child: Row(
//               children: [
//
//                 Column(
//                   children: [
//
//                   ],
//                 )
//               ],
//             ),
//           ),
//         )
//     );
//   }
//
//   Future<bool> _onBackKey() async {
//     return await showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             backgroundColor: const Color(0xff161619),
//             title: const Text(
//               '종료?',
//               style: TextStyle(color: Colors.white),
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, true);
//                   },
//                   child: const Text('ㅇㅇ')),
//               TextButton(
//                   onPressed: () {
//                     Navigator.pop(context, false);
//                   },
//                   child: const Text('ㄴㄴ')),
//             ],
//           );
//         });
//   }
// }