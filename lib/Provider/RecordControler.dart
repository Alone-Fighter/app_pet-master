import 'dart:io';

import 'package:app_pet/Utils/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:just_audio/just_audio.dart' as ap;


class RecordController extends ChangeNotifier {
  final _audioRecorder = Record();
  FlutterSoundPlayer? flutterSoundPlayer;
  ap.AudioSource? audioSource;

  String path = '';
      // '${getApplicationDocumentsDirectory()}/voice_record_${DateTime.now()}.m4a';

  bool isRecorded = false;
  bool isRecordingV = false;
  bool isPlaying = false;

  Future<bool> isRecording() async {
    bool b = await _audioRecorder.isRecording();
    isRecordingV = b;
    return b;
  }

  record() async {
    if (await _audioRecorder.hasPermission()) {
      if (await isRecording()) {
        final paths = await _audioRecorder.stop();
        path = paths.toString();
        flutterSoundPlayer = FlutterSoundPlayer();
        await flutterSoundPlayer!.openAudioSession();
        isRecorded = true;
        isRecordingV = false;
      } else {
        isRecorded = false;
        isRecordingV = true;
        _audioRecorder.start(
          encoder: AudioEncoder.AAC,
          bitRate: 128000,
          samplingRate: 44100,
        );
      }
      notifyListeners();
    }
  }

  disposeR() {
    isRecorded = false;
    isRecordingV = false;
    _audioRecorder.dispose();
    flutterSoundPlayer!.closeAudioSession();
    flutterSoundPlayer = null;
  }

  delete(){
    File file = File(path);
    try{
      file.delete();
    }catch (e){
      print(e.toString());
    }
  }

  _play(VoidCallback ween) async {
    await flutterSoundPlayer!.startPlayer(
    fromURI: path,
        whenFinished: ween
    );
    isPlaying = true;
    notifyListeners();
  }

  togglePlayer() async {
    if (flutterSoundPlayer!.isPlaying) {
      await flutterSoundPlayer!.stopPlayer();
      isPlaying = false;
      notifyListeners();
    } else {
      _play(() {
        isPlaying = false;
        notifyListeners();
      });
    }
  }

}

class RecordDialog extends StatelessWidget {
  const RecordDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<ApiService, RecordController>(
      builder: (context, value, value2, child) {
        return Dialog(
          alignment: Alignment.center,
          child: SizedBox(
            height: 400,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: InkWell(
                    onTap: () {
                      value2.record();
                    },
                    child: Center(
                      child:  Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(75),
                            color: value2.isRecordingV ? Config.blue : value2.isRecorded ? Colors.green :Config.gray),
                        child: Icon(
                          value2.isRecordingV ? Icons.stop : value2.isRecorded ? Icons.mic : Icons.mic ,
                          // Icons.mic,
                          color: Config.white,
                          size: 50,
                        ),
                      ),
                    )
                  ),
                ),
                Container(
                  height: 30,
                  alignment: Alignment.center,
                  child: Text(value2.isRecordingV ? 'Grabación' : value2.isRecorded ? 'Grabado' : ''),
                ),
                Expanded(
                    flex: 1,
                    child: Row(
                      children: [
                        Expanded(
                            child: TextButton(
                          child: const Text('enviar'),
                          onPressed: () {
                            if(value2.isRecorded){
                              value.setRecordPath(value2.path);
                              value2.disposeR();
                              Navigator.of(context).pop();
                            }
                          },
                        )),
                        value2.isRecorded
                            ? Expanded(
                                child: IconButton(
                                onPressed: () {
                                  value2.togglePlayer();
                                },
                                icon: Icon(
                                  value2.isPlaying
                                      ? Icons.stop
                                      : Icons.play_arrow,
                                  color: Config.gray,
                                  size: 30,
                                ),
                              ))
                            : Container(),
                        Expanded(
                            child: TextButton(
                          child: const Text('cancelar'),
                          onPressed: () {
                            value2.delete();
                            value2.disposeR();
                            Navigator.of(context).pop();
                          },
                        ))
                      ],
                    ))
              ],
            ),
          ),
        );
      },
    );
  }
}
