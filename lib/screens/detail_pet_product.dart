import 'package:app_pet/CustomWidgets/drawer.dart';
import 'package:app_pet/CustomWidgets/headerpage.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class DetailProduct extends StatelessWidget {
  Map<String, dynamic> data;

  DetailProduct({required this.data});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kBlueProduct,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Spacer(
              flex: 1,
            ),
            Text(
              data['name'],
              style: TextStyle(color: Config.white, fontSize: 25),
            ),
            const Spacer(
              flex: 2,
            )
          ],
        ),
      ),
      body: HeaderPage(
          widget: Column(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  padding: EdgeInsets.only(top: 60),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                        fit: BoxFit.fill,
                        width: 200,
                        height: 150,
                        image: NetworkImage(data['image']),
                      )),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                data['name'],
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                data['description'],
                style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          background: "assets/images/direct.png",
          color: Colors.blue),
    );
  }
}
