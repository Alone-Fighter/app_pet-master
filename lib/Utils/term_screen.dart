import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TermsScreen extends StatefulWidget {
  const TermsScreen({Key? key}) : super(key: key);

  @override
  State<TermsScreen> createState() => _TermsScreenState();
}

class _TermsScreenState extends State<TermsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Container(
      color: Colors.white,
child: PageView(
  scrollDirection: Axis.vertical,
  children: [
    Image.asset('assets/images/term1.jpeg'),
    Image.asset('assets/images/term2.jpeg'),
    RawMaterialButton(
        onPressed: () async {
          final url='https://www.sudamerica.boehringer-ingelheim.com/sites/sudamerica/files/documents/politica_de_tratamiento_de_datos_personales-co.pdf';
          if(await canLaunch(url) ){
            await launch(url);
          }
        },
        child: Image.asset('assets/images/term3.jpeg')),
    Image.asset('assets/images/term4.jpeg'),
    RawMaterialButton(
        onPressed: () async {
          final url='https://www.sudamerica.boehringer-ingelheim.com/sites/sudamerica/files/files/politica-proteccion-de-datos-bico.pdf';
          if(await canLaunch(url) ){
            await launch(url);
          }
        },
        child: Image.asset('assets/images/term5.jpeg')),
    Image.asset('assets/images/term6.jpeg'),
    RawMaterialButton(
        onPressed: () async {
          final url='https://consejoprofesionalmvz.gov.co/';
          if(await canLaunch(url) ){
            await launch(url);
          }
        },
        child: Image.asset('assets/images/term7.jpeg')),

],),
    ));
  }
}
