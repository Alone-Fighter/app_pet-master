import 'package:app_pet/CustomWidgets/calendar.dart';
import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/Model/events.dart';
import 'package:app_pet/Model/product.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/dropdown_options.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/vet_search.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/screens/pet_reg2.dart';
import 'package:app_pet/screens/vaccination.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class VetEvents extends StatelessWidget implements ApiStatusLogin {
  VetEvents({Key? key}) : super(key: key);
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
    PageController pageController = PageController(
        //initialPage: 0,
        keepPage: true);
//------------------------------------------------------------------------//

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        // leading: Builder(
        //   builder: (context) => IconButton(
        //     icon: const Icon(
        //       Icons.menu_rounded,
        //       size: 35,
        //     ),
        //     onPressed: () => Scaffold.of(context).openDrawer(),
        //   ),
        // ),
        backgroundColor: kVacsanBlue,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Eventos',
              style: TextStyle(color: Config.white, fontSize: 21),
            ),
            const Spacer(
              flex: 1,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.45,
              height: MediaQuery.of(context).size.height * 0.04,
              decoration: BoxDecoration(
                  color: Config.white,
                  border: Border.all(color: Colors.grey.shade300)),
              child: Row(
                children: [
                  RawMaterialButton(
                    onPressed: () async {
                      showSearch(
                          context: context, delegate: SearchVetSection());
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.322,
                    ),
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: (const Icon(
                        Icons.search,
                        color: kLightBlue,
                      )))
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: myDrawer(),
      ),
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage("assets/images/vacsinate.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<ApiService>(
          builder: (context, value, child) {
            value.apiListener(this);
            //////////////////////////////////should change with tips api
            value.getAllVetEvents();
            return StreamBuilder<QuerySnapshot>(
                stream: context.read<ApiService>().getAllVetEvents(),
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
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )),
                      );
                    }
                    // return Text('data');

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.symmetric(horizontal: 22),
                            child: Row(
                              children: [
                                Text(
                                  '',
                                  style: TextStyle(
                                      color: Config.white, fontSize: 21),
                                ),
                                const Spacer(
                                  flex: 1,
                                ),
                                Container(
                                  alignment: Alignment.topCenter,
                                  height: 50,
                                  child: const Image(
                                    image:
                                        AssetImage('assets/images/wlogo.png'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.2,
                          ),
                          Column(children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.3,
                              child: PageView(
                                onPageChanged: (val) {
                                  //currentPage = val;

                                  EventsData eventData = EventsData.fromJson(
                                      snapshot.data!.docs.elementAt(val).data()
                                          as Map<String, dynamic>);


                                  print('change ${val}');
                                },
                                controller: pageController,
                                scrollDirection: Axis.horizontal,
                                // padding: const EdgeInsets.only(top: 5),
                                children: snapshot.data!.docs
                                    .map((DocumentSnapshot document) {
                                  EventsData eventData = EventsData.fromJson(
                                      document.data()! as Map<String, dynamic>);
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.02,
                                                vertical: 13),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      eventData.title,
                                                      style: TextStyle(
                                                          color: Colors
                                                              .grey.shade700,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 15,
                                                ),
                                                RawMaterialButton(
                                                  onPressed: () async {
                                                    final url=eventData.link;
                                                    if(await canLaunch(url) ){
                                                      await launch(url);
                                                    }
                                                  },
                                                  child: Row(
                                                    children: [
                                                      ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                15),
                                                        child: Container(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.6,
                                                          height: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .height *
                                                              0.2,
                                                          child: Image.network(
                                                              eventData.image),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 5,
                                                      ),
                                                      Container(
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.32,
                                                        height:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                0.2,
                                                        child: Center(
                                                          child: Text(
                                                            eventData.details,
                                                            style: TextStyle(
                                                                color: Colors.grey
                                                                    .shade700,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 12),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          //
                                        ],
                                      ));
                                }).toList(),
                              ),
                            ),
                          ]),
                          Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    EventsData eventData = EventsData.fromJson(
                                        snapshot.data!.docs
                                            .elementAt(index)
                                            .data() as Map<String, dynamic>);
                                    {
                                      return Container(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.3,
                                          child: Column(
                                            children: [
                                              Container(
                                                margin: EdgeInsets.symmetric(
                                                  horizontal:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width *
                                                          0.02,
                                                ),
                                                child: Column(
                                                  children: [
                                                    RawMaterialButton(
                                                      onPressed: () {
                                                        pageController
                                                            .jumpToPage(index);
                                                      },
                                                      child: Container(
                                                        decoration:
                                                            BoxDecoration(
                                                          boxShadow: const [
                                                            BoxShadow(
                                                              color:
                                                                  Colors.grey,
                                                              blurRadius: 4,
                                                              offset: Offset(3,
                                                                  3), // Shadow position
                                                            ),
                                                          ],
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                          color: Colors.white,
                                                        ),
                                                        height: 90,
                                                        width: 100,
                                                        child: Image.network(
                                                          eventData.image,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Text(
                                                      eventData.title,
                                                      style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 18),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              //
                                            ],
                                          ));
                                    }
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
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
    );
  }

  @override
  void accountAvailable() {
    ModeSnackBar.show(
        context, 'you signed in before with this email', SnackBarMode.error);
  }

  @override
  void error() {
    ModeSnackBar.show(context, 'Algo sale mal', SnackBarMode.error);
  }

  @override
  void inputEmpty() {
    ModeSnackBar.show(
        context, 'por favor llene toda la caja', SnackBarMode.warning);
  }

  @override
  void inputWrong() {
    ModeSnackBar.show(
        context,
        'el correo electrónico o la contraseña son incorrectos',
        SnackBarMode.warning);
  }

  @override
  void login() {
    kNavigatorBack(context);
    kNavigator(context, PetReg2());
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'use una contraseña más fuerte por favor',
        SnackBarMode.warning);
  }
}
