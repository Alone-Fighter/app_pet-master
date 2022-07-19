// import 'package:flutter/cupertino.dart';
// import 'package:flutter_sound_lite/public/flutter_sound_player.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';


class MusicPlayer extends ChangeNotifier {

  Duration? totalDuration;
  Duration? position;
  String? audioState;

  MusicPlayer(){
    initAudio();
  }

  AudioPlayer audioPlayer = AudioPlayer();

  initAudio(){
    audioPlayer.onDurationChanged.listen((updatedDuration) {
      totalDuration = updatedDuration;
      notifyListeners();
    });

    audioPlayer.onAudioPositionChanged.listen((updatedPosition) {
      position = updatedPosition;
      notifyListeners();
    });

    audioPlayer.onPlayerStateChanged.listen((playerState) {

      if(playerState == PlayerState.STOPPED)
        audioState = "Stopped";
      if(playerState==PlayerState.PLAYING)
        audioState = "Playing";
      if(playerState == PlayerState.PAUSED)
        audioState = "Paused";
      print(playerState);
      notifyListeners();
    });
  }

  playAudio(String link){
    audioPlayer.play(link);
  }


  pauseAudio(){
    audioPlayer.pause();
  }

  stopAudio(){
    audioPlayer.stop();
  }

  seekAudio(Duration durationToSeek){
    audioPlayer.seek(durationToSeek);
  }

}




// class MusicPlayer extends ChangeNotifier {
//
//   FlutterSoundPlayer? flutterSoundPlayer;
//
//   bool playing = false;
//   bool ispause = false;
//   int duration = 0;
//   int progress = 0;
//   bool get isPlay => playing;
//   int get getDuration => duration;
//   int get getProgress => progress;
//
//   init() async {
//     flutterSoundPlayer = FlutterSoundPlayer();
//     await flutterSoundPlayer!.openAudioSession();
//   }
//
//   togglePlay(String link) async {
//     if(flutterSoundPlayer!.isPlaying){
//       playing = false;
//       // stop();
//       pause();
//       notifyListeners();
//     }else{
//       playing = true;
//       play(link, () {
//         playing = false;
//         notifyListeners();
//       });
//       notifyListeners();
//     }
//   }
//
//   seekTo(int p){
//     if(flutterSoundPlayer!.isPlaying){
//       flutterSoundPlayer?.seekToPlayer(Duration(seconds: p));
//     }
//   }
//
//   play(String link , VoidCallback ween) async {
//     await flutterSoundPlayer?.startPlayer(fromURI: link, whenFinished: ween);
//     flutterSoundPlayer!.setSubscriptionDuration(const Duration(milliseconds: 100));
//     flutterSoundPlayer!.onProgress!.listen((event) {
//       duration = event.duration.inSeconds;
//       progress = event.position.inSeconds;
//       notifyListeners();
//     });
//   }
//   pause()async{
//     flutterSoundPlayer?.pausePlayer();
//   }
//
//   stop(){
//     if(flutterSoundPlayer!.isPlaying){
//       flutterSoundPlayer?.stopPlayer();
//     }
//   }
//
//   disposeR() {
//     flutterSoundPlayer!.closeAudioSession();
//     flutterSoundPlayer = null;
//   }
//
// }