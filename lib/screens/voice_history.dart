// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'dart:ffi';
//
// class VoiceHistory extends StatefulWidget {
//   const VoiceHistory({Key? key}) : super(key: key);
//
//   @override
//   _VoiceHistoryState createState() => _VoiceHistoryState();
// }
//
// class _VoiceHistoryState extends State<VoiceHistory> {
//   AudioPlayer audioPlayer =AudioPlayer();
//   Duration duration =Duration();
//   Duration position=Duration();
//   bool playing =false;
//   double  _currentSliderValue=20.0;
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(20),
//       color: Colors.white,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         children:  [
//           Icon(Icons.play_circle_fill),
//          // Slider(value: value, onChanged: onChanged),
//           InkWell(
//             onTap: (){
//               getAudio();
//             },
//             child: Icon(
//                 (playing==false)
//                     ?Icons.play_circle_outline
//                     :Icons.pause_circle_outline,
//               size: 100,
//               color: Colors.blue,
//
//             ),
//           )
//
//
//         ],
//       ),
//     );
//   }
//    Slider1(){
//     double _currentSliderValue = 20;
//     return Slider.adaptive(
//       inactiveColor: Colors.pink,
//       min: 0.0,
//       value:duration.inSeconds.toDouble(),
//       max: duration.inSeconds.toDouble(),
//       onChanged: (double value) {
//         setState(() {
//           audioPlayer.seek(Duration(seconds: value.toInt()));
//         });
//       },
//     );
//   }
//   void getAudio()async{
//     var url='https://firebasestorage.googleapis.com/v0/b/app-pet-time.appspot.com/o/RyycU05T9lgq9KZCquRoK4SenDE2%2Fpets%2F6ZUx61groJi71sZ0dNLY%2Frecords%2F6ZUx61groJi71sZ0dNLY_record_2022-01-24%2019%3A03%3A15.243004.m4a?alt=media&token=cb263b30-4e38-4abc-9150-8b57ee2bb15d';
//     if(playing){
// var res =await audioPlayer.pause();
// if(res ==1){
//   setState(() {
//     playing=false;
//   });
// }
//     }
//     else{
//       var res =await audioPlayer.play(url,isLocal: true);
//       if(res==1){
//         setState(() {
//           playing=true;
//         });
//       }
//     }
//     audioPlayer.onDurationChanged.listen((Duration dd) {
//     setState(() {
//       duration=dd;
//     });
//     });
//     audioPlayer.onAudioPositionChanged.listen((Duration dd) {
//       position=dd;
//     });
//   }
// }
//
//
//
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   static const String _title = 'Flutter Code Sample';
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: _title,
//       home: Scaffold(
//         appBar: AppBar(title: const Text(_title)),
//         body: const MyStatefulWidget(),
//       ),
//     );
//   }
// }
//
// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);
//
//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }
//
// class _MyStatefulWidgetState extends State<MyStatefulWidget> {
//   double _currentSliderValue = 20;
//
//   @override
//   Widget build(BuildContext context) {
//     return Slider(
//       value: _currentSliderValue,
//       max: 100,
//       divisions: 5,
//       label: _currentSliderValue.round().toString(),
//       onChanged: (double value) {
//         setState(() {
//           _currentSliderValue = value;
//         });
//       },
//     );
//   }
// }
