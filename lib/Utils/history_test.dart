// import 'package:app_pet/Model/historyM.dart';
// import 'package:app_pet/Provider/ApiService.dart';
// import 'package:flutter/cupertino.dart';
//
// class historytest extends StatelessWidget {
//   const historytest({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: FutureBuilder<List<historyData>>(
//         future: context.read<ApiService>().getAllHistory(petId , mode),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             return ListView.builder(
//               itemCount: snapshot.data!.length,
//               itemBuilder: (context, index) {
//                 {
//                   return  Container(
//                     margin: const EdgeInsets.all(15),
//                     alignment: Alignment.center,
//                     height: MediaQuery.of(context).size.height * 0.1,
//                     width: MediaQuery.of(context).size.width*0.1,
//                     child: Image.network(HistoryData.image, fit: BoxFit.fill,),
//                   );
//                 }
//               },
//             );
//             //;
//           } else if (snapshot.hasError) {
//             return Column(
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.5,
//                 ),
//                 Text(snapshot.error.toString()),
//                 IconButton(
//                     icon: const Icon(
//                       Icons.search,
//                       color: Colors.black,
//                     ),
//                     onPressed: () {
//                       print(snapshot.error.toString());
//                     })
//               ],
//             );
//           }
//
//           return const Waitting(
//             backgroundColor: Colors.white,
//           );
//         },
//       ),
//     );
//   }
// }
