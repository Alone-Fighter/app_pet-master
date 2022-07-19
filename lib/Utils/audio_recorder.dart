import 'package:app_pet/screens/directory.dart';
import 'package:record/record.dart';

class Recorder {

  final _audioRecorder = Record();

 Future<bool> isRecording() async{
  return await _audioRecorder.isRecording();
 }

 record(String path){
   _audioRecorder.start(
     path: '$path/voice_record_${DateTime.now()}.m4a',
     encoder: AudioEncoder.AAC,
     bitRate: 128000,
     samplingRate: 44100,
   );
 }

 dispose(){
   _audioRecorder.dispose();
 }

  stop(){
    _audioRecorder.stop();
  }

  pause(){
    _audioRecorder.pause();
  }

  resume(){
   _audioRecorder.resume();
  }


}