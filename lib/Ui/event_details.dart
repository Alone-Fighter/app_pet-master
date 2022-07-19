import 'package:app_pet/Ui/edite_event.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../CustomWidgets/button_widget.dart';
import '../Provider/ApiService.dart';
import '../Utils/config.dart';
import '../constants.dart';

class EventDetails extends StatelessWidget implements ApiStatusLogin {
  var day;

  var month;

  var year;

  var description;

  var title;

  var documentId;

  EventDetails(
      {Key? key,
      required this.documentId,
      required this.year,
      required this.month,
      required this.day,
      required this.description,
      required this.title});

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore fs = FirebaseFirestore.instance;
    return Scaffold(body:
        SafeArea(child: Consumer<ApiService>(builder: (context, value, child) {
      value.apiListener(this);
      return SafeArea(
          child: Scaffold(
        appBar: AppBar(
          title: const Text('Detalles del evento'),
          backgroundColor: Colors.grey.shade100,
          foregroundColor: Colors.black,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/background.png"),
                  fit: BoxFit.fill,
                ),
              ),
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: Card(
                  shadowColor: Config.blue,
                  color: Colors.transparent,
                  child: Center(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  kNavigator(
                                      context,
                                      EditeEvent(
                                        selectedDate: '${month}/${day}/${year}',
                                        documentId: documentId, title: title, description: description,
                                      ));
                                },
                                icon: Icon(Icons.edit)),
                            IconButton(
                                onPressed: () {
                                  fs
                                      .collection('pets')
                                      .doc(value.myUser)
                                      .collection('pet')
                                      .doc(value.getSelectedPet)
                                      .collection('calendar')
                                      .doc(documentId)
                                      .delete();
                                  kNavigatorBack(context);
                                },
                                icon: Icon(Icons.delete)),
                          ],
                        ),
                        const SizedBox(
                          height: 70,
                        ),
                        ButtonHeaderWidget(
                          title: 'Fecha y hora :',
                          text: '${month}/${day}/${year}',
                          onClicked: () {},
                        ),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Row(
                              children: [
                                const Icon(Icons.event),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                Text(
                                  title,
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            )),
                        Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(Icons.short_text),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.03,
                                ),
                                Container(
                                  width:
                                  MediaQuery.of(context).size.width * 0.76,
                                  height:
                                MediaQuery.of(context).size.width * 0.2,
                                  child: Text(
                                    description,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ));
    })));
  }

  @override
  void accountAvailable() {
    // TODO: implement accountAvailable
  }

  @override
  void error() {
    // TODO: implement error
  }

  @override
  void inputEmpty() {
    // TODO: implement inputEmpty
  }

  @override
  void inputWrong() {
    // TODO: implement inputWrong
  }

  @override
  void login() {
    // TODO: implement login
  }

  @override
  void passwordWeak() {
    // TODO: implement passwordWeak
  }
}
