import 'dart:async';
import 'dart:io';
import 'package:connectivity/connectivity.dart';
import 'package:Prizm/Home.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'main.dart';

class Terms extends StatefulWidget {
  const Terms({Key? key}) : super(key: key);

  @override
  _Terms createState() => _Terms();
}

class _Terms extends State<Terms> {
  Future<void> logSetscreen() async {
    await MyApp.analytics.setCurrentScreen(screenName: '이용약관');
  }
  
  final Completer<WebViewController> _controller = Completer<WebViewController>();

  WebViewController? _webViewController;

  String _connectionStatus = 'Unknown';
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitSubscription;


  @override
  void initState() {
    logSetscreen();
    initConnectivity();
    _connectivitSubscription = _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    // ios 추후에 추가 (다른 라이브러리 필요할듯?? IOSWebview가 없음;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [
        SystemUiOverlay.top
      ]
    );

    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
        appBar: AppBar(
          title: const Text("이용약관",
              style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
          leading: IconButton(
            icon: ImageIcon(
              Image.asset('assets/x_icon.png').image,
              color: Colors.black,
              size: 20,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          elevation: 1.0,
          backgroundColor: isDarkMode ? Colors.white.withOpacity(0.7) : Colors.white,
          toolbarHeight: 70,
        ),
        body: Container(
            color: Colors.transparent,
            child: Column(
              children: [
                Expanded(
                    child: WebView(
                  backgroundColor: isDarkMode ? Colors.white.withOpacity(0.7) : Colors.white,
                  initialUrl: 'http://www.przm.kr/js/terms.html',
                  javascriptMode: JavascriptMode.unrestricted,
                  onWebViewCreated: (WebViewController webViewController) {},
                  onProgress: (int progress) {
                    print("WebView is loading (progress : $progress %)");
                  },
                  onPageStarted: (String url) {
                    if (_connectionStatus.endsWith('none') == true) {
                      NetworkToast();
                    } else {
                      _webViewController?.loadUrl('http://www.przm.kr/js/terms.html');
                    }
                  },
                )),
                GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10),
                            topLeft: Radius.circular(10),
                        ),
                        color: Color.fromRGBO(51, 211, 180, 1),
                      ),
                      alignment: Alignment.center,
                      height: 70,
                      child: const Text('확인', style: TextStyle(color: Colors.white)),
                    )
                ),
              ],
            )
        )
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
        break;
    }
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      NetworkToast();
      print(e.toString());
    }
    if (!mounted) {
      return Future.value(null);
    }
    return _updateConnectionStatus(result);
  }
}
