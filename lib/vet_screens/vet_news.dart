import 'package:app_pet/CustomWidgets/calendar.dart';
import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/Model/news.dart';
import 'package:app_pet/Model/product.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/dropdown_options.dart';
import 'package:app_pet/Utils/medical_exam_history.dart';
import 'package:app_pet/Utils/my_button.dart';
import 'package:app_pet/Utils/vet_search.dart';
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
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class VetNews extends StatelessWidget implements ApiStatusLogin {
  VetNews({Key? key}) : super(key: key);
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
              'Novedades',
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
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/images/vacsinate.png"),
                fit: BoxFit.cover,
              ),
            ),

          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                  height: MediaQuery.of(context).size.height * 0.13,
                  width: MediaQuery.of(context).size.width * 0.13,
                  child: Image.asset('assets/images/wlogo.png')
              ),
            ],
          ),
          Container(
            child: Consumer<ApiService>(
              builder: (context, value, child) {
                value.apiListener(this);
                //////////////////////////////////should change with tips api
                value.getAllNews();
                return StreamBuilder<QuerySnapshot>(
                  stream: context.read<ApiService>().getAllNews2(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height * 0.17,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.62,
                              child: ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  {
                                    return Column(
                                      children: [
                                        Container(
                                          margin: EdgeInsets.symmetric(
                                            horizontal: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.11,
                                          ),
                                          child: Row(
                                            children: [
                                              Text(
                                                snapshot.data!.docs[index].id,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.grey.shade600,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.2,
                                          width:
                                              MediaQuery.of(context).size.width *
                                                  0.85,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Center(
                                            child: getdata(snapshot.data!.docs[index].id)
                                          ),
                                        ),
                                        SizedBox(
                                          height:
                                              MediaQuery.of(context).size.height *
                                                  0.05,
                                        )
                                      ],
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      );
                      //;
                    } else if (snapshot.hasError) {
                      return Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.5,
                          ),
                          Text(snapshot.error.toString()),
                        ],
                      );
                    }

                    return const Waitting();
                  },
                );
              },
            ),
          ),
        ],
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
  getdata(x){
    return StreamBuilder<QuerySnapshot>(
      stream: context
          .read<ApiService>()
          .getAllNews3(x),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot>
          snapshot) {
        if (snapshot.hasData) {
          return Container(
            child: ListView(
              scrollDirection:
              Axis.horizontal,
              padding:
              const EdgeInsets.only(
                  top: 5),
              children: snapshot
                  .data!.docs
                  .map((DocumentSnapshot
              document) {
                newsData NewsData =
                newsData.fromJson(
                    document.data()!
                    as Map<String,
                        dynamic>);
                return RawMaterialButton(
                  onPressed: () async {
                    final url=NewsData.link;
                    if(await canLaunch(url) ){
                      await launch(url);
                    }
                  },
                  child: Container(
                      height:
                      MediaQuery.of(
                          context)
                          .size
                          .height *
                          0.2,
                      width: MediaQuery.of(
                          context)
                          .size
                          .width *
                          0.85,
                      child: ClipRRect(
                          borderRadius:
                          BorderRadius
                              .circular(
                              10),
                          child:(NewsData.image.isEmpty)
                          ?Image.asset('assets/images/adap.png')
                              :  Image.network(
                            NewsData.image,
                            fit:
                            BoxFit.fill,
                          )
                        )),
                );
              }).toList(),
            ),
          );
          //;
        } else if (snapshot.hasError) {
          return Column(
            children: [
              SizedBox(
                height:
                MediaQuery.of(context)
                    .size
                    .height *
                    0.5,
              ),
              Text(snapshot.error
                  .toString()),
            ],
          );
        }

        return const Waitting();
      },
    );
  }
}
