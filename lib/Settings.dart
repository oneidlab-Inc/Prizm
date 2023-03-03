import 'dart:io';
import 'package:Prizm/Private_Policy.dart';
import 'package:Prizm/Terms.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:flutter/material.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:yaml/yaml.dart';
import 'Home.dart';
import 'main.dart';
import 'History.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';

enum _HighlightTextType { text }

enum Style { light, dark, system }

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _Settings createState() => _Settings();
}

class _Settings extends State<Settings> {

  Future<void> logSetscreen() async {
    await MyApp.analytics.setCurrentScreen(screenName: '설정');
  }

  final controller = TextEditingController();
  final colorsController = ScrollController();

  TextAlign textAlign = TextAlign.justify;
  FontWeight fontWeight = FontWeight.bold;
  _HighlightTextType type = _HighlightTextType.text;

  Color selectedColor = Colors.greenAccent;

  Style _style = Style.light;

  String? uid;
  String? _deviceId;
  var currentVersion;
  var theme;

  @override
  void initState() {
    logSetscreen();
    if(MyApp.themeNotifier.value == ThemeMode.dark) {
      _style = Style.dark;
    } else if(MyApp.themeNotifier.value == ThemeMode.system) {
      _style = Style.system;
    }
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    // final isDarkMode = MyApp.themeNotifier.value == ThemeMode.dark;
    double c_width = MediaQuery.of(context).size.width;
    double c_height = MediaQuery.of(context).size.height;
    return
        WillPopScope(
          onWillPop: _onBackKey,
          child:
        Scaffold(
            appBar: AppBar(
              shape: Border(
                  bottom: BorderSide(color: Colors.grey.withOpacity(0.3))),
              title: Text(
                '설정',
                style: (
                    isDarkMode
                    ? const TextStyle(color: Colors.white)
                    : const TextStyle(color: Colors.black)),
              ),
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios),
                color: Colors.grey,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TabPage()),
                  );
                },
              ),
              backgroundColor: isDarkMode ? Colors.black : Colors.white,
              centerTitle: true,
              elevation: 0.3,
              toolbarHeight: 70,
    ),
            body: Container(
              color: isDarkMode ? Colors.black : Colors.white,
              child: ListView(
                padding: const EdgeInsets.all(8),
                children: <Widget>[
                  Container(
                    height: 50,
                    margin: const EdgeInsets.fromLTRB(30, 40, 0, 20),
                    child: Row(
                      children: [
                        ImageIcon(
                          Image.asset('assets/customer_center.png').image,
                          color: Colors.greenAccent,
                          size: 25,
                        ),
                        Text(
                          ' 고객센터',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: isDarkMode
                                  ? Colors.grey.withOpacity(0.8)
                                  : Colors.black),
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Terms()
                          )
                      );
                    },
                    child: Container(
                      color: isDarkMode ? Colors.black : Colors.white,
                      height: 70,
                      margin: const EdgeInsets.fromLTRB(30, 10, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('이용약관',
                              style: isDarkMode
                                  ? const TextStyle(
                                      fontSize: 17, color: Colors.white)
                                  : const TextStyle(
                                      fontSize: 17, color: Colors.black)
                          ),
                          Align(
                            child: Image.asset(
                              'assets/move.png',
                              width: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Private()
                          )
                      );
                    },
                    child: Container(
                      color: isDarkMode ? Colors.black : Colors.white,
                      height: 70,
                      margin: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '개인정보 처리방침',
                            style: TextStyle(
                              fontSize: 17,
                              color: isDarkMode ? Colors.white : Colors.black,
                            ),
                          ),
                          Align(
                            child: Image.asset(
                              'assets/move.png',
                              width: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
// Container(
// height: 50,
// margin: const EdgeInsets.fromLTRB(30, 0, 20, 0),
// child: Row(
// mainAxisAlignment: MainAxisAlignment.spaceBetween,
// children: [
// TextButton(
// onPressed: () {
// // Navigator.push(context, MaterialPageRoute(builder: (context)=> Private())
// // );
// },
// child: Text(
// '이용가이드',
// style: TextStyle(
// fontSize: 17,
// color: isDarkMode ? Colors.white : Colors.black,
// ),
// ),
// ),
// Align(
// child: Image.asset(
// 'assets/move.png',
// width: 10,
// ),
// )
// ],
// ),
// ),

                Container(
                  height: 70,
                  decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(color: Colors.grey.withOpacity(0.3)),
                      )),
                ),
                Container(
                  height: 70,
                  margin: const EdgeInsets.fromLTRB(30, 40, 0, 0),
                  child: Row(
                    children: [
                      ImageIcon(
                        Image.asset('assets/app_setting.png').image,
                        color: Colors.greenAccent,
                        size: 25,
                      ),
                      Text(
                        ' 앱 설정 및 정보',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: isDarkMode ? Colors.grey.withOpacity(0.8) : Colors.black),
                      ),
                    ],
                  ),
                ),
                Container(
                    // height: 50,
                    margin: const EdgeInsets.fromLTRB(30, 20, 10, 0),
                    // width: c_width * 0.21,
                    child: Text('화면스타일',
                      style: TextStyle(
                        fontSize: 17,
                        color: isDarkMode ? Colors.white : Colors.black,
                      ),
                    )
                ),
                SizedBox(
                  height: 70,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[

                        Expanded(
                          child: SizedBox(
                              // width: c_width * 0.3,
                              child: Theme(
                                  data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: const Color.fromRGBO(221, 221, 221, 1),
                                      disabledColor: Colors.blue),
                                  child: RadioListTile<Style>(
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      title: Align(
                                        alignment: const Alignment(-1, -0.1),
                                        child: Text('라이트',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: isDarkMode ? Colors.white : Colors.black)
                                        ),
                                      ),
                                      groupValue: _style,
                                      value: Style.light,
                                      onChanged: (Style? value) {
                                        setState(() {
                                          _style = value!;
                                          // Theme.of(context).brightness == Brightness.light;
                                          MyApp.themeNotifier.value = ThemeMode.light;
                                        });
                                      },
                                      activeColor: const Color.fromRGBO(64, 220, 196, 1)
                                  )
                              )
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                              // width: c_width * 0.3,
                              child: Theme(
                                  data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: const Color.fromRGBO(221, 221, 221, 1),
                                      disabledColor: Colors.blue
                                  ),
                                  child: RadioListTile<Style>(
                                    contentPadding: const EdgeInsets.only(left: 20),
                                    title: Align(
                                      alignment: const Alignment(-1, -0.1),
                                      child: Text('다크',
                                          style: TextStyle(
                                              fontSize: 13,
                                              color: isDarkMode ? Colors.white : Colors.black)),
                                    ),
                                    groupValue: _style,
                                    value: Style.dark,
                                    onChanged: (Style? value) {
                                      setState(() {
                                        _style = value!;
                                        MyApp.themeNotifier.value = ThemeMode.dark;
                                        // Theme.of(context).brightness == Brightness.dark;
                                      });
                                    },
                                    activeColor: const Color.fromRGBO(64, 220, 196, 1),
                                  )
                              )
                          ),
                        ),
                        Expanded(
                          child: SizedBox(
                              // width: c_width * 0.3,
                              child: Theme(
                                  data: Theme.of(context).copyWith(
                                      unselectedWidgetColor: const Color.fromRGBO(221, 221, 221, 1),
                                      disabledColor: Colors.blue),
                                  child: RadioListTile<Style>(
                                      contentPadding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                      title: Align(
                                        alignment: const Alignment(-1, -0.1),
                                        child: Text('시스템',
                                            style: TextStyle(
                                                fontSize: 13,
                                                color: isDarkMode ? Colors.white : Colors.black)),
                                      ),
                                      groupValue: _style,
                                      value: Style.system,
                                      onChanged: (Style? value) {
                                        setState(() {
                                          _style = value!;
                                          MyApp.themeNotifier.value == ThemeMode.system;
                                        });
                                      },
                                      activeColor: const Color.fromRGBO(64, 220, 196, 1)
                                  )
                              )
                          ),
                        ),
                      ]
                  ),
                ), //RadioBox Container End

                GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return Dialog(
                              backgroundColor: isDarkMode ? const Color.fromRGBO(66, 66, 66, 1) : Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Container(
                                  height: c_height * 0.18,
                                  width: c_width * 0.8,
                                  color: isDarkMode ? const Color.fromRGBO(66, 66, 66, 1) : Colors.white,
                                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        height: c_height * 0.115,
                                        child: const Center(
                                            child: Text('검색내역을 삭제하시겠습니까?',
                                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18))
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            border: Border(
                                                top: BorderSide(
                                                    color: isDarkMode
                                                        ? const Color.fromRGBO(94, 94, 94, 1)
                                                        : Colors.black.withOpacity(0.1)
                                                )
                                            )
                                        ),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            SizedBox(
                                                width: c_width * 0.4,
                                                height: c_height * 0.08,
                                                child: Container(
                                                  margin: const EdgeInsets.only(left: 20),
                                                  decoration: BoxDecoration(
                                                      color: isDarkMode ? const Color.fromRGBO(66, 66, 66, 1) : Colors.white,
                                                      border: Border(
                                                          right: BorderSide(
                                                              color: isDarkMode
                                                                  ? const Color.fromRGBO(94, 94, 94, 1)
                                                                  : Colors.black.withOpacity(0.1))
                                                      )
                                                  ),
                                                  child: TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: Text(
                                                        '취소',
                                                        style: TextStyle(
                                                            fontSize: 20,
                                                            color: isDarkMode
                                                                ? Colors.white.withOpacity(0.8)
                                                                : const Color.fromRGBO(147, 147, 147, 1)),
                                                      )
                                                  ),
                                                )
                                            ),
                                            Container(
                                                margin: const EdgeInsets.only(right: 20),
                                                color: isDarkMode ? const Color.fromRGBO(66, 66, 66, 1) : Colors.white,
                                                width: c_width * 0.345,
                                                height: c_height * 0.08,
                                                child: Center(
                                                  child: TextButton(
                                                    onPressed: () async {
                                                      _deviceId = await PlatformDeviceId.getDeviceId;
                                                      uid = _deviceId!;
                                                      try {
                                                        Response response =
                                                        await http.get(
                                                          Uri.parse('http://${MyApp.history}?uid=$uid&proc=del')
                                                        );
                                                        if (response.statusCode == 200) {
                                                          showToast();
                                                        } else {
                                                          failToast();
                                                          throw "검색내역 삭제 실패";
                                                        }
                                                        setState(() {
                                                          Navigator.pop(context);
                                                        });
                                                      } catch (e) {
                                                        NetworkToast();
                                                        print('실패');
                                                        setState(() {
                                                          Navigator.pop(context);
                                                        });
                                                      }
                                                    },
                                                    child: const Text('삭제',
                                                      style: TextStyle(
                                                          fontSize: 20,
                                                          color: Color.fromRGBO(64, 220, 196, 1)),
                                                    ),
                                                  ),
                                                )
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  )
                              )
                          );
                        });
                  },
                    child: Container(
                      color: isDarkMode ? Colors.black : Colors.white,
                      height: 70,
                      margin: const EdgeInsets.fromLTRB(30, 0, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('검색내역 삭제',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: isDarkMode
                                      ? Colors.white
                                      : Colors.black)),
                          Align(
                            child: Image.asset(
                              'assets/move.png',
                              width: 10,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
/*Container(
height: 50,
margin: const EdgeInsets.fromLTRB(30, 0, 20, 0),
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
children: [
Text(
'임시파일 삭제',
style: TextStyle(fontSize: 17),
),
Align(
child: Image.asset(
'assets/move.png',
width: 10,
),
)
],
),
),*/
                  Container(
                    height: 70,
                    margin: const EdgeInsets.fromLTRB(30, 10, 0, 0),
                    child: Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('현재버전   v   ${MyApp.appVersion}', // remoteConfig에서 변경시 자동으로 바뀜
                            style: TextStyle(
                                fontSize: 17,
                                color:
                                    isDarkMode ? Colors.white : Colors.black)),
                        Container(
                          height: 40,
                          padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                          margin: const EdgeInsets.only(right: 20),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1.5, color: Colors.greenAccent),
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20))),
                          child: TextButton(
                              onPressed: () => {updateToast(), _launchUpdate()},
                              child: const Text('업데이트',
                                  style: TextStyle(color: Colors.greenAccent))),
                        )
                      ],
                    )),
                  )
                ],
              ),
            ))
        );
  }

  _launchUpdate() async {
    Uri _url = Uri.parse('');
    if (Platform.isAndroid) {
      //플레이 스토어 주소 입력
      // _url = Uri.parse('http://www.oneidlab.kr/app_check.html');
    } else if (Platform.isIOS) {
      //앱스토어 주소 입력
      // _url = Uri.parse('http://www.oneidlab.kr/app_check.html');
    }
    await launchUrl(_url);
    // if (await launchUrl(_url)) {
    //   print('launching $_url');
    //   await canLaunchUrl(_url);
    // } else {
    //   throw '$_url 연결 실패';
    // }
  }

  Future<bool> _onBackKey() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return TabPage();
        });
  }
}
