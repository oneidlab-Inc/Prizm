// ignore_for_file: avoid_print, prefer_const_constructors, curly_braces_in_flow_control_structures, avoid_single_cascade_in_expression_statements, slash_for_doc_comments
import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';
import 'package:ffi/ffi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'Search_Result.dart';
import 'package:logger/logger.dart';
import 'Notfound_bottom.dart';
import 'wavbuf.dart';

// final DynamicLibrary nativeLib = DynamicLibrary.open('libnative.so'); //Android
// final DynamicLibrary nativeLib = DynamicLibrary.process(); //IOS

final DynamicLibrary nativeLibAnd = DynamicLibrary.open('libnative.so');
final DynamicLibrary nativeLibIos = DynamicLibrary.process();
final platform = Platform.isAndroid == true;

int Function(Pointer<Int16>, int, Pointer<Uint8>) pcm_to_dna = platform
    ? nativeLibAnd.lookup<NativeFunction<Int32 Function(Pointer<Int16>, Int32, Pointer<Uint8>)>>("pcm_to_dna").asFunction()
    : nativeLibIos.lookup<NativeFunction<Int32 Function(Pointer<Int16>, Int32, Pointer<Uint8>)>>("pcm_to_dna").asFunction();


const srate = 22050;
const pcmLen = 74656; //3.39sec
const pcmHop = 22050 * 2; //2sec

class VMIDC {

  final FlutterSoundRecorder _recorder =
  FlutterSoundRecorder(logLevel: Level.error);
  var recCtrl = StreamController<Food>();
  late StreamSubscription _audioStream;
  late StreamSink<List> toStream;
  final WaveBuf _wbuf = WaveBuf();
  final Pointer<Uint8> _pcm = malloc.allocate<Uint8>(pcmLen * 2);
  final Pointer<Uint8> _dna = malloc.allocate<Uint8>(1024);
  late Socket _sock;
  final Stopwatch _watch = Stopwatch();

  String? _id;
  int? _score;


  Future<bool> init({
        required String ip,
        required int port,
        required StreamSink<List> sink}) async {
    print('vmid.init()');
    toStream = sink;

    if (await _connect(ip, port) == false) return false;

    _sock.listen((Uint8List msg) async {
      if (msg[0] == 1) {  //search
        if (msg[1] != 1)  //true
          toStream.add(['error']);
        else {
          int n = msg[2];
          if (n == 1) {
            int score = msg[3];
            _score = score;
            _id = String.fromCharCodes(msg, 4, msg.length);
            print('>>>> id : $_id, score : $score');
            toStream.add([_id!, score]);
          }
        }
      }
      if (msg[0] == 4) {
        await _sock.close();
        _sock.destroy();
      }
    },
        onError: (e) => print('err: ${e.toString()}'),
        onDone: () => print('onDone'));
    await _recorder.openAudioSession();
    _audioStream = recCtrl.stream.listen((buffer) async {
      if (buffer is FoodData) {
        _wbuf.push(buffer.data!);
        if (_wbuf.length >= pcmLen * 2) {
          _wbuf.read(pcmLen * 2, _pcm);
          if (_id == null) {
            int len = pcm_to_dna(_pcm.cast<Int16>(), pcmLen, _dna.cast<Uint8>());
            _sendQuery(len);
            _wbuf.pop(pcmHop * 2);
          }
        }
      }
    });
    return true;
  }

  bool isRunning() {
    return _recorder.isRecording;
  }

  Future<void> start() async {
    if (_recorder.isRecording) return;
    _id = null;
    _score = null;
    print('vmid.start()');
    await _recorder.startRecorder(
      toStream: recCtrl.sink,
      codec: Codec.pcm16,
      numChannels: 1,
      sampleRate: srate,
    );
    _watch.start();
  }

  /* ============== context 없이 화면 이동 하기위해 main.dart와 key로 연결 ============== */
  static final GlobalKey<NavigatorState> navigatorState = GlobalKey<NavigatorState>();
  /* ============================================================================ */

  Future<bool> stop() async {

    if (!_recorder.isRecording) return false;

    if (_id != null && _score! >= 33) {
      String id = _id!;
      navigatorState.currentState?.push(//얻어온 context로 id값 가지고 push
          MaterialPageRoute(builder: (context) => Result(id: id)));
    } else {
      print('NOT FOUND');
      navigatorState.currentState
          ?.push(MaterialPageRoute(builder: (context) => Notfound_Bottom()));
    }
    print('vmid.stop()');
    await _recorder.stopRecorder();
    _wbuf.clear();
    _watch.stop();
    return true;
  }

  Future<void> dispose() async {
    print('vmid.dispose()');
    _sock.add([4]); //finish
    if (_recorder.isRecording) await stop();
    _audioStream.cancel();
    _recorder.closeAudioSession();
    recCtrl.close();
  }

  Future<bool> _connect(String ip, int port) async {
    try {
      _sock = await Socket.connect(ip, port, timeout: Duration(seconds: 5));
      stop();
    } on Exception catch (e) {
      print(e.toString());
      return false;
    }
    _sock.add(Uint8List.fromList('vmid333'.codeUnits));
    return true;
  }

  void _sendQuery(int len) {
    print('_sendQuery($len) ${_watch.elapsedMilliseconds}ms');
    var msg = Uint8List(1 + 1 + 4 + len);
    msg[0] = 1; //search
    msg[1] = 1; //rank
    msg.buffer.asByteData()..setInt32(2, len, Endian.little);
    for (int i = 0; i < len; i++) msg[6 + i] = _dna[i];
    _sock.add(msg);
    print("sendQuery");
    Timer(const Duration(seconds: 10), () {
      stop();
    });
  }
}