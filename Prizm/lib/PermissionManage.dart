import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionManage {
  Future<bool> requestMicPermission(BuildContext context) async {
    PermissionStatus status = await Permission.microphone.request();
    print('permission manage >> $status');

    if(!status.isGranted) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            print('status => $status');
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
          child: const Text('설정하기',
            style: TextStyle(
                color: Colors.blue
            ),
          ),
        )
      ],
    );
  }
}