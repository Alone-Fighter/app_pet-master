import 'package:app_pet/Provider/MusicPlayer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config.dart';

class HistoryAudio extends StatelessWidget {
  var voicelink1;

   HistoryAudio({required this.voicelink1});

  @override
  Widget build(BuildContext context) {
    return Container(
color: Config.white,
      child: Dialog(
        elevation: 30,
      child: Container(
        width: MediaQuery.of(context).size.width*0.3,
        height: MediaQuery.of(context).size.height*0.4,
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5,vertical: 5),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height*0.25,

                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                    child: Image.asset('assets/images/index.jpg',fit: BoxFit.fill,))),
            Spacer(),
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height*0.12,
              child: Scaffold(
                body:    Consumer<MusicPlayer>(
                builder:
                (context, value2, child) {

              // value2.init();
              return Container(
                height: 70,
                margin:
                const EdgeInsets
                    .all(8),

                decoration: BoxDecoration(
                    color:
                    Config.white,
                    borderRadius:
                    BorderRadius
                        .circular(
                        10),
                    boxShadow: [
                      BoxShadow(
                          color: Colors
                              .black
                              .withOpacity(
                              .1),
                          offset:
                          const Offset(
                              0,
                              1),
                          spreadRadius:
                          1,
                          blurRadius:
                          3)
                    ]),
                child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        // value2.togglePlay(
                        //     voicelink1);
                        value2.audioState=="Playing"? value2.pauseAudio():value2.playAudio(voicelink1);
                      },
                      child:
                      Container(
                        margin:
                        const EdgeInsets
                            .all(10),
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(
                                25),
                            color: Config
                                .blue),
                        child: Icon(
                          value2.audioState!="Playing"
                              ? Icons
                              .play_arrow
                              : Icons
                              .pause,
                          color: Config
                              .white,
                        ),
                      ),
                    ),
                    Slider(
                      value: value2.position==null? 0 : value2.position!.inMilliseconds.toDouble() ,
                      // activeColor: darkPrimaryColor,
                      // inactiveColor: darkPrimaryColor.withOpacity(0.3),
                      onChanged: (value) {

                        value2.seekAudio(Duration(milliseconds: value.toInt()));

                      },
                      min: 0,
                      max:value2.totalDuration==null? 20 : value2.totalDuration!.inMilliseconds.toDouble() ,
                    ),
                    // Slider(
                    //   max: value2
                    //       .getDuration
                    //       .toDouble(),
                    //   value: value2
                    //       .getProgress
                    //       .toDouble(),
                    //   min: 0,
                    //   onChangeEnd:
                    //       (value) {
                    //     value2.seekTo(
                    //         value
                    //             .round());
                    //   },
                    //   onChanged:
                    //       (value) {},
                    // )
                  ],
                ),
              );
                }
              ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
