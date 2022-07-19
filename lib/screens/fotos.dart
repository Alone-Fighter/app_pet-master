import 'package:app_pet/Model/hfotos.dart';
import 'package:app_pet/Model/historyM.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/history.dart';
import 'package:app_pet/Utils/history_image.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:provider/src/provider.dart';

import '../constants.dart';

class Fotos extends StatelessWidget implements UploadStatus {
  var petId;
  late BuildContext context;

  Fotos({required this.petId});

  @override
  Widget build(BuildContext context) {
    final PageController _controller = PageController(initialPage: 0);
    return Scaffold(
      body: Consumer<ApiService>(
        builder: (context, value, child) {
          value.apiListenerUpload(this);
          return Container(
            color: Colors.white,
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: SafeArea(
                    child: Consumer<ApiService>(
                      builder: (context, value, child) {
                        return StreamBuilder<QuerySnapshot>(
                            stream: context
                                .read<ApiService>()
                                .getAllHistory(petId, 'Fotos'),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (snapshot.hasError) {
                                print('hasError');
                                return const Text('Something went wrong');
                              }

                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
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
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(16),
                                        child: const Text(
                                          'No Contact...',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        )),
                                  );
                                }
                                // return Text('data');

                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  width: MediaQuery.of(context).size.width,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Center(
                                        child: SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.7,
                                          child: MaterialApp(
                                            debugShowCheckedModeBanner: false,
                                            home: DefaultTabController(
                                              length: 4,
                                              child: Scaffold(
                                                body: Column(
                                                  children: [
                                                    image(context,
                                                        snapshot.data!.docs),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
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
                  ),
                ),
                Spacer(),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        print(petId);
                        _pickImageFromGallery(false, context, petId)
                            .whenComplete(() => value.updateFotosImage(petId));
                      },
                      child: Row(
                        children: const [
                          Spacer(
                            flex: 3,
                          ),
                          Icon(Icons.add_a_photo_outlined),
                          Spacer(
                            flex: 1,
                          ),
                          Text('añadir nueva foto'),
                          Spacer(
                            flex: 3,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Spacer(),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _pickImageFromGallery(
      bool profile, BuildContext context, petId) async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      {
        context.read<ApiService>().setImagePath(pickedFile.path);
      }
    }
  }

  @override
  void error() {
    // TODO: implement error
  }

  @override
  void uploaded() {
    ModeSnackBar.show(context, 'operación exitosa', SnackBarMode.success);
  }

  @override
  void uploading() {
    // TODO: implement uploading
  }
}

Widget image(BuildContext context, List<QueryDocumentSnapshot> snapshot) {
  final PageController _controller = PageController(initialPage: 0);
  return Container(
    height: MediaQuery.of(context).size.height * 0.7,
    width: MediaQuery.of(context).size.width,
    child: PageView(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      children: snapshot.map((DocumentSnapshot document) {
        Hfotos FotoData =
            Hfotos.fromJson(document.data()! as Map<String, dynamic>);
        return Container(
          alignment: Alignment.center,
          // height: MediaQuery.of(context).size.height * 0.3,
          // width: MediaQuery.of(context).size.width ,
          child: RawMaterialButton(
            onPressed: () {
              // print(HistoryData.address.toString());
              kNavigator(context,
                  HistoryImage(HistoryImage1: FotoData.address.toString()));
            },
            child: Card(
              elevation: 20,
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.92,
                    height: MediaQuery.of(context).size.height * 0.7,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 10),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        FotoData.address,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}
