import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:Prizm/firebase_options.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:Prizm/vmidc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:package_info/package_info.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Chart.dart';
import 'History.dart';
import 'Home.dart';
import 'Search_Result.dart';

final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // print(Firebase.apps.toString());
  runApp(
    MyApp(),
  );
}

class MyApp extends StatelessWidget {

  static final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.system);
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer = FirebaseAnalyticsObserver(analytics: analytics);

  Future<void> logSetscreen() async {
    await MyApp.analytics.setCurrentScreen(screenName: 'TabPage');
  }

  MyApp({Key? key}) : super(key: key);

  static var appVersion;
  static var search;
  static var history;
  static var programs;
  static var ranks;
  static var privacy;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            navigatorObservers: [observer],
            // initialRoute: 'Category',
            // routes: {'Category':(context) =>Category()},
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('ko', ''),
              Locale('en', ''),
            ],
            debugShowCheckedModeBanner: false,
            // 화면 우상단 띠 제거
            navigatorKey: VMIDC.navigatorState,
            // 화면 이동을 위한 navigator
            theme: ThemeData(
                primarySwatch: generateMaterialColor(color: Colors.white)
            ),
            darkTheme: ThemeData.dark().copyWith(),
            themeMode: currentMode,
            home: TabPage(),
          );
        });
  }
}

class TabPage extends StatefulWidget {
  @override
  _TabPageState createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  int _selectedIndex = 1; // 처음에 나올 화면 지정

  // static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  var deviceInfoPlugin = DeviceInfoPlugin();
  var deviceIdentifier = 'unknown';

  var deviceData;
  var _deviceData;
  
  Future<void> remoteconfig() async {
    final FirebaseRemoteConfig remoteConfig = await FirebaseRemoteConfig.instance;
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var packageVersion = packageInfo.version;
    remoteConfig.setDefaults({'appVersion':packageVersion});
    remoteConfig.fetchAndActivate();

    String appVersion = remoteConfig.getString(MyApp.appVersion);
    print(appVersion);
  }
  
  Future<void> initPlatformState() async {
    String? deviceId; //기기 uid
    try {
      deviceId = await PlatformDeviceId.getDeviceId;
    } on PlatformException {
      deviceId = '디바이스 정보 추출 실패';
    }
    if (!mounted) return;
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidDevice = await deviceInfoPlugin.androidInfo;

      deviceData = androidDevice.displayMetrics.widthPx; //withPx 정보
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfoPlugin.iosInfo;
      deviceIdentifier = iosInfo.identifierForVendor!;
    }
    setState(() {
      _deviceData = deviceData;
    });
  }

/*----------------------------------------------------------------------------------------------------*/

  Future _launchUpdate() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var packageVersion = packageInfo.version;
    MyApp.appVersion = packageVersion;

    // _versionCheck.checkUpdatable(version);
// 스토어 업로드 후 주소 받고 활성화

// if (version == version) {
//
// showDefaultDialog();
//
// } else {}
  }

  void showDefaultDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;
          double c_height = MediaQuery.of(context).size.height;
          double c_width = MediaQuery.of(context).size.width;
          return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: c_height * 0.18,
                width: c_width * 0.8,
                margin: const EdgeInsets.only(top: 20, bottom: 20),
                color: isDarkMode
                    ? const Color.fromRGBO(66, 66, 66, 1)
                    : Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: c_height * 0.115,
                      child: const Center(
                        child: Text('업데이트를 위해 스토어로 이동합니다.',
                            style: TextStyle(fontSize: 18)),
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
                          Container(
                              margin: const EdgeInsets.only(right: 20),
                              color: isDarkMode
                                  ? const Color.fromRGBO(66, 66, 66, 1)
                                  : Colors.white,
                              width: c_width * 0.345,
                              height: c_height * 0.08,
                              child: TextButton(
                                onPressed: () {
                                  Uri _url = Uri.parse('');
                                  if (Platform.isAndroid) {
                                    // showDefaultDialog();
                                    updateToast();
// _url = Uri.parse('http://www.naver.com');
// _url = Uri.parse('http://www.oneidlab.kr/app_check.html');
// 플레이스토어 주소 입력
                                  } else if (Platform.isIOS) {
                                    // print('ios platform');
                                    // showDefaultDialog();
                                    updateToast();
                                  }
                                  try {
                                    launchUrl(_url);
                                    canLaunchUrl(_url);
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Text(
                                  '이동',
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
        });
  }

/*-----------------------------------------------------------------------------------------*/

  final List _pages = [History(), Home(), Chart()];
  // final List _pages = [Result(id: '',), Home(), Chart()];   // emulator에서 result화면 수정시 History 대신 Result 넣고 수정

  List url = [];

  fetchData() async {
    // 고정 URL 나오면 변경
    try {
      http.Response response =
          await http.get(Uri.parse('http://www.przm.kr/przm.php'));
      String jsonData = response.body;
      Map<String, dynamic> url = jsonDecode(jsonData.toString());
      setState(() {});
      // MyApp.Uri = url;
      MyApp.search = url['search'];
      MyApp.history = url['history'];
      MyApp.programs = url['programs'];
      MyApp.ranks = url['ranks'];
      MyApp.privacy = url['privacy'];
      // print('MyApp.Uri >> ${url}');
    } catch (e) {
      print('error >> $e');
    }
  }


  @override
  void initState() {
    remoteconfig();
    fetchData(); // 고정url 받으면 활성화
    _launchUpdate();
    initPlatformState();
    super.initState();
  }

  PageController pageController = PageController(
    initialPage: 1,
  );

/*--------------------------------------------------------------------*/
  Widget buildPageView() {
    return PageView(
      controller: pageController,
      children: <Widget>[_pages[0], _pages[1], _pages[2]],
    );
  }

  void pageChanged(int index) {
    setState(() {
      _selectedIndex = index;
      pageController.animateToPage(index,
          duration: const Duration(milliseconds: 500), curve: Curves.ease);
      pageController.jumpToPage(_selectedIndex);
    });
  }

/*--------------------------------------------------------------------*/

// flutter build apk —release —no-sound-null-safety
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    SystemChrome.setEnabledSystemUIMode(
        // 상단 상태바 제거
        SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    return WillPopScope(
        onWillPop: () {
          if (_selectedIndex == 1 && pageController.offset == _deviceData / 3) {
            //디바이스 widthPx / 3 의 값이 page offset 값과 같을때
            return _onBackKey();
          } else {
            // print(pageController.offset);
            // print(_deviceData);
            return _backToHome();
          }
        },
        child: Scaffold(
          body: buildPageView(),
          bottomNavigationBar: StyleProvider(
              // style: MyApp.themeNotifier.value == ThemeMode.dark
              style: isDarkMode ? Style_dark() : Style(),
              child: ConvexAppBar(
                items: [
                  TabItem(
                    icon: Image.asset('assets/history.png'),
                    title: '히스토리',
                  ),
                  TabItem(
                    // icon: MyApp.themeNotifier.value == ThemeMode.dark
                    icon: isDarkMode
                        ? Image.asset('assets/search_dark.png')
                        : Image.asset('assets/search.png'),
                  ),
                  TabItem(
                    title: '차트',
                    icon: Image.asset('assets/chart.png', width: 50),
                  ),
                ],
                onTap: pageChanged,
                height: 80,
                style: TabStyle.fixedCircle,
                curveSize: 100,
                elevation: 2.0,
                // backgroundColor: MyApp.themeNotifier.value == ThemeMode.dark
                backgroundColor: isDarkMode ? Colors.black : Colors.white,
              )),
        ));
  }

/* =======================================================*/

  Future<bool> _onBackKey() async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    return await showDialog(
      context: context,
      barrierDismissible: false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘)
      builder: (BuildContext context) {
        double c_height = MediaQuery.of(context).size.height;
        double c_width = MediaQuery.of(context).size.width;
        return Dialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Container(
              height: c_height * 0.18,
              width: c_width * 0.8,
              margin: const EdgeInsets.only(top: 20, bottom: 20),
              color: isDarkMode
                  ? const Color.fromRGBO(66, 66, 66, 1)
                  : Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: c_height * 0.115,
                    child: const Center(
                      child: Text('종료 하시겠습니까?', style: TextStyle(fontSize: 18)),
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
                          width: c_width * 0.4,
                          height: c_height * 0.08,
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
                                  child: const Text('종료',
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.red)))),
                        ),
                        Container(
                            margin: const EdgeInsets.only(right: 20),
                            color: isDarkMode
                                ? const Color.fromRGBO(66, 66, 66, 1)
                                : Colors.white,
                            width: c_width * 0.345,
                            height: c_height * 0.08,
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

  Future<bool> _backToHome() async {
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return TabPage();
        });
  }
}

void updateToast() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();
  var packageVersion = packageInfo.version;
  var currentVersion = MyApp.appVersion == packageVersion;
  Fluttertoast.showToast(
      msg: currentVersion ? '최신버전입니다.' : '업데이트를 위해 스토어로 이동합니다.',
      backgroundColor: Colors.grey,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER);
}

class Style_dark extends StyleHook {
  @override
  double get activeIconMargin => 10;

  @override
  double get activeIconSize => 30;

  @override
  double? get iconSize => 40;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return const TextStyle(fontSize: 14, color: Colors.white);
  }
}

class Style extends StyleHook {
  @override
  double get activeIconMargin => 10;

  @override
  double get activeIconSize => 30;

  @override
  double? get iconSize => 40;

  @override
  TextStyle textStyle(Color color, String? fontFamily) {
    return const TextStyle(fontSize: 14, color: Colors.black);
  }
}
