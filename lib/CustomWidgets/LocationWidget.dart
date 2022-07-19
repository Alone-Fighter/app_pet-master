import 'dart:async';
import 'dart:typed_data';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/waitting_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:location/location.dart';
import 'dart:ui' as ui;

class LocationScreenWidget extends StatefulWidget {
  final String location;
  final String City;

  const LocationScreenWidget(
      {Key? key, required this.location, required this.City})
      : super(key: key);

  @override
  LocationScreenWidgetState createState() => LocationScreenWidgetState();
}

class LocationScreenWidgetState extends State<LocationScreenWidget> {
  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();

  @override
  void initState() {
    super.initState();
    // getLocationPermission();
    checkLocation();

  }

  double zoomVal = 5.0;
  late GeoPoint NowLocation = const GeoPoint(6.328430, -75.5655120);
  bool isvisible = true;
  bool isselected = false;
  bool Permission = false;
  var location = Location();
  int markerid = 0;
  int x = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            FutureBuilder<QuerySnapshot>(
              future: (widget.City == 'todo')
                  ? context.read<ApiService>().getAllmarker(widget.location)
                  : context
                  .read<ApiService>()
                  .getCity(widget.City, widget.location),
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
                    return const Center(
                      child: Text('No Location'),
                    );
                  }
                  GeoPoint location2 = snapshot.data!.docs[0].get("location");
                  NowLocation = GeoPoint(location2.latitude, location2.longitude);
                  createmarkers(snapshot);
                  return Stack(
                    children: [
                      _buildContainer(snapshot),
                      _isselected(snapshot, markerid),
                    ],
                  );
                }
                return const Center(
                  child: Waitting(),
                );
              },
            ),
            FutureBuilder<Widget>(
              future: Future<Widget>.delayed(
                const Duration(seconds: 1),
                    () => _buildGoogleMap(context,NowLocation),
              ),
              builder:(BuildContext context,
                  AsyncSnapshot<Widget> snapshot) {
                _gotoLocationfirst(NowLocation.latitude, NowLocation.longitude);

                return DelayedDisplay(
                  delay: Duration(seconds: 2),
                  child: _buildGoogleMap(context,NowLocation),
                );

              },
            ),
            //


            Visibility(
              visible: Permission,
              child: InkWell(
                onTap: () async {
                  checkLocation();
                },
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  width: 130,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Center(
                      child: Text(
                    'sin autorización',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ),
            Visibility(
              visible: !Permission,
              child: Stack(
                children: [
                  Positioned(
                    top: 5,
                    right: 0,
                    child: FloatingActionButton.extended(
                      onPressed: _currentLocation,
                      label: Text('Mi ubicación'),
                      icon: Icon(Icons.location_on),
                    ),
                  )
                ],
              ),
            ),
            // FutureBuilder<QuerySnapshot>(
            //   future: (widget.City == 'todo')
            //       ? context.read<ApiService>().getAllmarker(widget.location)
            //       : context
            //       .read<ApiService>()
            //       .getCity(widget.City, widget.location),
            //   builder:
            //       (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //     Snapshot = snapshot;
            //     if (snapshot.hasError) {
            //       print('hasError');
            //       return const Text('Something went wrong');
            //     }
            //
            //     if (snapshot.connectionState == ConnectionState.waiting) {
            //       return const Center(
            //         child: Waitting(),
            //       );
            //     }
            //     if (snapshot.hasData) {
            //       if (snapshot.data!.docs.isEmpty) {
            //         return const Center(
            //           child: Text('No Location'),
            //         );
            //       }
            //       createmarkers(snapshot);
            //       print(Snapshot.data!.docs[0].data());
            //       return Stack(
            //         children: [
            //
            //           // Align(
            //           //   alignment: Alignment.topRight,
            //           //   child: Container(
            //           //     margin: const EdgeInsets.symmetric(
            //           //         horizontal: 10, vertical: 50),
            //           //     width: 50,
            //           //     height: 90,
            //           //     decoration: BoxDecoration(
            //           //       color: Colors.grey.shade300,
            //           //       borderRadius: BorderRadius.circular(20),
            //           //     ),
            //           //     child: Stack(
            //           //       children: [
            //           //         _zoomminusfunction(),
            //           //         _zoomplusfunction(),
            //           //       ],
            //           //     ),
            //           //   ),
            //           // ),
            //
            //
            //         ],
            //       );
            //     }
            //     return const Center(
            //       child: Waitting(),
            //     );
            //   },
            // ),
          ],
        ),
      ),
    );
  }

  void _currentLocation() async {
    final GoogleMapController controller = await _controller.future;
    LocationData? currentLocation;
    var location = new Location();
    try {
      currentLocation = await location.getLocation();
    } on Exception {
      currentLocation = null;
    }

    controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        bearing: 0,
        target: LatLng(currentLocation!.latitude!, currentLocation.longitude!),
        zoom: 17.0,
      ),
    ));
  }

  createmarkers(AsyncSnapshot<QuerySnapshot> snapshot) async {
    markers.clear();
    GeoPoint location2 = snapshot.data!.docs[0].get("location");
    for (int i = 0; i < snapshot.data!.docs.length; ++i) {
      GeoPoint location = snapshot.data!.docs[i].get("location");
      markers.add(
        Marker(

          markerId: MarkerId(snapshot.data!.docs[i].id),
          position: LatLng(location.latitude, location.longitude),
          infoWindow: InfoWindow(
              title: snapshot.data!.docs[i].get('infowidow'),
              onTap: () {
                setState(() {
                  isvisible = false;
                  isselected = true;
                  markerid = i;
                  NowLocation = GeoPoint(location2.latitude, location2.longitude);
                });
              }),
        ),
      );
      if (isselected == false) {
      }

      // LatLng latLngs = LatLng(location.latitude, location.longitude);
      //
      // markers.add(Marker(markerId: MarkerId("location"), position: latLngs));
    }

  }

  checkLocation() async {
    try {
      await location.requestPermission(); //to lunch location permission popup
      print(
          '----------------------------------------------------Permission-------------------------------');
      final PermissionStatus permissionGrantedResult =
          await location.hasPermission();
      if (permissionGrantedResult != PermissionStatus.granted) {
        setState(() {
          Permission = true;
        });
      }
      ;
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print(
            '----------------------------------------------------Permission denied-------------------------------');
      }
    }
  }

  getLocationPermission() async {
    try {
      location.requestPermission(); //to lunch location permission popup
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        print(
            '----------------------------------------------------Permission denied-------------------------------');
      }
    }
    // setState(() {
    //   if (_permissionGranted == PermissionStatus.denied) {
    //     setState(() {
    //       // Center(
    //       //   child: Container(
    //       //     width: 100,
    //       //     height: 80,
    //       //     decoration: BoxDecoration(
    //       //       color: Colors.white,
    //       //       borderRadius: BorderRadius.circular(20),
    //       //     ),
    //       //     child: Center(
    //       //         child: Text(
    //       //       'no permision',
    //       //       style: TextStyle(fontWeight: FontWeight.bold),
    //       //     )),
    //       //   ),
    //       // );
    //       Permission = true;
    //     });
    //   };
    //   if(_permissionGranted == PermissionStatus.granted){
    //     setState(() {
    //       Permission = false;
    //     });
    //   };
    // });
  }

  Widget _isselected(AsyncSnapshot<QuerySnapshot> snapshot, int id) {
    return Visibility(
      visible: isselected,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            height: 150.0,
            child: ListView.builder(
                itemCount: 1,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  GeoPoint location = snapshot.data!.docs[id].get("location");
                  return Stack(
                    children: [
                      const SizedBox(width: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _boxes(
                          "https://icon-library.com/images/icon-shop/icon-shop-3.jpg",
                          (location.latitude),
                          (location.longitude),
                          snapshot.data!.docs[id].get('infowidow'),
                          snapshot.data!.docs[id].get('review'),
                          snapshot.data!.docs[id].get('city'),
                          snapshot.data!.docs[id].get('address'),
                          snapshot.data!.docs[id].get('zip'),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget _buildContainer(AsyncSnapshot<QuerySnapshot> snapshot) {
    return Visibility(
      visible: isvisible,
      child: Container(
        margin: EdgeInsets.only(right: 10),
        child: Align(
          alignment: Alignment.bottomLeft,
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 5.0),
            height: 150.0,
            child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  GeoPoint location =
                      snapshot.data!.docs[index].get("location");
                  return Stack(
                    children: [
                      const SizedBox(width: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _boxes(
                          "https://icon-library.com/images/icon-shop/icon-shop-3.jpg",
                          (location.latitude),
                          (location.longitude),
                          snapshot.data!.docs[index].get('infowidow'),
                          snapshot.data!.docs[index].get('review'),
                          snapshot.data!.docs[index].get('city'),
                          snapshot.data!.docs[index].get('address'),
                          snapshot.data!.docs[index].get('zip'),
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ),
    );
  }

  Widget _boxes(String _image, double lat, double long, String restaurantName,
      double review, String city, String address, String zip) {
    return GestureDetector(
      onTap: () {
        _gotoLocation(lat, long);
        print(lat + long);
      },
      child: FittedBox(
        child: Material(
            color: Colors.white,
            elevation: 14.0,
            borderRadius: BorderRadius.circular(24.0),
            shadowColor: const Color(0x802196F3),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width: 180,
                  height: 200,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: Image(
                      fit: BoxFit.fill,
                      image: NetworkImage(_image),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: myDetailsContainer1(
                      restaurantName, review, city, address, zip),
                ),
              ],
            )),
      ),
    );
  }

  Widget myDetailsContainer1(String restaurantName, double review, String city,
      String address, String zip) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            restaurantName,
            style: const TextStyle(
                color: Color(0xFF659fff),
                fontSize: 24.0,
                fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 5.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(
              review.toString(),
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 18.0,
              ),
            ),
            // const Icon(
            //   FontAwesomeIcons.solidStar,
            //   color: Colors.amber,
            //   size: 15.0,
            // ),
            // const Icon(
            //   FontAwesomeIcons.solidStar,
            //   color: Colors.amber,
            //   size: 15.0,
            // ),
            // const Icon(
            //   FontAwesomeIcons.solidStar,
            //   color: Colors.amber,
            //   size: 15.0,
            // ),
            // const Icon(
            //   FontAwesomeIcons.solidStar,
            //   color: Colors.amber,
            //   size: 15.0,
            // ),
            // const Icon(
            //   FontAwesomeIcons.solidStarHalf,
            //   color: Colors.amber,
            //   size: 15.0,
            // ),
            // RatingBar.builder(
            //   itemSize: 30,
            //   initialRating: review,
            //   minRating: 1,
            //   direction: Axis.horizontal,
            //   allowHalfRating: true,
            //   itemCount: 5,
            //   itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
            //   ignoreGestures: true,
            //   itemBuilder: (context, _) => const Icon(
            //     Icons.star,
            //     color: Colors.amber,
            //   ),
            //   onRatingUpdate: (index) {},
            // ),
            // const Text(
            //   "(946)",
            //   style: TextStyle(
            //     color: Colors.black54,
            //     fontSize: 18.0,
            //   ),
            // ),
          ],
        ),
        const SizedBox(height: 5.0),
        Text(
          city,
          style: const TextStyle(
            color: Colors.black54,
            fontSize: 18.0,
          ),
        ),
        const SizedBox(height: 5.0),
        Text(
          address,
          style: const TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 5.0),
        Text(
          zip,
          style: const TextStyle(
              color: Colors.black54,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }


  Widget _buildGoogleMap(BuildContext context,GeoPoint location) {

    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.73,
      width: MediaQuery.of(context).size.width,
      child: GoogleMap(
        buildingsEnabled: true,
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
            target: LatLng(location.latitude, location.longitude),
            zoom: 12),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
          _currentLocation();

        },
        myLocationEnabled: true,
        // myLocationButtonEnabled: true,
        zoomControlsEnabled: true,
        mapToolbarEnabled: true,
        zoomGesturesEnabled: true,
        markers: markers,
        onTap: (LatLng loc) {
          setState(() {
            isvisible = true;
            isselected = false;
          });
        },
      ),
    );
  }

  Future<void> _gotoLocation(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 15,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
  Future<void> _gotoLocationfirst(double lat, double long) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(lat, long),
      zoom: 11,
      tilt: 50.0,
      bearing: 45.0,
    )));
  }
  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }
}
