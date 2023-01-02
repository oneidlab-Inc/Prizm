import 'dart:convert';
import 'dart:io';
import 'package:html/dom.dart';
import 'package:html/parser.dart';
import 'package:dio/dio.dart';
import 'package:pub_semver/pub_semver.dart';

class VersionCheck {
  /// 안드로이드 버전을 가져옵니다
  ///
  /// 구글은 API를 제공하지 않습니다
  Future<Version> _fetchAndroidVersion() async {
    final String bundle = '<com으로 시작하는 번들>';
    final String url = 'https://play.google.com/store/apps/details?id=$bundle';
    final dio = Dio();
    Response response = await dio.get(url);
    var document = parse(response.data);
    List<Element> list = document.querySelectorAll('.hAyfc .htlgb');
    String version = '';

    if (list.length >= 7) {
      version = list[7].text;
    } else {
      throw 'Result Not Found';
    }
    return Version.parse(version);
  }

  Future<Version> _fetchiOSVersion() async {
    final String bundle = '<com.으로 시작하는 번들>';
    final String url = 'https://itunes.apple.com/lookup?bundleId=$bundle';
    final dio = Dio();
    final Options options = Options(
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    );

    Response response = await dio.get(url, options: options);

    Map<String, dynamic> result = jsonDecode(response.data);

    String version = '';

    if (result['resultCount'] > 0 &&
        result['results'] != null &&
        result['results'].length > 0) {
      version = result['results'][0]['version'] ?? '';
    } else {
      throw 'Result Not Found';
    }

    return Version.parse(version);
  }

  /// 업데이트해야하는 버전을 사용하고 있는지 체크합니다
  ///
  /// [true]인 경우 스토어 버전과 다르므로 업데이트 해야합니다
  /// 스토어 버전이 항상 최신 버전일 것을 가정하여 [Version.allows]를 이용합니다
  Future<Map<String, dynamic>> checkUpdatable(String version) async {
    Version currentVersion = Version.parse(version);
    Version? storeVersion;

    if (Platform.isAndroid) {
      storeVersion = await _fetchAndroidVersion();
    } else if (Platform.isIOS) {
      storeVersion = await _fetchiOSVersion();
    }

// storeVersion이 Null이면 throw
    if (storeVersion == null) {
      throw 'Fetch store version failed';
    }
    Map<String, dynamic> result = {
      'needUpdate': false,
      'storeVersion': storeVersion,
    };

    if (currentVersion.major > storeVersion.major) {
      return result;
    }

    if (currentVersion.minor > storeVersion.minor) {
      return result;
    }

    if (currentVersion.patch > storeVersion.patch) {
      return result;
    }
// 완전히 같은 버전
    if (currentVersion.allows(storeVersion)) {
      return result;
    }

    result['needUpdate'] = true;
    return result;
  }
}