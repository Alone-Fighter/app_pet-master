import 'package:app_pet/Model/des_m.dart';
import 'package:app_pet/Utils/history_audio.dart';
import 'package:app_pet/Utils/history_image.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:flutter/material.dart';
import 'package:app_pet/Model/historyM.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../constants.dart';

class DesparasitHistory extends StatelessWidget {
  var petId;
  String mode;
  FirebaseAuth auth = FirebaseAuth.instance;
  var whichOne;

  DesparasitHistory(String this.petId, this.mode, this.whichOne);

  late BuildContext context;

  showSnackBar(String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
  onDelete(){
    FirebaseAuth auth = FirebaseAuth.instance;

    FirebaseFirestore.instance.collection('pets').doc(auth.currentUser!.uid).collection('pet').doc(petId).collection(mode).doc().delete();

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
                  stream: context.read<ApiService>().getAllHistorydes(petId, mode,whichOne),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      print('hasError');
                      return const Text('Algo salió mal');
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
                              padding: const EdgeInsets.all(14),
                              child: const Text(
                                'Sin contacto...',
                                style: TextStyle(
                                    color: Colors.black, fontSize: 16),
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
                                        length: 3,
                                        child: Scaffold(
                                          body: Column(
                                            children: [
                                              comment(
                                                  context,
                                                  snapshot.data!.docs,
                                                  whichOne,petId,mode),
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

Widget comment(
    BuildContext context, List<QueryDocumentSnapshot> snapshot, whichOne,petId,mode) {
  return Container(
    height: MediaQuery.of(context).size.height * 0.7,
    child: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(top: 5),
        children: snapshot.map((DocumentSnapshot document) {

         // print(document.id);
         //  Des des = Des.fromJson(document.data()! as Map<String, dynamic>);

          return Column(
            children: [
              Container(
                  margin: const EdgeInsets.only(top: 15),
                  child: RawMaterialButton(
                    onPressed: () { print(document.id); },
                    child: const Text(
                      'Desparasitacion',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                        child: (whichOne == '1')
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'PARASITOS INTERNOS : ' + document.get('internos'),
                                    style: const TextStyle(
                                      color: kDarkBlueHeader,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
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
                                        child: Text(document.get('year1') +
                                            '/' +
                                            document.get('month1') +
                                            '/' +
                                            document.get('day')),
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
                                          child: Text(document.get('time1')
                                              .toDate()
                                              .toString()
                                              .substring(11, 18)))
                                    ],
                                  ),
                                ],
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'PARASITOS EXTERNOS : ' + document.get('externnos'),
                                    style: const TextStyle(
                                        color: kDarkBlueHeader,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
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
                                        child: Text(document.get('year2') +
                                            '/' +
                                            document.get('month2') +
                                            '/' +
                                            document.get('day2')),
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
                                          child: Text(document.get('time2')
                                              .toDate()
                                              .toString()
                                              .substring(11, 18)))
                                    ],
                                  ),
                                ],
                              ),
                      ),
                    ),
                    IconButton(onPressed: (){
                      //onDelete();
                      FirebaseAuth auth = FirebaseAuth.instance;
                      FirebaseFirestore.instance.collection('pets').doc(auth.currentUser!.uid).collection('pet').doc(petId).collection(mode).doc(document.id).delete();

                    }, icon: Icon(Icons.delete_outline_outlined,color: Colors.red,))
                  ],
                ),
              ),
            ],
          );
        }).toList()),
  );
}

