// import 'package:app_pet/Provider/ApiService.dart';
// import 'package:app_pet/Utils/waitting_animation.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
//
// class GetUserName extends StatelessWidget {
//   final String documentId;
//
//   GetUserName(this.documentId);
//
//   @override
//   Widget build(BuildContext context) {
//     CollectionReference users = FirebaseFirestore.instance.collection('users');
//
//     return FutureBuilder<DocumentSnapshot>(
//       future: users.doc(documentId).get(),
//       builder:
//           (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//
//         if (snapshot.hasError) {
//           return Text("Something went wrong");
//         }
//
//         if (snapshot.hasData && !snapshot.data!.exists) {
//           return Text("Document does not exist");
//         }
//
//         if (snapshot.connectionState == ConnectionState.done) {
//           Map<String, dynamic> data = snapshot.data!.data() as Map<String, dynamic>;
//           return Text("Full Name: ${data['full_name']} ${data['last_name']}");
//         }
//
//         return Text("loading");
//       },
//     );
//   }
// }
// class documentid extends StatelessWidget {
//   const documentid({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     // return Container(
//     //   margin: const EdgeInsets.symmetric(vertical: 8),
//     //   height: 55,
//     //   width: double.infinity,
//     //   child: Stack(
//     //     children: [
//     //       Positioned(
//     //           child: Align(
//     //             alignment: Alignment.centerLeft,
//     //             child: Container(
//     //               width: double.infinity,
//     //               height: 70,
//     //               margin: const EdgeInsets.only(left: 4),
//     //               decoration: BoxDecoration(
//     //                 borderRadius: BorderRadius.circular(10),
//     //                 color: Colors.blue,
//     //               ),
//     //               child: Row(
//     //                 children: [
//     //                   Padding(
//     //                     padding: const EdgeInsets.only(left: 16),
//     //                     child: Text(
//     //                       data['day'],
//     //                       style: Config.textStyleB(Config.white),
//     //                     ),
//     //                   ),
//     //                   Padding(
//     //                     padding: const EdgeInsets.only(left: 32),
//     //                     child: Text(
//     //                       data['mode'],
//     //                       style: Config.textStyleH(Config.white),
//     //                     ),
//     //                   ),
//     //                   Spacer(),
//     //                   Padding(
//     //                       padding: const EdgeInsets.only(left: 32),
//     //                       child:IconButton(onPressed: (){
//     //                         FirebaseAuth auth = FirebaseAuth.instance;
//     //                         String petId =
//     //                             Provider.of<ApiService>(context,listen: false)
//     //                                 .getSelectedPet;
//     //                         print(FirebaseFirestore.instance.collection('pets').doc(auth.currentUser!.uid).collection('pet').doc(petId).collection('calendar').doc().toString());
//     //                         //FirebaseFirestore.instance.collection('pets').doc(auth.currentUser!.uid).collection('pet').doc(petId).collection('calendar').doc().delete();
//     //
//     //                       },
//     //                         icon: Icon(Icons.delete_outline_outlined,color: Colors.white,size: 20,),)
//     //                   )
//     //                 ],
//     //               ),
//     //             ),
//     //           )),
//     //       Positioned(
//     //           child: Align(
//     //             alignment: Alignment.centerLeft,
//     //             child: Container(
//     //               width: 8,
//     //               height: 35,
//     //               decoration: BoxDecoration(
//     //                   color: Colors.lightBlueAccent,
//     //                   borderRadius: BorderRadius.circular(5)),
//     //             ),
//     //           )),
//     //     ],
//     //   ),
//     // );
//   }
// }
