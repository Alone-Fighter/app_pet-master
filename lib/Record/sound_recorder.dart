import 'package:app_pet/Provider/ApiService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound_lite/public/flutter_sound_recorder.dart';
import 'package:app_pet/Record/globals.dart' as globals;
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class SoundRecorder {
  final uuid = const Uuid();

  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialised = false;
  String currentRecordingId = "";

  bool get isRecording => _audioRecorder?.isRecording ?? false;

  void generateNewRecordingId() => (currentRecordingId = uuid.v4());

  Future<String> get currentRecordingPath async =>
      "${(await globals.storageDir).path}/$currentRecordingId.aac";

  Future<void> init() async {
    _audioRecorder = FlutterSoundRecorder();

    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException('Microphone permission');
    }

    await _audioRecorder!.openAudioSession();
    _isRecorderInitialised = true;
  }

  void dispose() {
    if (!_isRecorderInitialised) return;

    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialised = false;
  }

  Future<void> _record() async {
    if (!_isRecorderInitialised) return;
    generateNewRecordingId();

    await _audioRecorder!.startRecorder(toFile: await currentRecordingPath);
  }

  Future<void> _stop(BuildContext context) async {
    if (!_isRecorderInitialised) return;
    await _audioRecorder!.stopRecorder();
  }

  Future<void> toggleRecording(BuildContext context) async =>
      await (_audioRecorder!.isStopped ? _record() : _stop(context));
}
