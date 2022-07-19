import 'package:app_pet/CustomWidgets/calendar.dart';
import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
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

import '../constants.dart';

class ListUsers extends StatelessWidget {
  const ListUsers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(.7),
        title: const Text('Contact'),
      ),
      body: SafeArea(
        child: Container(
          color: Colors.black.withOpacity(.8),
          child: const ListUserView(),
        ),
      ),
    );
  }
}

class ListUserView extends StatelessWidget {
  const ListUserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return StreamBuilder<QuerySnapshot>(
        stream: context.read<ApiService>().getAllPets(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                    width: w * 0.6,
                    height: (w * 0.6) / 2,
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(.1),
                        borderRadius: BorderRadius.circular(15)),
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(16),
                    child: const Text(
                      'No Contact...',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )),
              );
            }
            return ListView(
              padding: const EdgeInsets.only(top: 5),
              children: snapshot.data!.docs.map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                return userView(context, data);
              }).toList(),
            );
          }

          return const Center(
            child: Waitting(),
          );
        });
  }

  Widget userView(BuildContext context, Map<String, dynamic> data) {
    bool hasImage = data['image'].toString().isNotEmpty;
    return InkWell(
      onTap: () {},
      child: SizedBox(
        width: double.infinity,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Container(
              width: 50,
              height: 50,
              margin: const EdgeInsets.only(left: 8),
              alignment: Alignment.center,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25), color: Colors.green),
              child: hasImage
                  ? CachedNetworkImage(
                      imageUrl: data['image'],
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      placeholder: (context, url) =>
                          const Waitting(),
                      errorWidget: (context, url, error) => Text(
                        data['user'].toString().toUpperCase().substring(0, 1),
                        style: TextStyle(
                            color: Colors.white.withOpacity(.7), fontSize: 16),
                        textAlign: TextAlign.right,
                      ),
                    )
                  : Text(data['name'].toString().toUpperCase().substring(0, 1),
                      style:
                          const TextStyle(color: Colors.white, fontSize: 18)),
            ),
            Expanded(
                child: Container(
              margin: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    '${data['name']} ${data['lastname']}',
                    style: const TextStyle(color: Colors.white, fontSize: 16),
                  ),
                  Text(
                    data['online'] ? 'online' : 'last seen recently',
                    style: TextStyle(
                        color: data['online'] ? Colors.lightBlue : Colors.grey,
                        fontSize: 14),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}

class FirebaseTest extends StatelessWidget implements ApiStatusLogin {
  FirebaseTest({Key? key}) : super(key: key);
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
      body: Consumer<ApiService>(
        builder: (context, value, child) {
          value.apiListener(this);
          value.getAllPets();
          return StreamBuilder<QuerySnapshot>(
              stream: context.read<ApiService>().getAllPets(),
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
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          )),
                    );
                  }
                  // return Text('data');

                  return ListView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.only(top: 5),
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          child: Center(
                            child: Text(data['name']),
                          ));
                    }).toList(),
                  );
                }

                return const Center(
                  child: Waitting(),
                );
                {}
              });
        },
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
