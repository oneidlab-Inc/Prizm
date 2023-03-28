import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:Prizm/Home.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class Private extends StatefulWidget {
  const Private({Key? key}) : super(key: key);

  @override
  _Private createState() => _Private();
}

class _Private extends State<Private> {

  Future<void> logSetscreen() async {
    await MyApp.analytics.setCurrentScreen(screenName: '개인정보 처리방침');
  }

  final Completer<WebViewController> _controller = Completer<WebViewController>();
  WebViewController? _webViewController;

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    logSetscreen();
    initConnectivity();
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.bottom]);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("개인정보 처리방침",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
              )
          ),
          leading: IconButton(
            icon: ImageIcon(
                Image.asset('assets/x_icon.png').image, color: Colors.black,
                size: 15
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          elevation: 1.0,
          backgroundColor:
          isDarkMode ? Colors.white.withOpacity(0.7) : Colors.white,
          toolbarHeight: 70,
        ),
        body: Column(
          children: [
            Expanded(
                child: WebView(
                     initialUrl: 'https://${MyApp.privacy}',
                     javascriptMode: JavascriptMode.unrestricted,
                     onPageStarted: (String url) {
                       if(_connectionStatus.endsWith('none') == true) {
                         NetworkToast();
                       }else {
                         _webViewController?.loadUrl('https://${MyApp.privacy}');
                       }
                     },
                   )
            ),
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                decoration: const BoxDecoration(
                    color: Color.fromRGBO(51, 211, 180, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20)
                    ),
                ),
                alignment: Alignment.center,
                height: 70,
                child: const Text('확인', style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        )
    );
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    if(!mounted) {
      return;
    }
    switch (await result) {
      case ConnectivityResult.mobile:
      case ConnectivityResult.wifi:
      case ConnectivityResult.none:
        setState(()=> _connectionStatus = result.toString());
        break;
      default:
        setState(()=> _connectionStatus = '네트워크 연결을 확인 해주세요.');
        break;
    }
  }

  Future <void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try{
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch(e) {
      print(e);
    }
    if(!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }
}
