import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:Prizm/vmidc.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'Settings.dart';
import 'main.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> {
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  // var brightness;
  final double _size = 220;

  final VMIDC _vmidc = VMIDC();
  final _ctrl = StreamController<List>();
  String _id = '';

  // final Image _icon = MyApp.themeNotifier.value == ThemeMode.light
  //     ? Image.asset('assets/_prizm.png')
  //     : Image.asset('assets/_prizm_dark.png');

  late dynamic _background =
      const ColorFilter.mode(Colors.transparent, BlendMode.clear);

  late var settingIcon = ImageIcon(Image.asset('assets/settings.png').image);
  late var x_icon = ImageIcon(Image.asset('assets/x_icon.png',).image);
  // late var x_icon = Image.asset('assets/x_icon', width: 20);

  late TextSpan _textSpan_light = const TextSpan(children: [
    TextSpan(
        text: '지금 이 곡을 찾으려면 ',
        style: TextStyle(fontSize: 17, color: Colors.black)),
    TextSpan(
        text: '프리즘 ',
        style: TextStyle(
            color: Color.fromRGBO(43, 226, 193, 1),
            fontSize: 17,
            fontWeight: FontWeight.bold)),
    TextSpan(
        text: '을 눌러주세요!', style: TextStyle(fontSize: 17, color: Colors.black)),
  ]);

  late TextSpan _textSpan_dark = const TextSpan(children: [
    TextSpan(
        text: '지금 이 곡을 찾으려면 ',
        style: TextStyle(fontSize: 17, color: Colors.white)),
    TextSpan(
        text: '프리즘 ',
        style: TextStyle(
            color: Color.fromRGBO(43, 226, 193, 1),
            fontSize: 17,
            fontWeight: FontWeight.bold)),
    TextSpan(
        text: '을 눌러주세요!', style: TextStyle(fontSize: 17, color: Colors.white)),
  ]);

  /*late TextSpan _textSpan = MyApp.themeNotifier.value == ThemeMode.light
      ? const TextSpan(
      children: [
    TextSpan(
        text: '지금 이 곡을 찾으려면 ',
        style: TextStyle(fontSize: 17, color: Colors.black)),
    TextSpan(
        text: '프리즘 ',
        style: TextStyle(
            color: Color.fromRGBO(43, 226, 193, 1),
            fontSize: 17,
            fontWeight: FontWeight.bold)),
    TextSpan(
        text: '을 눌러주세요!',
        style: TextStyle(fontSize: 17, color: Colors.black)),
  ])
      : const TextSpan(children: [
    TextSpan(
        text: '지금 이 곡을 찾으려면 ',
        style: TextStyle(fontSize: 17, color: Colors.white)),
    TextSpan(
        text: '프리즘 ',
        style: TextStyle(
            color: Color.fromRGBO(43, 226, 193, 1),
            fontSize: 17,
            fontWeight: FontWeight.bold)),
    TextSpan(
        text: '을 눌러주세요!',
        style: TextStyle(fontSize: 17, color: Colors.white)),
  ]);
*/
/*--------------------------------------------------------------*/

  @override
  void initState() {
    Permission.microphone.request();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _vmidc
        .init(ip: '222.122.131.220', port: 8551, sink: _ctrl.sink)
        .then((ret) {
      if (!ret) {
        print('server error');
      } else {
        _ctrl.stream.listen((data) async {
          if (data.length == 2) {
            _id = '${data[0]} (${data[1]})';
          } else {
            _id = 'error';
          }
          await _vmidc.stop();
          print('_vmidc.isRuning() : ${_vmidc.isRunning()}');
          setState(() {});
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _vmidc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
        //상단 상태바 제거
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    SystemChrome.setSystemUIOverlayStyle(// 상태바 색 설정
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    double c_height = MediaQuery.of(context).size.height;
    double c_width = MediaQuery.of(context).size.width;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final leadingTransparent = settingIcon.color != const Color(0x00000000);
    final isTransParents = settingIcon.color == const Color(0x00000000);
    final isPad = c_width > 550;
    final isFlip = c_height > 800;
    return WillPopScope(
        onWillPop: () async {
          return _onBackKey();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: isDarkMode
                ? const Color.fromRGBO(47, 47, 47, 1)
                : const Color.fromRGBO(244, 245, 247, 1),
            centerTitle: true,
            toolbarHeight: 90,
            elevation: 0.0,
            title: Image.asset(
              isDarkMode ? 'assets/logo_dark.png' : 'assets/logo_light.png',
              height: 25,
            ),
            leading: IconButton(
              icon: Image.asset('assets/x_icon.png', width: 20,
                  color: isTransParents ? isDarkMode ?Colors.white : Colors.grey : Colors.transparent),
              splashColor: Colors.transparent,
              onPressed: () {
                _vmidc.stop();
                isTransParents
                    ? Navigator.push(context, MaterialPageRoute(builder: (context) => TabPage()))
                    : const Text('');
              },
            ),
            actions: [
              IconButton(
                // icon: ImageIcon(Image.asset('assets/settings.png').image),
                icon: settingIcon,
                splashColor: Colors.transparent,
                visualDensity: const VisualDensity(horizontal: 4.0),
                color: isDarkMode ? Colors.white : Colors.black,
                onPressed: () {
                  print(settingIcon.color);
                  isTransParents
                      ? const Text('')
                      : Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings()));
                },
              )
            ],
          ),
          body: Container(
              width: double.infinity,
              color: isDarkMode
                  ? const Color.fromRGBO(47, 47, 47, 1)
                  : const Color.fromRGBO(244, 245, 247, 1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      height: c_height * 0.55,
                      padding: const EdgeInsets.only(bottom: 50),
                      decoration: isPad
                          ? BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(isDarkMode
                                      ? ('assets/BG_dark.gif')
                                      : ('assets/BG_light.gif')),
                                  alignment: const Alignment(0, -2),
                                  fit: BoxFit.cover,
                                  colorFilter: _background),
                            )
                          : BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(isDarkMode
                                      ? ('assets/BG_dark.gif')
                                      : ('assets/BG_light.gif')),
                                  alignment: isFlip
                                      ? const Alignment(0, 1)
                                      : const Alignment(0, 1),
                                  // fit: BoxFit.contain,
                                  colorFilter: _background)),
                      child: Center(
                          child: Column(children: <Widget>[
                        Center(
                            child: Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          // child: RichText(text: _textSpan)
                          child: RichText(
                              text: isDarkMode
                                  ? _textSpan_dark
                                  : _textSpan_light),
                        )),
                        IconButton(
                            // icon: _icon,
                            icon: isDarkMode
                                ? Image.asset('assets/_prizm_dark.png')
                                : Image.asset('assets/_prizm.png'),
                            padding: const EdgeInsets.only(bottom: 30),
                            iconSize: _size,
                            onPressed: () async {
                              var status = await Permission.microphone.status;
                              if (status ==
                                  PermissionStatus.permanentlyDenied) {
                                PermissionToast();
                                requestMicPermission(context);
                                return;
                              } else if (status == PermissionStatus.denied) {
                                PermissionToast();
                                requestMicPermission(context);
                                print('status >> $status');
                                Permission.microphone.request();
                                return;
                              }
                              // print(_connectionStatus);
                              if (_connectionStatus.endsWith('none') == true) {
                                NetworkToast();
                                return;
                              } else if (await Permission
                                      .microphone.status.isGranted &&
                                  _connectionStatus.endsWith('none') == false) {
                                _vmidc.start();
                                setState(() {
                                  settingIcon = ImageIcon(
                                    Image.asset('assets/settings.png').image,
                                    color: Colors.transparent,
                                  );
                                  isDarkMode
                                      ? _textSpan_dark = const TextSpan(
                                          text: '노래 분석중',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  43, 226, 193, 1),
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        )
                                      : _textSpan_light = const TextSpan(
                                          text: '노래 분석중',
                                          style: TextStyle(
                                              color: Color.fromRGBO(
                                                  43, 226, 193, 1),
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold),
                                        );
                                  _background = const ColorFilter.mode(
                                      Colors.transparent, BlendMode.color);
                                });

                                if (_vmidc.isRunning() == true) {
                                  _vmidc.stop();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TabPage()));
                                }
                              }
                            }),
                      ]))),
                ],
              )),
        ));
  }

  Future<bool> _onBackKey() async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return await showDialog(
      context: context,
      barrierDismissible: false,
      //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
      builder: (BuildContext context) {
        return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Container(
              width: 400,
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              height: 150,
              color: isDarkMode
                  ? const Color.fromRGBO(66, 66, 66, 1)
                  : Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 90,
                    child: Center(
                      child: Text(
                        '종료하시겠습니까?',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                            top: BorderSide(
                                color: isDarkMode
                                    ? const Color.fromRGBO(94, 94, 94, 1)
                                    : Colors.black.withOpacity(0.1)))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 200,
                          height: 78,
                          child: Container(
                              decoration: BoxDecoration(
                                  color: isDarkMode
                                      ? const Color.fromRGBO(66, 66, 66, 1)
                                      : Colors.white,
                                  border: Border(
                                      right: BorderSide(
                                          color: isDarkMode
                                              ? const Color.fromRGBO(
                                                  94, 94, 94, 1)
                                              : Colors.black
                                                  .withOpacity(0.1)))),
                              margin: const EdgeInsets.only(left: 20),
                              child: TextButton(
                                  onPressed: () {
                                    exit(0);
                                  },
                                  child: const Text(
                                    '종료',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  ))),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 20),
                            color: isDarkMode
                                ? const Color.fromRGBO(66, 66, 66, 1)
                                : Colors.white,
                            width: 180,
                            height: 78,
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
                                      : Colors.black.withOpacity(0.3),
                                ),
                              ),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ));
      },
    );
  }

  Future<bool> requestMicPermission(BuildContext context) async {
    PermissionStatus status = await Permission.microphone.request();
    // print('permission manage >> $status');
    if (!status.isGranted) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return _showDialog(context);
          });
      return false;
    }
    return true;
  }

  _showDialog(BuildContext context) {
    return AlertDialog(
      content: const Text('마이크 권한을 확인해주세요'),
      actions: [
        TextButton(
          onPressed: () {
            openAppSettings();
          },
          child: const Text(
            '설정하기',
            style: TextStyle(color: Colors.blue),
          ),
        )
      ],
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.wifi:
      case ConnectivityResult.mobile:
      case ConnectivityResult.none:
        setState(() => _connectionStatus = result.toString());
        break;
      default:
        setState(() => _connectionStatus = '네트워크 연결을 확인 해주세요.');
    }
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }
}

void NetworkToast() {
  Fluttertoast.showToast(
      msg: '네트워크 연결을 확인 해주세요.',
      backgroundColor: Colors.grey,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER);
}

void PermissionToast() {
  Fluttertoast.showToast(
      msg: '마이크 권한을 허용해주세요.',
      backgroundColor: Colors.grey,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER);
}
