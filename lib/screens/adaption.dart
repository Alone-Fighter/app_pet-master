import 'package:app_pet/CustomWidgets/calendar.dart';
import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/Model/adaptions.dart';
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
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants.dart';

class Adaption extends StatefulWidget  {
  Adaption({Key? key}) : super(key: key);

  @override
  State<Adaption> createState() => _AdaptionState();
}

class _AdaptionState extends State<Adaption> implements ApiStatusLogin {
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
//------------------------------------------------------------------------//

    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu_rounded,
              size: 35,
            ),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        backgroundColor: kVacsanBlue,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Spacer(
              flex: 1,
            ),
            Text(
              'Adopcion',
              style: TextStyle(color: Config.white, fontSize: 21),
            ),
            const Spacer(
              flex: 2,
            )
          ],
        ),
      ),
      drawer: Drawer(
        child: myDrawer(),
      ),
      body: Stack(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              image: DecorationImage(
                image: AssetImage("assets/images/vacsinate.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(

            child: Column(
              children: [
                Column(
                  children: [
                    Container(
                      alignment: Alignment.topCenter,
                      height: 100,
                      child: const Image(
                        image: AssetImage('assets/images/wlogo.png'),
                      ),
                    ),


                  ],
                ),
                Consumer<ApiService>(
                  builder: (context, value, child) {
                    value.apiListener(this);
                    //////////////////////////////////should change with adaption api
                    value.getAllAdaptions();
                    return StreamBuilder<QuerySnapshot>(
                        stream:(dropdownValue == 'todo') ? context.read<ApiService>().getAllAdaptions() : context.read<ApiService>().getcityadoption(dropdownValue),
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
                                    width: 120,
                                    height: 100,
                                    decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(.7),
                                        borderRadius: BorderRadius.circular(15)),
                                    alignment: Alignment.center,
                                    padding: const EdgeInsets.all(16),
                                    margin: EdgeInsets.only(top: 50),
                                    child: const Text(
                                      'No Contact...',
                                      style:
                                      TextStyle(color: Colors.black, fontSize: 16),
                                    )),
                              );
                            }
                            // return Text('data');

                            return SingleChildScrollView(
                              child: Column(
                                children: [

                                  SizedBox(
                                    height: MediaQuery.of(context).size.height * 0.088,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.08,
                                      ),
                                      const Text(
                                        '¡Estos peluditos\nnecesitan un hogar !',
                                        style: TextStyle(
                                            color: kLightBlue,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20),
                                      ),
                                      Spacer(flex: 2,),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          //const Text('City :  ',style: TextStyle(color: Colors.white),),
                                          DropDownCity(),
                                        ],
                                      ),
                                      Spacer(flex: 1,),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: MediaQuery.of(context).size.width * 0.08,
                                      ),
                                      const Text(
                                        'No puedos comprar la felicidad ,pero puedes\n adoptar unamascota y es casi lo mismo',
                                        style:
                                        TextStyle(color: Colors.grey, fontSize: 11),
                                      ),
                                    ],
                                  ),
                                  SingleChildScrollView(
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height:MediaQuery.of(context).size.height * 0.03,
                                        ),
                                        SizedBox(
                                          height:
                                          MediaQuery.of(context).size.height * 0.5,
                                          child: ListView(
                                            // scrollDirection: Axis.horizontal,
                                            padding: const EdgeInsets.only(top: 5),
                                            children: snapshot.data!.docs
                                                .map((DocumentSnapshot document) {
                                              AdaptionsData adaptionsData =
                                              AdaptionsData.fromJson(document
                                                  .data()! as Map<String, dynamic>);
                                              return Container(
                                                  width:
                                                  MediaQuery.of(context).size.width,
                                                  child:
                                                  Column(
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
                                                                  adaptionsData.name,
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
                                                              uri: Uri.parse(adaptionsData.link),
                                                              builder: (BuildContext context, Future<void> Function()? followLink) {
                                                                return  RawMaterialButton(
                                                                  onPressed: followLink,
                                                                  child: ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius
                                                                        .circular(10),
                                                                    child: Image.network(
                                                                        adaptionsData
                                                                            .image),
                                                                  ),
                                                                );

                                                              },

                                                             
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      //
                                                    ],
                                                  )

                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ],
                                    ),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
  Widget DropDownCity () {
    return Container(
      width: MediaQuery.of(context).size.width*0.25,
      child: DropdownButton<String>(
        value: dropdownValue,
        icon: const Icon(Icons.arrow_drop_down_sharp,color: kDarkBlueHeader,),
        //elevation: 16,
        style: const TextStyle(color: kDarkBlueHeader),
        isExpanded: true,
        underline: Container(
          height: 1,
          color: kDarkBlueHeader,
        ),
        onChanged: (String? newValue) {
          setState(() {
            dropdownValue = newValue!;
          });
        },
        items: <String>['todo','Barranquilla','Bogota','Cucuta','Villavicencio','Cali'
        ]
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
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
