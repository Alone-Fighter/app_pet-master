import 'package:app_pet/CustomWidgets/LocationWidget.dart';
import 'package:app_pet/CustomWidgets/headerpage.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/src/provider.dart';

final fs = FirebaseFirestore.instance;

class LocationScreen extends StatefulWidget {
  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  Set<Marker> markers = Set();

  String dropdownValue = 'todo';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HeaderPageLocation(
          widget: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                    Text('Ciudad :  ',style: TextStyle(color: Colors.white),),
                    DropDownCity(),
                  ],),
                  const SizedBox(
                    height: 80,
                  ),
                  Row(
                    children: [
                      ContainerLocation(
                          context, 'assets/images/location1.png', () {

                        kNavigator(
                          context,
                          LocationScreenWidget(
                            location: 'Veterinaria',
                            City: dropdownValue,
                          ),
                        );
                      }),
                      const Spacer(),
                      ContainerLocation(
                          context, 'assets/images/location2.png', () {
                        kNavigator(
                          context,
                           LocationScreenWidget(
                            location: 'pet shop',
                            City: dropdownValue,
                          ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ContainerLocation(
                          context, 'assets/images/location3.png', () {
                        kNavigator(
                          context,
                          LocationScreenWidget(
                            location: 'pet care',
                            City: dropdownValue,
                          ),
                        );

                      }),
                      const Spacer(),
                      ContainerLocation(
                          context, 'assets/images/location4.png', () {
                        kNavigator(
                          context,
                           LocationScreenWidget(
                            location: 'pet grooming',
                             City: dropdownValue,
                           ),
                        );
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      ContainerLocation(
                          context, 'assets/images/location5.png', () {
                        kNavigator(
                          context,
                           LocationScreenWidget(
                            location: 'otros',
                             City: dropdownValue,
                           ),
                        );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          background: 'assets/images/backlocation.png',
          text1: 'Cerca de Ti',
          color: kDarkBlueLocation),
    );
  }

  createmarkers(AsyncSnapshot<QuerySnapshot> snapshot) async{
    markers.clear();
    for (int i = 0; i < snapshot.data!.docs.length; ++i) {
      GeoPoint location = snapshot.data!.docs[i].get("location");
      markers.add(
        Marker(
          markerId: MarkerId(snapshot.data!.docs[i].id),
          position: LatLng(location.latitude,location.longitude),
          infoWindow: InfoWindow(title: snapshot.data!.docs[i].get('infowidow')),
        ),
      );
      // LatLng latLngs = LatLng(location.latitude, location.longitude);
      //
      // markers.add(Marker(markerId: MarkerId("location"), position: latLngs));
    }
  }

  Widget ContainerLocation(
      BuildContext context, String image, VoidCallback ontap) {
    return Material(
      color: kContainerLocation,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        onTap: ontap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.33,
          height: MediaQuery.of(context).size.height * 0.17,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: kContainerLocation.withOpacity(0.3),
                blurRadius: 7,
                spreadRadius: 5,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Image.asset(image),
        ),
      ),
    );
  }

  Widget DropDownCity () {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.grey),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? newValue) {
        setState(() {
          dropdownValue = newValue!;
        });
        },
      items: <String>['todo', 'Acacias','Barrancabermeja','Barranquilla','Bello','Bogota','Bucaramanga','Cajica','Cartagena de Indias','Chia','Chinu','Cimitarra','Cucuta','Dosquebradas','Duitama','El Colegio'
      ,'Envigado','Facacativa','Floridablanca','Fusagasuga','Garzon','Girardot','Granada','Guadalajara de Buga','Inirida','Itagui','Jamundi','La Ceja'
      ,'La Mesa','La Plata','Lebrija','Los Patios','Magangue','Mani-','Manizales','Medellin', 'Marinilla', 'Mosquera','Neiva','Ocana','Pamplona'
      ,'Pereira','Piedecuesta','Puerto Colombia','Puerto Gaiti¡n','Rionegro','Sabaneta','Sahagun','San Antonio de Prado','San Gil','San Jose del Guaviare'
      ,'Siberia','Sincelejo','Soacha','Socorro','Sogamoso','Soledad','Tauramena','Tunja','Villanueva','Villavicencio','Yopal','Zipaquira']
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}


