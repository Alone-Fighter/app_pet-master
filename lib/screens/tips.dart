
import 'dart:io';

import 'package:app_pet/CustomWidgets/calendar.dart';
import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/Model/tips.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/dropdown_options.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/screens/pet_reg2.dart';
import 'package:app_pet/screens/vaccination.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/link.dart';

import '../constants.dart';

class Tips extends StatefulWidget {
  Tips({Key? key}) : super(key: key);

  @override
  State<Tips> createState() => _TipsState();
}

class _TipsState extends State<Tips> implements ApiStatusLogin {
  late BuildContext context;

  showSnackBar(String text) {
    SnackBar snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  String dropdownValue = 'todo';

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
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              size: 35,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: kLightBlue,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Tips y\nEventos',
              style: TextStyle(color: Config.white, fontSize: 21),
            ),
            const Spacer(
              flex: 1,
            ),
            const Text(
              '  ',
              style: TextStyle(color: Colors.white),
            ),
            DropDownCity(),
            // Container(
            //   width: MediaQuery.of(context).size.width * 0.45,
            //   height: MediaQuery.of(context).size.height * 0.04,
            //   decoration: BoxDecoration(
            //       color: Config.white,
            //       border: Border.all(color: Colors.grey.shade300)),
            //   child: Row(
            //     children: [
            //       Container(
            //         width: MediaQuery.of(context).size.width * 0.322,
            //         child: TextFormField(
            //             // controller: value.searchController,
            //             ),
            //       ),
            //       IconButton(
            //           onPressed: () {},
            //           icon: (const Icon(
            //             Icons.search,
            //             color: kLightBlue,
            //           )))
            //     ],
            //   ),
            // ),
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
            image: AssetImage("assets/images/direct.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<ApiService>(
          builder: (context, value, child) {
            value.apiListener(this);
            //////////////////////////////////should change with tips api
            value.getAllPets();
            value.getAllEvents();
            return StreamBuilder<QuerySnapshot>(
                stream:(dropdownValue == 'todo') ? context.read<ApiService>().getAllEvents() : context.read<ApiService>().getcitytips(dropdownValue),
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
                                  'Categorias',
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
                            height: MediaQuery.of(context).size.height * 0.03,
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.17,
                                child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  padding: const EdgeInsets.only(top: 5),
                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    tipsData tipData = tipsData.fromJson(
                                        document.data()!
                                            as Map<String, dynamic>);
                                    return Container(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.4,
                                        child: Column(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.symmetric(
                                                horizontal:
                                                    MediaQuery.of(context)
                                                            .size
                                                            .width *
                                                        0.05,
                                              ),
                                              child: Column(
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                        image: NetworkImage(
                                                            tipData.image),
                                                        fit: BoxFit.cover,
                                                      ),
                                                      boxShadow: const [
                                                        BoxShadow(
                                                          color: Colors.grey,
                                                          blurRadius: 4,
                                                          offset: Offset(3,
                                                              3), // Shadow position
                                                        ),
                                                      ],
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
                                                      color: Colors.white,
                                                    ),
                                                    height: 90,
                                                    width: 100,
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  Text(
                                                    tipData.title,
                                                    style: const TextStyle(
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 10),
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
                            ],
                          ),
                          Column(
                            children: [
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    tipsData tipData = tipsData.fromJson((
                                        snapshot.data!.docs
                                            .elementAt(index)
                                            .data() as Map<String, dynamic>));
                                        {
                                        return RawMaterialButton(
                                          onPressed: () {
                                            // pageController
                                            //     .jumpToPage(index);
                                          },
                                          child: Container(
                                          width:
                                          MediaQuery.of(context).size.width,
                                          child: SingleChildScrollView(
                                          child: Column(
                                          children: [
                                          Container(
                                          margin: EdgeInsets.symmetric(
                                          horizontal:
                                          MediaQuery.of(context)
                                              .size
                                              .width *
                                          0.08,
                                          vertical: 13),
                                          child: Column(
                                          children: [
                                          Row(
                                          children: [
                                          Text(
                                          tipData.tname,
                                          style:
                                          const TextStyle(
                                          color: Colors
                                              .grey,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                          fontSize: 18),
                                          ),
                                          ],
                                          ),
                                          const SizedBox(
                                          height: 5,
                                          ),
                                            Link(

                                              target: LinkTarget.self,
                                              uri: Uri.parse(tipData.tlink),
                                              builder: (BuildContext context, Future<void> Function()? followLink) {
                                                return  RawMaterialButton(
                                                  onPressed: followLink,
                                                  child: Container(
                                                    height: MediaQuery.of(context).size.height*0.2,
                                                    width: MediaQuery.of(context).size.width*0.83,
                                                    child: ClipRRect(
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          10),
                                                      child: Image.network(
                                                        tipData.timage,fit: BoxFit.fill,),
                                                    ),
                                                  ),
                                                );

                                              },


                                            ),
                                          ],
                                          ),
                                          ),
                                          //
                                          ],
                                          ),
                                          )),
                                        );
                                        }
                                    },
                                )
                              ),
                            ],
                          ),
                          Column(
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Row(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 32),
                                    child: const Text(
                                      'Eventos',
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.23,
                               // width: MediaQuery.of(context).size.width,
                                child: PageView(
                                  onPageChanged: (val) {
                                    tipsData tipData = tipsData.fromJson(
                                        snapshot.data!.docs.elementAt(val).data()
                                        as Map<String, dynamic>);
                                    print('change ${val}');
                                  },
                                  controller: pageController,
                                  scrollDirection: Axis.horizontal,

                                  children: snapshot.data!.docs
                                      .map((DocumentSnapshot document) {
                                    Map<String, dynamic> data = document.data()!
                                        as Map<String, dynamic>;
                                    tipsData tipData = tipsData.fromJson(
                                        document.data()!
                                            as Map<String, dynamic>);
                                    return Column(
                                      children: [
                                        Column(
                                          children: [
                                            Container(

                                              child: SingleChildScrollView(

                                                child: Row(
                                                  children: [
                                                    SizedBox(width: 32,),
                                                    Link(

                                                      target: LinkTarget.self,
                                                      uri: Uri.parse(tipData.link),
                                                      builder: (BuildContext context, Future<void> Function()? followLink) {
                                                        return   RawMaterialButton(
                                                          onPressed: followLink,
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                BorderRadius
                                                                    .circular(10)),
                                                            height:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .height *
                                                                0.1,
                                                            width:
                                                            MediaQuery.of(context)
                                                                .size
                                                                .width *
                                                                0.45,
                                                            child: ClipRRect(
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                              child: Image.network(
                                                                tipData.image,fit: BoxFit.fill,),
                                                            ),
                                                          ),
                                                        );

                                                      },


                                                    ),
                                                    const SizedBox(
                                                      width: 25,
                                                    ),
                                                    Container(
                                                        height:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .height *
                                                                0.1,
                                                        width:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .width *
                                                                0.4,
                                                        child: Center(
                                                          child: Text(
                                                            tipData.details,
                                                            style: const TextStyle(
                                                                fontSize: 11,
                                                                color: Colors.grey),
                                                          ),
                                                        )),

                                                  ],
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                                margin:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 32),
                                                child: Row(

                                              mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    Column(
                                                      children: [
                                                        Text(
                                                          tipData.month,
                                                          style:
                                                          const TextStyle(
                                                              color: Colors
                                                                  .grey,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: 20),
                                                        ),
                                                        Text(
                                                          tipData.day,
                                                          style:
                                                          const TextStyle(
                                                              color:
                                                              kDarkBlue,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold,
                                                              fontSize: 20),
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      width: 20,
                                                    ),
                                                    Text(
                                                      tipData.title,
                                                      style: const TextStyle(
                                                          color: kVacsanBlue,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 20),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),

                                        //
                                      ],
                                    );
                                  }).toList(),
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

  Widget DropDownCity () {
    return Container(

      height: 30,
      color: Config.white,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.search),
        elevation: 16,
        style: Theme.of(context).textTheme.button,
        underline: Container(
          height: 2,
          color: Colors.white,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['todo','Barranquilla','Bogota','Cucuta','Villavicencio','Cali'
        ]
        // items: <String>['todo', 'Acacias','Barrancabermeja','Barranquilla','Bello','Bogota','Bucaramanga','Cajica','Cartagena de Indias','Chia','Chinu','Cimitarra','Cucuta','Dosquebradas','Duitama','El Colegio'
        //   ,'Envigado','Facacativa','Floridablanca','Fusagasuga','Garzon','Girardot','Granada','Guadalajara de Buga','Inirida','Itagui','Jamundi','La Ceja'
        //   ,'La Mesa','La Plata','Lebrija','Los Patios','Magangue','Mani-','Manizales','Medellin', 'Marinilla', 'Mosquera','Neiva','Ocana','Pamplona'
        //   ,'Pereira','Piedecuesta','Puerto Colombia','Puerto Gaiti¡n','Rionegro','Sabaneta','Sahagun','San Antonio de Prado','San Gil','San Jose del Guaviare'
        //   ,'Siberia','Sincelejo','Soacha','Socorro','Sogamoso','Soledad','Tauramena','Tunja','Villanueva','Villavicencio','Yopal','Zipaquira']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Container(
                margin: EdgeInsets.symmetric(horizontal: 5),
                child: Text(value)),
          );
        }).toList(),
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
