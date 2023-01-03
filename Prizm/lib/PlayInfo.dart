import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import 'main.dart';

enum _HighlightTextType { text }

class PlayInfo extends StatefulWidget {
  final String title;
  final String image;
  final String artist;
  final String song_id;
  final String deviceId;

  const PlayInfo({
    Key? key,
    required this.title,
    required this.image,
    required this.artist,
    required this.song_id,
    required this.deviceId,
  }) : super(key: key);

  @override
  State<PlayInfo> createState() {
    return _PlayInfo();
  }
}

class _PlayInfo extends State<PlayInfo> {
  TextAlign textAlign = TextAlign.justify;
  FontWeight fontWeight = FontWeight.bold;
  _HighlightTextType type = _HighlightTextType.text;

  List maps = [];
  List original = [];
  List maps_radio = [];

  late int statuscode;

  // List<String> map = Map<String, dynamic>;
  // List<dynamic>original = [];

  fetchData() async {
    String id = widget.song_id;
    // String uid = widget.deviceId;

    http.Response response = await http.get(
        // Uri.parse('http://dev.przm.kr/przm_api/get_song_search/json?id=$id')
            Uri.parse('${MyApp.Uri}get_song_search/json?id=$id')
    );

    statuscode = response.statusCode;
    try {
      var jsonData = response.body;
      Map<String, dynamic> map = jsonDecode(jsonData);
      maps = map['tv'];
      maps_radio = map['radio'];
      original = maps;

      setState(() {});
    } catch (e) {
      print('json 통신 실패');
      print(e);
    }
  }

  final duplicateItems =
      List<String>.generate(1000, (i) => "$Container(child:Text $i)");
  var items = <String>[];

  @override
  void initState() {
    items.addAll(duplicateItems);
    fetchData();
    // post = post;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isExistTV = maps.length == 0;
    final isExistRadio = maps_radio.length == 0;
    final isAsset = widget.image == 'assets/no_image.png';

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    double c_width = MediaQuery.of(context).size.width * 1.0;
    double c_height = MediaQuery.of(context).size.height * 1.0;
    return Scaffold(
      appBar: AppBar(
        title: Text("프리즘 방송 재생정보",
            style: TextStyle(
                color: isDarkMode ? Colors.white : Colors.black,
                fontWeight: FontWeight.bold)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: isDarkMode ? Colors.white : Colors.black,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        elevation: 1.0,
        backgroundColor: isDarkMode ? Colors.black : Colors.white,
        toolbarHeight: 60,
      ),
      body: Container(
        height: 2500,
        color: isDarkMode ? Colors.black : Colors.white,
        child: Scrollbar(
            child: SizedBox(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: c_width,
                    color: isDarkMode
                        ? const Color.fromRGBO(36, 36, 36, 1)
                        : const Color.fromRGBO(250, 250, 250, 1),
                    height: 100,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.all(1),
                            margin: const EdgeInsets.only(
                                right: 30, top: 20, left: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: isDarkMode
                                  ? const Color.fromRGBO(189, 189, 189, 1)
                                  : const Color.fromRGBO(228, 228, 228, 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: SizedBox.fromSize(
                                  size: const Size.fromRadius(28),
                                  child: Image.network(
                                    widget.image,
                                    width: 70,
                                    height: 70,
                                    errorBuilder: (context, error, stackTrace) {
                                      return SizedBox(
                                          width: 70,
                                          height: 70,
                                          child: Image.asset(
                                              'assets/no_image.png'));
                                    },
                                  )),
                            )),
                        Container(
                            width: c_width * 0.6,
                            padding: const EdgeInsets.only(top: 25),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(widget.title,
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        overflow: TextOverflow.ellipsis,
                                        color: isDarkMode
                                            ? Colors.white
                                            : Colors.black)),
                                Container(
                                  margin: const EdgeInsets.only(top: 5),
                                  child: Text(widget.artist,
                                      style: TextStyle(
                                          color: isDarkMode
                                              ? const Color.fromRGBO(
                                                  123, 123, 123, 1)
                                              : const Color.fromRGBO(
                                                  151, 151, 151, 1),
                                          overflow: TextOverflow.ellipsis)),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20, right: 20),
                    // padding: EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        SizedBox(
                            // height: 350,
                            height: c_height * 0.4,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(
                                        top: 30, bottom: 10),
                                    child: Text(
                                      '최신 TV 방송내역',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 22,
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                  Expanded(
                                      child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          child: isExistTV
                                              ? Center(
                                                  child: Text(
                                                      '최신 TV 방송내역이 없습니다.',
                                                      style: TextStyle(
                                                          color: isDarkMode
                                                              ? Colors.white
                                                              : Colors.black,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20)),
                                                )
                                              : _tv_list(maps, widget))
                                    ],
                                  ))
                                ])),
                        SizedBox(
                            // height: 350,
                            height: c_height * 0.40,
                            // padding: EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  child: const Text(
                                    '최신 RADIO 방송내역',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22),
                                  ),
                                ),
                                Expanded(
                                    child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      child: isExistRadio
                                          ? Center(
                                              child: Text(
                                                  '최신 RADIO 방송내역이 없습니다.',
                                                  style: TextStyle(
                                                      color: isDarkMode
                                                          ? Colors.white
                                                          : Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20)),
                                            )
                                          : _radio_list(maps_radio, widget),
                                    )
                                  ],
                                ))
                              ],
                            )),
                      ],
                    ),
                  )
                ]),
          ),
        )),
      ),
    );
  }

  Widget _radio_list(maps_radio, widget) {
    return Expanded(
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: maps_radio == null ? 0 : maps_radio.length,
          itemBuilder: (context, index) {
            final isDarkMode = Theme.of(context).brightness == Brightness.dark;
            final isAsset =
                maps_radio[index]['RADIO_LOGO'] == 'assets/no_image.png';
            double c_width = MediaQuery.of(context).size.width;

            return Row(children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(2),
                    margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                          color: isDarkMode
                              ? const Color.fromRGBO(189, 189, 189, 1)
                              // ? Colors.green
                              // : const Color.fromRGBO(228, 228, 228, 1),
                          : Colors.black.withOpacity(0.3),
                          width: 3
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: SizedBox.fromSize(
                        child: Image.network(
                          // maps_radio[index]['RADIO_IMAGE'],
                          maps_radio[index]['RADIO_LOGO'],
                          width: 140,
                          height: 140,
                          errorBuilder: (context, error, stackTrace) {
                            return SizedBox(
                              width: 140,
                              height: 140,
                              child: Image.asset('assets/no_image.png'),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10),
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: const Color.fromRGBO(51, 211, 180, 1)),
                          child: Text(
                            maps_radio[index]['RADIO_TYPE'],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 65,
                          height: 22,
                          child: Text(maps_radio[index]['CL_NM'],
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontWeight: FontWeight.bold,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                                  fontSize: 16)),
                        )
                        // SizedBox(
                        //   child: Image.network(
                        //     maps_radio[index]['RADIO_LOGO'],
                        //     width: 50,
                        //     height: 22,
                        //     errorBuilder: (context, error, stackTrace) {
                        //       return SizedBox(
                        //         width: 65,
                        //         height: 22,
                        //         child: Text(maps_radio[index]['CL_NM'],
                        //             style: TextStyle(
                        //                 overflow: TextOverflow.ellipsis,
                        //                 fontWeight: FontWeight.bold,
                        //                 color: isDarkMode
                        //                     ? Colors.white
                        //                     : Colors.black,
                        //                 fontSize: 16)),
                        //       );
                        //     },
                        //   ),
                        // )
                      ]),
                      Container(
                        margin: const EdgeInsets.fromLTRB(0, 3, 0, 10),
                        width: 140,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.only(bottom: 3),
                              child: Text(maps_radio[index]['RADIO_NAME'],
                                  style: TextStyle(
                                      overflow: TextOverflow.ellipsis,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: isDarkMode
                                          ? Colors.white
                                          : Colors.black)),
                            ),
                            Text(maps_radio[index]['RADIO_DATE'],
                                style: TextStyle(
                                    color: isDarkMode
                                        ? Colors.grey.withOpacity(0.8)
                                        : Colors.black.withOpacity(0.3)))
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              )
            ]);
          }),
    );
  }
}

Widget _tv_list(maps, widget) {
  return Expanded(
    child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: maps == null ? 0 : maps.length,
        itemBuilder: (context, index) {
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;
          double c_width = MediaQuery.of(context).size.width * 0.4;

          return Row(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(1),
                  margin: const EdgeInsets.fromLTRB(0, 10, 10, 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                        color: isDarkMode
                            ? const Color.fromRGBO(189, 189, 189, 1)
                            // : const Color.fromRGBO(228, 228, 228, 1),
                        : Colors.black.withOpacity(0.3),
                        width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: SizedBox.fromSize(
                      child: Image.network(
                        // maps[index]['TV_IMAGE'],
                        maps[index]['TV_LOGO'],
                        width: 140,
                        height: 140,
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            width: 140,
                            height: 140,
                            child: Image.asset('assets/no_image.png'),
                          );
                        },
                      ),
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    // Container(
                    //   width: 140,
                    //   child:
                    Row(children: [
                      Container(
                        margin: const EdgeInsets.only(right: 10),
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: const Color.fromRGBO(51, 211, 180, 1)),
                        child: Text(
                          maps[index]['TV_TYPE'],
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      SizedBox(
                        width: 65,
                        height: 22,
                        // padding: const EdgeInsets.only(top: 3),
                        child: Text(maps[index]['CL_NM'],
                            style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontWeight: FontWeight.bold,
                                color: isDarkMode ? Colors.white : Colors.black,
                                fontSize: 16)),
                      ),
                      // SizedBox(
                      //   child: Image.network(
                      //     maps[index]['TV_LOGO'],
                      //     width: 50,
                      //     height: 22,
                      //     errorBuilder: (context, error, stackTrace) {
                      //       return SizedBox(
                      //         width: 65,
                      //         height: 22,
                      //           // padding: const EdgeInsets.only(top: 3),
                      //           child: Text(maps[index]['CL_NM'],
                      //               style: TextStyle(
                      //                   overflow: TextOverflow.ellipsis,
                      //                   fontWeight: FontWeight.bold,
                      //                   color: isDarkMode
                      //                       ? Colors.white
                      //                       : Colors.black,
                      //                   fontSize: 16
                      //               )),
                      //       );
                      //     },
                      //   ),
                      // )
                    ]),
                    // )
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 3, 0, 10),
                      width: 140,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: const EdgeInsets.only(bottom: 3),
                            child: Text(maps[index]['TV_NAME'],
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                    color: isDarkMode
                                        ? Colors.white
                                        : Colors.black)),
                          ),
                          Text(maps[index]['TV_DATE'],
                              style: TextStyle(
                                  color: isDarkMode
                                      ? Colors.grey.withOpacity(0.8)
                                      : Colors.black.withOpacity(0.3)))
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )
          ]);
        }),
  );
}
