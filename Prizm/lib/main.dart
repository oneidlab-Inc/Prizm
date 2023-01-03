import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:Prizm/vmidc.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:material_color_generator/material_color_generator.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:yaml/yaml.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Chart.dart';
import 'History.dart';
import 'Home.dart';
import 'VersionCheck.dart';


final navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {

  static final ValueNotifier<ThemeMode> themeNotifier =
  ValueNotifier(ThemeMode.light);

  const MyApp({Key? key}) : super(key: key);
  // static var history;
  // static var rank;
  // static var programs;
  // static var search;
  static var Uri;


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: themeNotifier,
        builder: (_, ThemeMode currentMode, __) {
          return MaterialApp(
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('en', ''),
              Locale('ko', ''),
            ],

            debugShowCheckedModeBanner: false, // Remove the debug banner
            navigatorKey: VMIDC.navigatorState, // 화면 이동을 위한 navigator
            theme: ThemeData(
                primarySwatch: generateMaterialColor(color: Colors.white)
            ),
            darkTheme: ThemeData.dark(),
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
// 처음에 나올 화면 지정
  int _selectedIndex = 1;

  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();

  var deviceData;
  var _deviceData;

  String? _deviceId;
  String? uid;

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
      uid = _deviceId;
    });
  }

  // Future<void> initPlatformState() async {
  //   if (Platform.isAndroid) {
  //     deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
  //   } else if (Platform.isIOS) {
  //     IosDeviceInfo info = await deviceInfoPlugin.iosInfo;
  //   }
  //   setState(() {
  //     _deviceData = deviceData;
  //   });
  // }

  double _readAndroidBuildData(AndroidDeviceInfo build) {
    return build.displayMetrics.widthPx;
  }

  var doc = loadYaml("YAML: YAML Ain't Markup Language");

/*----------------------------------------------------------------------------------------------------*/

  final VersionCheck _versionCheck = VersionCheck();

  Future _launchUpdate() async {

    var yaml;
    var version;
    rootBundle.loadString('pubspec.yaml').then((yamlValue) {
      Uri _url = Uri.parse('');
      yaml = loadYaml(yamlValue);
      version = yaml['version'];
// print(_versionCheck.checkUpdatable(version));


      // _versionCheck.checkUpdatable(version);
// 스토어 업로드 후 주소 받고 활성화

// if (version == version) {
//
// showDefaultDialog();
//
// } else {}

    });
  }

  void showDefaultDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          final isDarkMode = Theme.of(context).brightness == Brightness.dark;
          double c_height = MediaQuery.of(context).size.height;
          double c_width = MediaQuery.of(context).size.width;
          return
            Dialog(
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
                          child: Text(
                            '업데이트를 위해 스토어로 이동합니다.',
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
                            Container(
                                margin: const EdgeInsets.only(right: 20),
                                color: isDarkMode
                                    ? const Color.fromRGBO(66, 66, 66, 1)
                                    : Colors.white,
                                width: c_width * 0.345,
                                height: c_height * 0.08,
                                child: TextButton(
                                  onPressed: () {
                                    var yaml;
                                    var version;
                                    rootBundle
                                        .loadString('pubspec.yaml')
                                        .then((yamlValue) {
                                      Uri _url = Uri.parse('');
                                      yaml = loadYaml(yamlValue);
                                      version = yaml['version'];
                                      if (Platform.isAndroid) {
                                        showDefaultDialog();
                                        updateToast();
// _url = Uri.parse('http://www.naver.com');
// _url = Uri.parse('http://www.oneidlab.kr/app_check.html');
// 플레이스토어 주소 입력
                                      } else if (Platform.isIOS) {
                                        print('ios platform');
                                      }
                                      try {
                                        launchUrl(_url);
                                        print('launching $_url');
                                        canLaunchUrl(_url);
                                      } catch (e) {
                                        print('$_url 연결실패');
                                        print(e);
                                      }
// print(_url);
// print(yaml);
// print(version);
                                    });
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

  @override
  void initState() {
    _launchUpdate();
    initPlatformState();
    // MyApp.history  = Uri.parse('http://dev.przm.kr/przm_api/get_song_history/json?uid=');
    // MyApp.rank = Uri.parse('http://dev.przm.kr/przm_api/get_song_ranks');
    MyApp.Uri = Uri.parse('http://dev.przm.kr/przm_api/');
    print('type > ' + '${MyApp.Uri.runtimeType}');

    super.initState();
  }

  PageController pageController = PageController(
    initialPage: 1,
// keepPage: true,
  );

/*--------------------------------------------------------------------*/
  Widget buildPageView() {
    return PageView(
      controller: pageController,
      children: <Widget>[
        _pages[0],
        _pages[1],
        _pages[2],
      ],
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


    final deviceId = _deviceId;

    return WillPopScope(
        onWillPop: () {
          if (_selectedIndex == 1 &&
              this.pageController.offset == _deviceData / 3) {
            return _onBackKey();
          } else {
            return _backToHome();
          }
        },
        child: Scaffold(
          body: buildPageView(),
          bottomNavigationBar: StyleProvider(
              style: MyApp.themeNotifier.value == ThemeMode.dark
                  ? Style_dark()
                  : Style(),
              child: ConvexAppBar(
// type: BottomNavigationBarType.fixed, // bottomNavigationBar item이 4개 이상일 경우
// currentIndex: _selectedIndex, // 현재 선택된 index
                items: [
                  TabItem(
                    icon: Image.asset(
                      'assets/history.png',
                    ),
                    title: '히스토리',
                  ),
                  TabItem(
                    icon: MyApp.themeNotifier.value == ThemeMode.dark
                        ? Image.asset('assets/search_dark.png')
                        : Image.asset('assets/search.png'),
                  ),
                  TabItem(
                    title: '차트',
                    icon: Image.asset(
                      'assets/chart.png',
                      width: 50,
                    ),
                  ),
                ],
                onTap: pageChanged,
                height: 80,
                style: TabStyle.fixedCircle,
                curveSize: 100,
                elevation: 2.0,
                backgroundColor: MyApp.themeNotifier.value == ThemeMode.dark
                    ? Colors.black
                    : Colors.white,
              )),
        ));
  }

/* =======================================================*/

  Future<bool> _onBackKey() async {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    print('main_backKey');
    return await showDialog(
      context: context,
      barrierDismissible: false, //다이얼로그 바깥을 터치 시에 닫히도록 하는지 여부 (true: 닫힘, false: 닫히지않음)
      builder: (BuildContext context) {
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
                      child: Text(
                        '종료 하시겠습니까?',
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
                                    : Colors.black.withOpacity(0.1)
                            )
                        )
                    ),
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
                                              ? const Color.fromRGBO(94, 94, 94, 1)
                                              : Colors.black
                                              .withOpacity(0.1)
                                      )
                                  )
                              ),
                              margin: const EdgeInsets.only(left: 20),
                              child: TextButton(
                                  onPressed: () {
                                    exit(0);
                                  },
                                  child: const Text(
                                    '종료',
                                    style: TextStyle(
                                        fontSize: 20, color: Colors.red),
                                  )
                              )
                           ),
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
            )
        );
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

/* ========================================================*/

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // index는 item 순서로 0, 1, 2로 구성
    });
  }
}

void updateToast() {
  Fluttertoast.showToast(
      msg: '업데이트를 위해 스토어로 이동합니다.',
    backgroundColor: Colors.grey,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER
  );
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