import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'Home.dart';
import 'Settings.dart';
import 'PlayInfo.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'main.dart';

class Chart extends StatefulWidget {
  @override
  _Chart createState() => _Chart();
}

class _Chart extends State<Chart> {
  String? _deviceId;

  Future<void> initPlatformState() async {
    String? deviceId;

    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = 'Failed to get Id';
    }

    if (!mounted) return;

    setState(() {
      _deviceId = deviceId;
      print('deviceId : $_deviceId');
    });
  }

  List persons = [];
  List original = [];

  void fetchData() async {
    try {
      http.Response response = await http.get(Uri.parse(
          'http://dev.przm.kr/przm_api/get_song_ranks'));
      String jsonData = response.body;
      persons = jsonDecode(jsonData.toString());
      original = persons;
      setState(() {});
    } catch (e) {
      NetworkToast();
      print('json 로딩 실패');
      print(e);
    }
  }

  // final duplicateItems =
  // List<String>.generate(1000, (i) => "$Container(child:Text $i)");
  // var items = <String>[];

  @override
  void initState() {
    // items.addAll(duplicateItems);
    initPlatformState();
    fetchData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    int len = persons.length;
    final isExist = len == 0;
    return WillPopScope(
        onWillPop: () async {
          return _onBackKey();
        },
        child: Scaffold(
            appBar: AppBar(
              shape: Border(
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.3))),
              elevation: 0.0,
              title: Text(
                '차트',
                style: (isDarkMode
                    ? const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)
                    : const TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
              ),
              centerTitle: true,
              toolbarHeight: 80,
              // backgroundColor: Colors.white,
              backgroundColor: isDarkMode ? Colors.black : Colors.white,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  icon: ImageIcon(
                    Image.asset('assets/settings.png').image,
                  ),
                  color: isDarkMode ? Colors.white : Colors.black,
                  onPressed: () {
                    print("Settings");
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const Settings()),
                    );
                  },
                )
              ],
            ),
            body: Container(
              color: isDarkMode ? Colors.black : Colors.white,
              width: MediaQuery.of(context).size.width * 1,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: isDarkMode ? Colors.black : Colors.white,
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            padding: const EdgeInsets.only(top: 20),
                            child: Row(
                              children: const [
                                Text(
                                  '프리즘 방송 차트 ',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                  isExist
                      ? Container(
                    margin: const EdgeInsets.only(top: 100),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 30),
                          child: Center(
                            child:
                            Image.asset(
                                'assets/loading.gif',
                                width: 40,
                                color: isDarkMode ? Colors.white : Colors.black
                            ),
                          ),
                        ),
                        Center(
                          child: Text(
                            '차트정보를 불러오고있습니다.',
                            style: TextStyle(
                                color: isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22),
                          ),
                        )
                      ],
                    ),
                  )
                      : _listView(persons)
                ],
              ),
            )
        )
     );
  }

  Widget _listView(persons) {
    return Expanded(
        child: ListView.builder(
            itemCount: persons == null ? 0 : persons.length,
            itemBuilder: (context, index) {
              double c_width = MediaQuery.of(context).size.width;

              final deviceId = _deviceId;
              final person = persons[index];

              final isArtistNull = person['title'] == null;
              final isAlbumNull = person['album'] == null;

              String title = person['title'];
              String image = person['image'];
              String artist = isArtistNull ? 'Various Artists' : person['artist'];
              String song_id = person['song_id'];
              String Id = deviceId!;

              final isDarkMode =
                  Theme.of(context).brightness == Brightness.dark;

              return GestureDetector(
                  child: Container(
                    color: isDarkMode ? Colors.black : Colors.white,
                    width: c_width,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(1),
                          margin: const EdgeInsets.only(left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: isDarkMode
                                ? const Color.fromRGBO(189, 189, 189, 1)
                                : const Color.fromRGBO(228, 228, 228, 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SizedBox.fromSize(
                              size: const Size.fromRadius(40),
                              child: Image.network(
                                person['image'],
                                width: 80,
                                height: 80,
                                errorBuilder: (context, error, stackTrace) {
                                  return SizedBox(
                                    width: 80,
                                    height: 80,
                                    child: Image.asset('assets/no_image.png'),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: c_width * 0.6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: Text(
                                        person['title'],
                                        style: TextStyle(
                                          color: isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                          overflow: TextOverflow.ellipsis,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: RichText(
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          text: TextSpan(children: [
                                            TextSpan(
                                              text: isArtistNull
                                                  ? 'Various Artists'
                                                  : person['artist'],
                                              style: TextStyle(
                                                  color: isDarkMode
                                                      ? Colors.grey
                                                      .withOpacity(0.8)
                                                      : Colors.black
                                                      .withOpacity(0.3)),
                                            ),
                                            TextSpan(
                                              text: ' · ',
                                              style: TextStyle(
                                                  color: isDarkMode
                                                      ? Colors.grey
                                                      .withOpacity(0.8)
                                                      : Colors.black
                                                      .withOpacity(0.3)),
                                            ),
                                            TextSpan(
                                              text: isAlbumNull
                                                  ? 'Various Album'
                                                  : person['album'],
                                              style: TextStyle(
                                                  color: isDarkMode
                                                      ? Colors.grey
                                                      .withOpacity(0.8)
                                                      : Colors.black
                                                      .withOpacity(0.3)),
                                            )
                                          ]),
                                        ))
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: c_width * 0.09,
                                child: const Icon(Icons.more_vert_sharp,
                                    color: Colors.grey, size: 30),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: context,
                        builder: (BuildContext context) {
                          var person = persons[index];
                          final deviceId = _deviceId;
                          return SizedBox(
                              height: 230,
                              child: ListView.builder(
                                  itemCount: 1,
// itemCount: persons.length,
                                  itemBuilder: (context, index) {
                                    double c_width = MediaQuery.of(context).size.width;
                                    final isDarkMode = MyApp.themeNotifier.value == ThemeMode.dark;
                                    return Column(
                                        crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            width: c_width,
                                            padding: const EdgeInsets.all(14),
                                            decoration: BoxDecoration(
                                                color: isDarkMode
                                                    ? const Color.fromRGBO(36, 36, 36, 1)
                                                    : const Color.fromRGBO(250, 250, 250, 2),
                                                borderRadius: const BorderRadius.only(
                                                    topLeft: Radius.circular(10),
                                                    topRight: Radius.circular(10))
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                    margin : const EdgeInsets.only(left: 10, top: 10, bottom: 10),
                                                    padding: const EdgeInsets.all(1),
                                                    decoration: BoxDecoration(
                                                      color: isDarkMode
                                                          ? const Color.fromRGBO(189, 189, 189, 1)
                                                          // : const Color.fromRGBO(228, 228, 228, 1),
                                                      : Colors.black.withOpacity(0.3),
                                                      borderRadius:
                                                      BorderRadius.circular(20),
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(20),
                                                        child:
                                                        SizedBox.fromSize(
                                                          child :Image.network(
                                                            person['image'],
                                                            width: 90,
                                                            height: 90,
                                                            errorBuilder: (context, error, stackTrace) {
                                                              return SizedBox(
                                                                width: 90,
                                                                height: 90,
                                                                child: Image.asset('assets/no_image.png'),
                                                              );
                                                            },
                                                          ),
                                                        )
                                                    )
                                                ),
                                                Flexible(
                                                    child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Container(
                                                            width: c_width * 0.6,
                                                            padding:
                                                            const EdgeInsets.only(left: 40),
                                                            child: Column(
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                  const EdgeInsets.only(bottom: 15),
                                                                  child: Text(
                                                                    person['title'],
                                                                    style: TextStyle(
                                                                        fontWeight:FontWeight.bold,
                                                                        fontSize:20,
                                                                        overflow: TextOverflow.ellipsis,
                                                                        color: isDarkMode
                                                                            ? Colors.white
                                                                            : Colors.black),
                                                                  ),
                                                                ),
                                                                Text(
                                                                  isArtistNull
                                                                      ? 'Various Artists'
                                                                      : person[
                                                                  'artist'],
                                                                  style: TextStyle(
                                                                      color: isDarkMode
                                                                          ? Colors.grey.withOpacity(0.8)
// : Colors.black.withOpacity(0.2),
                                                                          : const Color.fromRGBO(123, 123, 123, 1),
                                                                      overflow: TextOverflow.ellipsis),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: c_width * 0.05,
                                                            child: IconButton(
                                                                padding:
                                                                const EdgeInsets
                                                                    .only(
                                                                    bottom:
                                                                    50),
                                                                icon: ImageIcon(
                                                                    Image.asset(
                                                                        'assets/x_icon.png')
                                                                        .image,
                                                                    size: 15),
                                                                color:
                                                                Colors.grey,
                                                                onPressed: () {
                                                                  Navigator.pop(
                                                                      context);
                                                                }),
                                                          )
                                                        ])),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            height: 90,
                                            padding:
                                            const EdgeInsets.fromLTRB(
                                                20, 20, 20, 0),
                                            color: isDarkMode
                                                ? Colors.black
                                                : Colors.white,
                                            child: Column(
                                              children: [
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(context, MaterialPageRoute(
                                                          builder: (context) => PlayInfo(
                                                            deviceId: Id,
                                                            title: title,
                                                            image: image,
                                                            artist: artist,
                                                            song_id: song_id,
                                                          )));
                                                    },
                                                    child: Container(
                                                      color: isDarkMode
                                                          ? Colors.black
                                                          : Colors.white,
                                                      child: Row(
                                                        children: [
                                                          IconButton(
                                                            padding: const EdgeInsets.only(right: 20),
                                                            icon: ImageIcon(
                                                                Image.asset('assets/list.png')
                                                                    .image,
                                                                size: 30),
                                                            color: const Color
                                                                .fromRGBO(
                                                                64,
                                                                220,
                                                                196,
                                                                1),
                                                            onPressed: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          PlayInfo(
                                                                            deviceId: Id,
                                                                            title: title,
                                                                            image: image,
                                                                            artist: artist,
                                                                            song_id: song_id,
                                                                          )));
                                                            },
                                                          ),
                                                          Text(
                                                            '프리즘 방송 재생정보',
                                                            style: TextStyle(
                                                                fontSize: 20,
                                                                fontWeight:
                                                                FontWeight
                                                                    .w300,
                                                                color: isDarkMode
                                                                    ? Colors
                                                                    .white
                                                                    : Colors
                                                                    .black),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          )
                                        ]);
                                  })
                          );
                        });
                  });
            }));
  }

  Future<bool> _onBackKey() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return TabPage();
        });
  }
}