import 'package:app_pet/Model/pet.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Ui/settings_page.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/custom_snackbar.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:app_pet/screens/add_pet1.dart';
import 'package:app_pet/screens/fotos.dart';
import 'package:app_pet/screens/pet_profile.dart';
import 'package:app_pet/screens/pet_reg2.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'calendar.dart';
class myDrawer2 extends StatelessWidget {
  late BuildContext context;
  String petId = '';
  var imagePath = '-1';
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    String myuser = auth.currentUser!.uid;
    return Scaffold(
      body: Consumer<ApiService>(
        builder: (context, value, child) {
          value.getAllPets();
          return StreamBuilder<QuerySnapshot>(
              stream: context.read<ApiService>().getAllVet(),
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

                  try{
                    if(value.getSelectedPet.isEmpty){
                      PetData pet = PetData.fromJson(snapshot.data!.docs.elementAt(0).data() as Map<String, dynamic>);
                      value.setSelectedPetDef(pet.id);
                    }
                  }catch (e){
                    print(e);
                  }
                  print(snapshot.data!.docs[0]);
                  return SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 130,
                          child: DrawerHeader(
                            decoration: const BoxDecoration(

                            ),
                            child: Row(
                              children:  [
                                Icon(Icons.menu_rounded,size: 35,color: Colors.grey.shade400,),
                                const SizedBox(width: 20,),
                                Text('PERFIL',style: TextStyle(color: Colors.grey.shade600,fontSize: 22),),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              image: AssetImage("assets/images/drawer_background.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height*0.61,
                                child: ListView(
                                  padding: const EdgeInsets.only(top: 5),
                                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                                    // Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                                    // PetData petData = PetData.fromJson(document.data()! as Map<String, dynamic>);
                                    //print('pets : ${petData.id}');
                                    return  Column(
                                      children: [
                                        ListTile(
                                          leading: Stack(
                                            children: [
                                              Container(
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: kLightBlue ,
                                                  ),
                                                  height:
                                                  MediaQuery.of(context).size.height * 0.1,
                                                  width: MediaQuery.of(context).size.width * 0.15,
                                                  child: (document.get('id').length>3) ? ClipRRect(
                                                      borderRadius: BorderRadius.circular(40),
                                                      child: Image.network(document.get('id'), fit: BoxFit.fill,))
                                                      :  Center(child: Center(child: Icon(Icons.person,color: Config.white,)))

                                              ),
                                              const Positioned(
                                                bottom: 0,
                                                right: -1,
                                                child: Icon(Icons.circle,color: Colors.greenAccent,size: 20,),
                                              ),
                                            ],
                                          ),
                                          title:  Row(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(document.get('name')),
                                              Expanded(child:document.get('name') == value.getSelectedPet ? const Icon(Icons.check , color: Colors.green) : Container())
                                            ],
                                            ),
                                          onTap: () {

                                          },
                                        ),
                                        const SizedBox(height: 20,),

                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 20),
                                          child: ListTile(
                                            leading: Icon(Icons.flag_outlined,color: Colors.grey.shade300,),
                                            title:  Text('Fotos',style: TextStyle(color: Colors.grey.shade300),),
                                            onTap: () {

                                             kNavigator(context,Fotos(petId: document.get('id')));
                                            },
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(horizontal: 20),
                                          child: ListTile(
                                            leading: Icon(Icons.flash_on_outlined,color: Colors.grey.shade300,),
                                            title: Text('Completar',style: TextStyle(color: Colors.grey.shade300),),
                                            onTap: () {


                                            },
                                          ),
                                        ),


                                      ],
                                    );
                                  }).toList(),
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                child: ListTile(
                                  leading: Icon(Icons.settings,color: Colors.grey.shade300,),
                                  title: Text('configuración',style: TextStyle(color: Colors.grey.shade300),),
                                  onTap: () {

                                   kNavigator(context,SettingPage() );
                                  },
                                ),
                              ),
                              Container(
                                margin: const EdgeInsets.symmetric(horizontal: 20),
                                child: ListTile(

                                  leading: const Icon(Icons.add_circle,color: kLightBlue,size: 30,),
                                  title:  const Text('Agregar mascota',style: TextStyle(color: kLightBlue),),

                                  onTap: () {

                                    kNavigator(context, AddPet1());
                                  },
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
    );

  }

  Future<void> _pickImageFromGallery(BuildContext context) async {
    final pickedFile =
    await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      context.read<ApiService>().updateProfilePetImage(pickedFile.path, petId);
      print('path is:' + pickedFile.path.toString());
    }
  }


}


