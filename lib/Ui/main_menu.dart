import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/Model/adaptions.dart';
import 'package:app_pet/Model/banner.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Ui/medicalexams.dart';
import 'package:app_pet/Ui/new_calender_view.dart';
import 'package:app_pet/Ui/notificationpage.dart';
import 'package:app_pet/Ui/settings_page.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/search.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/constants.dart';
import 'package:app_pet/screens/adaption.dart';
import 'package:app_pet/screens/directory.dart';
import 'package:app_pet/screens/medical_diary.dart';
import 'package:app_pet/screens/pet_products.dart';
import 'package:app_pet/screens/pet_reg2.dart';
import 'package:app_pet/screens/tips.dart';
import 'package:app_pet/screens/vaccination.dart';
import 'package:app_pet/screens/visit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'Location.dart';
import 'calendar_view.dart';
import 'package:carousel_slider/carousel_slider.dart';


class MainMenu extends StatelessWidget implements ApiStatusLogin {
  MainMenu({Key? key}) : super(key: key);
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
    String city = 'BOGOTA';
//------------------------------------------------------------------------//

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: Icon(
              Icons.menu_rounded,
              size: 35,
              color: Colors.grey.shade300,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            RawMaterialButton(
              onPressed: () async {
                showSearch(context: context, delegate: SearchSection());

              },
              child: Container(
                width: MediaQuery.of(context).size.width * 0.55,
                height: MediaQuery.of(context).size.height * 0.05,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade300)),
                //   child: TextFormField(
                // controller: value.searchController,
                //   ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: const BoxDecoration(),
              child: RawMaterialButton(
                  onPressed: () async {
                    showSearch(context: context, delegate: SearchSection());

                    // final results = await
                    //     showSearch(context: context, delegate: CitySearch());

                    // print('Result: $results');
                  },
                  child: Image.asset(
                    'assets/images/menu8.png',
                  )),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.1,
              height: MediaQuery.of(context).size.height * 0.06,
              decoration: const BoxDecoration(),
              child: IconButton(
                icon: const Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                  size: 35,
                ),
                onPressed: () {
                   kNavigator(context, NotificationPage());
                },
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
            image: AssetImage("assets/images/background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<ApiService>(
          builder: (context, value, child) {
            value.apiListener(this);
            //////////////////////////////////should change with adaption api
            return StreamBuilder<QuerySnapshot>(
                stream: value.getBanner(),
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
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.keyboard_arrow_left),
                                  Container(
                                    decoration: BoxDecoration(
                                        borderRadius:
                                        BorderRadius.circular(25),
                                        border: Border.all(
                                            color: Config.blue)),
                                     margin: EdgeInsets.symmetric(horizontal: 20,vertical: 10),
                                    height: MediaQuery.of(context).size.height*0.21,
                                    width: MediaQuery.of(context).size.width*0.77,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      padding: const EdgeInsets.only(top: 5),
                                      children: snapshot.data!.docs
                                          .map((DocumentSnapshot document) {
                                        BannerData bannerData = BannerData.fromJson(
                                            document.data()! as Map<String, dynamic>);
                                        return Container(

                                          margin: const EdgeInsets.symmetric(
                                              horizontal: 20),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [

                                              ClipRRect(
                                                borderRadius:
                                                BorderRadius.circular(25),
                                                child: Container(

                                                  width: MediaQuery.of(context)
                                                      .size
                                                      .width*0.68,
                                                  height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                      0.18,

                                                  child: FittedBox(
                                                      fit: BoxFit.fill,
                                                      child: (bannerData
                                                          .image
                                                          .length >
                                                          3)
                                                          ? ClipRRect(
                                                          borderRadius:
                                                          BorderRadius.circular(
                                                              40),
                                                          child: Container(
                                                            height: 20,
                                                            child: Image.network(bannerData.image, fit: BoxFit.fill, width: 1000),
                                                          ))
                                                          :Container()
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  Icon(Icons.keyboard_arrow_right),
                                ],
                              ),
                              SizedBox(
                                height: MediaQuery.of(context).size.height*0.73,
                                child:Column(
                                  children: [

                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MenuContainer(context, 0.35, 0.35,
                                            'assets/images/menu5.png', () {
                                              kNavigator(
                                                  context, MedicalDiary());
                                            }),
                                        MenuContainer(context, 0.35, 0.35,
                                            'assets/images/menu7.png', () {
                                              kNavigator(
                                                  context, LocationScreen());
                                            }),

                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MenuContainer(context, 0.35, 0.35,
                                            'assets/images/menu6.png', () {
                                              kNavigator(
                                                context,
                                                NewCalendarView(),
                                              );
                                            }),
                                        MenuContainer(context, 0.35, 0.35,
                                            'assets/images/menu3.png', () {
                                              kNavigator(context, Adaption());
                                            }),

                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MenuContainer(context, 0.35, 0.35,
                                            'assets/images/menu4.png', () {
                                              kNavigator(context, Directory());
                                            }),
                                        MenuContainer(context, 0.35, 0.35,
                                            'assets/images/menu1.png', () {
                                              kNavigator(context, Products());
                                            }),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        MenuContainer(context, 0.35, 0.35,
                                            'assets/images/menu2.png', () {
                                              kNavigator(context, Tips());
                                            }),
                                        Container(
                                          height: MediaQuery.of(context).size.width*0.3,
                                          width: MediaQuery.of(context).size.width*0.35,
                                        )
                                      ],
                                    ),
                                  ],
                                )
                              )

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
    // kNavigatorBack(context);
    // kNavigator(context, PetReg2());
  }

  @override
  void passwordWeak() {
    ModeSnackBar.show(context, 'use una contraseña más fuerte por favor',
        SnackBarMode.warning);
  }
}

