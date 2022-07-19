import 'package:app_pet/Model/pet.dart';
import 'package:app_pet/Provider/MusicPlayer.dart';
import 'package:app_pet/Utils/history_audio.dart';
import 'package:app_pet/Utils/history_image.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/screens/voice_history.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/Model/tips.dart';
import 'package:app_pet/Model/historyM.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/screens/pet_reg2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../constants.dart';

class History extends StatelessWidget {
  var petId;
  String mode;

  History(String this.petId, this.mode);

  late BuildContext context;

  showSnackBar(String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    this.context = context;
    String city = 'test';

//------------------------------------------------------------------------//

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          toolbarHeight: 40,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              const Spacer(
                flex: 1,
              ),
              Text(
                'Historial',
                style: TextStyle(color: Config.gray, fontSize: 15),
              ),
              const Spacer(
                flex: 1,
              ),
            ],
          ),
        ),
        body: Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width * 0.8,
          child: Consumer<ApiService>(
            builder: (context, value, child) {
              return StreamBuilder<QuerySnapshot>(
                  stream: context.read<ApiService>().getAllHistory(petId, mode),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print('hasError');
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: Waitting(),
                      );
                    }

                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return Center(
                          child: Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(.1),
                                  borderRadius: BorderRadius.circular(15)),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.all(16),
                              child: const Text(
                                'No Contact...',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              )),
                        );
                      }
                      // return Text('data');

                      return SingleChildScrollView(
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                child: SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    width:
                                        MediaQuery.of(context).size.width * 0.8,
                                    child: MaterialApp(
                                      debugShowCheckedModeBanner: false,
                                      home: DefaultTabController(
                                        length: 4,
                                        child: Scaffold(
                                          appBar: AppBar(
                                            backgroundColor: Config.white,
                                            toolbarHeight: 0,
                                            // title: Text('hs'),
                                            bottom: const TabBar(
                                              tabs: [
                                                Tab(
                                                    icon: Icon(
                                                  Icons.comment_outlined,
                                                  color: Colors.grey,
                                                )),
                                                Tab(
                                                    icon: Icon(
                                                  Icons.mic,
                                                  color: Colors.grey,
                                                )),
                                                Tab(
                                                    icon: Icon(
                                                  Icons.image_outlined,
                                                  color: Colors.grey,
                                                )),
                                                Tab(
                                                    icon: Icon(
                                                  Icons.calendar_today_rounded,
                                                  color: Colors.grey,
                                                )),
                                              ],
                                            ),
                                          ),
                                          body: TabBarView(
                                            children: [
                                              comment(
                                                  context, snapshot.data!.docs,petId,mode),
                                              voice(
                                                  context, snapshot.data!.docs),
                                              image(
                                                  context, snapshot.data!.docs),
                                              nextDate(
                                                  context, snapshot.data!.docs),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      );
                    }

                    return const Center(
                      child: Waitting(),
                    );
                  });
            },
          ),
        ),
      ),
    );
  }
}

Widget comment(BuildContext context, List<QueryDocumentSnapshot> snapshot,petId,mode) {
  return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(top: 5),
      children: snapshot.map((DocumentSnapshot document) {
       // print(document.data()!);
        historyData HistoryData =
            historyData.fromJson(document.data()! as Map<String, dynamic>);

        return Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  'Comments',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Container(
              margin: const EdgeInsets.all(15),
              child: Row(
                children: [

                  Card(
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width*0.5,
                      alignment: Alignment.center,
                      child: Text(HistoryData.comment),
                    ),
                  ),
                  IconButton(onPressed: (){
                    //onDelete();

                    FirebaseAuth auth = FirebaseAuth.instance;
                    FirebaseFirestore.instance.collection('pets').doc(auth.currentUser!.uid).collection('pet').doc(petId).collection(mode).doc(document.id).delete();

                  }, icon: Icon(Icons.delete_outline_outlined,color: Colors.red,)),
                ],
              ),
            ),
          ],
        );
      }).toList());
}

Widget voice(BuildContext context, List<QueryDocumentSnapshot> snapshot) {
  return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(top: 5),
      children: snapshot.map((DocumentSnapshot document) {
        historyData HistoryData =
            historyData.fromJson(document.data()! as Map<String, dynamic>);
        return RawMaterialButton(
          onPressed: () {
            kNavigator(
                context,
                HistoryAudio(
                  voicelink1: HistoryData.record.toString(),
                ));
           // print(HistoryData.record.toString());
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 150,
            decoration: BoxDecoration(
                color: Config.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      offset: const Offset(0, 1),
                      spreadRadius: 1,
                      blurRadius: 3)
                ]),
            child: (HistoryData.record=='-1')
              ?const Center(child: Text('no voice'),)
                :Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Config.blue),
                  child: Icon(
                    Icons.play_arrow,
                    color: Config.white,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.lightBlue.shade100),
                          child: const Icon(
                            Icons.calendar_today_rounded,
                            size: 20,
                            color: kDarkBlue,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 100,
                          child: Text(HistoryData.time
                              .toDate()
                              .toString()
                              .substring(0, 11)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.lightBlue.shade100),
                          child: const Icon(
                            Icons.access_time,
                            size: 20,
                            color: kDarkBlue,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: 100,
                            child: Text(HistoryData.time
                                .toDate()
                                .toString()
                                .substring(11, 18)))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      }).toList());
}

Widget image(BuildContext context, List<QueryDocumentSnapshot> snapshot) {
  return ListView(
    scrollDirection: Axis.vertical,
    padding: const EdgeInsets.only(top: 5),
    children: snapshot.map((DocumentSnapshot document) {
      historyData HistoryData =
          historyData.fromJson(document.data()! as Map<String, dynamic>);
      return Container(
        margin: const EdgeInsets.all(10),
        alignment: Alignment.center,
        // height: MediaQuery.of(context).size.height * 0.15,
        // width: MediaQuery.of(context).size.width * 0.1,
        child: RawMaterialButton(
          onPressed: () {
           // print(HistoryData.address.toString());
            kNavigator(context,
                HistoryImage(HistoryImage1: HistoryData.address.toString()));
          },
          child: Card(
            elevation: 20,
            child: (HistoryData.address=='-1')
              ?Center(child: Text('no image'),)
                :Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.height * 0.1,
                  margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      HistoryData.address,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.1,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.lightBlue.shade100),
                          child: const Icon(
                            Icons.calendar_today_rounded,
                            size: 20,
                            color: kDarkBlue,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                          width: 100,
                          child: Text(HistoryData.time
                              .toDate()
                              .toString()
                              .substring(0, 11)),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          width: 30,
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.lightBlue.shade100),
                          child: const Icon(
                            Icons.access_time,
                            size: 20,
                            color: kDarkBlue,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            width: 100,
                            child: Text(HistoryData.time
                                .toDate()
                                .toString()
                                .substring(11, 18)))
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    }).toList(),
  );
}

Widget nextDate(BuildContext context, List<QueryDocumentSnapshot> snapshot) {
  return ListView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.only(top: 5),
      children: snapshot.map((DocumentSnapshot document) {
       // print(document.data()!);
        historyData HistoryData =
            historyData.fromJson(document.data()! as Map<String, dynamic>);

        return Column(
          children: [
            Container(
                margin: const EdgeInsets.only(top: 15),
                child: const Text(
                  ' Planificación',
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
            Container(
              margin: const EdgeInsets.all(15),
              child: Card(
                child: Container(
                  margin: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height * 0.06,
                  alignment: Alignment.center,
                  child: Row(
                    children: [
                      const Icon(
                        Icons.calendar_today_rounded,
                        color: kDarkBlueHeader,
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        HistoryData.year +
                            '/' +
                            HistoryData.month +
                            '/' +
                            HistoryData.day,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,

                        ),
                      ),
                      const Spacer(),
                      //Icon(Icons.delete_outline_outlined,color: kDarkBlueHeader,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }).toList());
}
