import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Ui/Location.dart';
import 'package:app_pet/Ui/calendar_view.dart';
import 'package:app_pet/Utils/background.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/Utils/search.dart';
import 'package:app_pet/Utils/vet_search.dart';
import 'package:app_pet/constants.dart';
import 'package:app_pet/screens/adaption.dart';
import 'package:app_pet/screens/directory.dart';
import 'package:app_pet/screens/medical_diary.dart';
import 'package:app_pet/screens/pet_products.dart';
import 'package:app_pet/screens/tips.dart';
import 'package:app_pet/vet_screens/vet_events.dart';
import 'package:app_pet/vet_screens/vet_news.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../CustomWidgets/drawer2.dart';
import '../Ui/notificationpage.dart';
import '../Ui/settings_page.dart';
import '../Utils/waitting_animation.dart';
import '../screens/fotos.dart';

class VetMenu extends StatelessWidget {
  VetMenu({Key? key}) : super(key: key);

  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return Consumer<ApiService>(
      builder: (context, value, child) {
        return Scaffold(
          appBar: AppBar(
            // leading: Builder(
            //   builder: (context) => IconButton(
            //     icon: Icon(
            //       Icons.menu_rounded,
            //       size: 35,
            //       color: Colors.grey.shade300,
            //     ),
            //     onPressed: () => Scaffold.of(context).openDrawer(),
            //   ),
            // ),
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                RawMaterialButton(
                  onPressed: () async {
                    showSearch(context: context, delegate: SearchVetSection());

                    // final results = await
                    //     showSearch(context: context, delegate: CitySearch());

                    // print('Result: $results');
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
                        showSearch(context: context, delegate: SearchVetSection());

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
            child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              future: context.read<ApiService>().getAllVet2(),
                builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot){
                  if (snapshot.hasError) {
                    print('hasError');
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Waitting(),
                    );
                  }
                  if (snapshot.hasData){
                    if (snapshot.data!.data()!.isEmpty) {
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
                                  child: Column(
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
                                                child: (snapshot.data!.get('image').length>3) ? ClipRRect(
                                                    borderRadius: BorderRadius.circular(40),
                                                    child: Image.network(snapshot.data!.get('image'), fit: BoxFit.fill,))
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
                                            Text(snapshot.data!.get('name')),
                                            Expanded(child:snapshot.data!.get('name') == value.getSelectedPet ? const Icon(Icons.check , color: Colors.green) : Container())
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

                                            kNavigator(context,Fotos(petId: snapshot.data!.get('id')));
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
                                // Container(
                                //   margin: const EdgeInsets.symmetric(horizontal: 20),
                                //   child: ListTile(
                                //
                                //     leading: const Icon(Icons.add_circle,color: kLightBlue,size: 30,),
                                //     title:  const Text('Agregar mascota',style: TextStyle(color: kLightBlue),),
                                //
                                //     onTap: () {
                                //
                                //     },
                                //   ),
                                // ),
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
                }
            ),
          ),
          body: SafeArea(
            child:Stack(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage("assets/images/background.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height*0.15,
                            alignment: Alignment.topCenter,
                            child: Image.asset(  'assets/images/splash_top.png'),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height*0.15,
                          ),
                          MenuContainer(context, 0.9,0.4,'assets/images/vetmenu1.png',(){
                            kNavigator(context, VetEvents());
                          }),
                          MenuContainer(context, 0.9,0.4,'assets/images/vetmenu2.png',(){
                            kNavigator(context, VetNews());
                          }),
                        ],
                      )
                    ),
                  ),
                ),
              ],
            ) ,
            
          ),
        );
      },
    );
  }
}
