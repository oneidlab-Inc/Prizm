import 'dart:async';
//1544-7556
import 'package:connectivity/connectivity.dart';
import 'package:Prizm/Home.dart';
import 'package:Prizm/vmidc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';

class NotFound extends StatefulWidget {
  @override
  _NotFound createState() => _NotFound();
}

class _NotFound extends State<NotFound> {

  Future<void> logSetscreen() async {
  // void logSetscreen() {
    await MyApp.analytics.setCurrentScreen(screenName: '검색 실패');
    await MyApp.analytics.logEvent(name: 'NotFound', parameters: null);
  }

  final VMIDC _vmidc = VMIDC();
  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  final Column _textColumn_light = Column(children: [
    const Text('검색 결과 없음',
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black)),
    Text('노래를 인식할 수 없습니다.',
        style: TextStyle(fontSize: 17, color: Colors.grey.withOpacity(0.6))),
  ]);

  final Column _textColumn_dark = Column(children: const [
    Text('검색 결과 없음',
        style: TextStyle(
            fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white)),
    Text('노래를 인식할 수 없습니다.', style: TextStyle(fontSize: 17, color: Colors.grey)),
  ]);

  @override
  void initState() {
    HapticFeedback.lightImpact();
    logSetscreen();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    _vmidc.recCtrl.sink.close();
    super.initState();
  }

  @override
  void dispose() {
    // _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    double c_height = MediaQuery.of(context).size.height;
    double c_width = MediaQuery.of(context).size.width;
    if (_connectionStatus.endsWith('none') == true) {
      print('network error');
      NetworkToast();
    }
    return WillPopScope(
        onWillPop: () async {
          return _onBackKey();
        },
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: isDarkMode
                  ? const Color.fromRGBO(47, 47, 47, 1)
                  : const Color.fromRGBO(244, 245, 247, 1),
              elevation: 0.0,
              centerTitle: true,
              toolbarHeight: 90,
              title: Image.asset(
                isDarkMode ? 'assets/logo_dark.png' : 'assets/logo_light.png',
                height: 25,
              ),
              leading: IconButton(
                  icon: Image.asset(
                    'assets/x_icon.png',
                    width: 20,
                    color: isDarkMode ? Colors.white : Colors.grey,
                  ),
                  onPressed: () async {
                       await MyApp.analytics.logEvent(name: 'Back to Home');
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => TabPage())
                    );
                  }),
            ),
            backgroundColor: isDarkMode
                ? const Color.fromRGBO(47, 47, 47, 1)
                : const Color.fromRGBO(244, 245, 247, 1),
            body: Container(
                width: c_width,
                color: isDarkMode
                    ? const Color.fromRGBO(47, 47, 47, 1)
                    : const Color.fromRGBO(244, 245, 247, 1),
                child:
                    Column(mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                  Container(
                      height: c_height * 0.59,
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Center(
                          child: Column(children: <Widget>[
                        Center(
                            child: Container(
                                padding: const EdgeInsets.only(bottom: 20),
                                child: isDarkMode
                                    ? _textColumn_dark
                                    : _textColumn_light)
                        ),
                        IconButton(
                          icon: isDarkMode
                              ? Image.asset('assets/_prizm_dark.png')
                              : Image.asset('assets/_prizm.png'),
                          padding: const EdgeInsets.only(bottom: 30),
                          iconSize: 220,
                          onPressed: () {
                            _vmidc.stop();
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TabPage()));
                          },
                        )
                      ])))
                ])
            )
        )
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    switch (result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
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

  Future<bool> _onBackKey() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return TabPage();
        });
  }
}
