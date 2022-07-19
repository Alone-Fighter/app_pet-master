import 'package:app_pet/constants.dart';
import 'package:flutter/material.dart';
import 'package:multiselect/multiselect.dart';

class PetType extends StatefulWidget {
  PetType({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [
    'Perro',
    'Gato',
  ];
  String currentSelectedValue = 'Perro';

  @override
  _PetTypeState createState() => _PetTypeState();
}

class _PetTypeState extends State<PetType> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          color: Colors.white,
          width: 330,
          height: 40,
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 20,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  widget.myHint,
                  style: const TextStyle(color: Colors.grey),
                ),
                dropdownColor: Colors.white,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Container(
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey.shade400,
                  ),
                ),
                iconSize: 22,
                elevation: 16,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),

                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: PetType.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class SexType extends StatefulWidget {
  SexType({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = ['SEXO', 'Macho', 'Hembra'];
  String currentSelectedValue = 'SEXO';

  @override
  _SexTypeState createState() => _SexTypeState();
}

class _SexTypeState extends State<SexType> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          color: Colors.white,
          width: 330,
          height: 35,
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 20,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  widget.myHint,
                  style: const TextStyle(color: Colors.grey),
                ),
                dropdownColor: Colors.white,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Container(
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey.shade400,
                  ),
                ),
                iconSize: 22,
                elevation: 16,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),

                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: SexType.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PetSize extends StatefulWidget {
  PetSize({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [
    'TALLA',
    '0 - 1.9 Kg',
    '2 - 3.5 Kg',
    '3.6 - 7.5 Kg',
    '7.6 - 15 Kg',
    '16 - 30 Kg',
    '31 - 60 Kg',
  ];
  String currentSelectedValue = 'TALLA';

  @override
  _PetSizeState createState() => _PetSizeState();
}

class _PetSizeState extends State<PetSize> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          color: Colors.white,
          width: 330,
          height: 35,
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 20,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  widget.myHint,
                  style: const TextStyle(color: Colors.grey),
                ),
                dropdownColor: Colors.white,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Container(
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey.shade400,
                  ),
                ),
                iconSize: 22,
                elevation: 16,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),

                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: PetSize.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class PetSize2 extends StatefulWidget {
  PetSize2({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [
    'TALLA',
    '0 - 0.5 Kg',
    '0.6 - 2.4 Kg',
    '2.5 - 7.5 Kg',
    '7.6 kg  or more',
  ];
  String currentSelectedValue = 'TALLA';

  @override
  _PetSize2State createState() => _PetSize2State();
}

class _PetSize2State extends State<PetSize2> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          color: Colors.white,
          width: 330,
          height: 35,
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 20,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  widget.myHint,
                  style: const TextStyle(color: Colors.grey),
                ),
                dropdownColor: Colors.white,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Container(
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey.shade400,
                  ),
                ),
                iconSize: 22,
                elevation: 16,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),

                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: PetSize2.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class BreedType extends StatefulWidget {
  BreedType({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static List<String> deviceTypes = [
    'RAZA',
    'BREED',
    'AFFENPINSCHER',
    'AFGANO',
    'AIREDALE TERRIER',
    'AKITA',
    'ALASKA MALAMUTE',
    'AMERICAN BULLY',
    'AMERICAN STANFORD TERRIER',
    'AURDALE TERRIER',
    'BASENJI',
    'BASSET ARTESIANO',
    'BASSET HOUN',
    'BEAGLE',
    'BEARDED COLLIE',
    'BEDLINGTON TERRIER',
    'BICHON MALTES',
    'BIEWER YORKSHIRE TERRIER',
    'BLOOD HOUN',
    'BOBTAIL',
    'BORSOI',
    'BOSTON TERRIER',
    'BOXER',
    'BOYERO DE FLANDES',
    'BOYERO DE FLANDES',
    'BRACO ALEMAN',
    'BULDOG FRNACES',
    'BULL MASTIFF',
    'BULL TERRIER',
    'BULLDOG INGLES',
    'CAVALIER KING CHALES SPANIEL',
    'CHESASPEAKE RETRIEVER',
    'CHIHUHUA',
    'CHOW CHOW',
    'COCKER SPANIEL',
    'CORGI',
    'CRIOLLO',
    'DALMATE',
    'DOGO ALEMNA',
    'DOGO ARGENTINO',
    'DOGO DE BURDEOS',
    'DOOBERMAN PINSCHER',
    'ESQUIMAL CANADIENSE',
    'FILA BRASILERO',
    'FOS TERRIER',
    'FOX TERRIER ALAMBRE',
    'GALGO ITALIANO',
    'GOLDEN RETRIEVER',
    'GREYHOUND',
    'GRIFON DE BRUSELAS',
    'HARRIER',
    'HUSKY SIBERIANO',
    'JACK RISELL TERRIER',
    'KEESHOND',
    'LABRADOR RETRIEVER',
    'LEBREL IRLANDES',
    'LHAPSA APSO',
    'LOBO CHECHOSLOVACO',
    'LOBO DE SARDOS',
    'MASTIFF',
    'MASTIN',
    'MASTIN DE LOS PIRINEOS',
    'MASTIN NAPOLITANO',
    'PAPILLON',
    'PASTOR ALEMAN',
    'PASTOR BELGA GROENELDAEL',
    'PASTOR BELGA LAEKENOIS',
    'PASTOR BELGA MALENOIS',
    'PASTOR BERLGA TERVEUREN',
    'PASTOR BERNES',
    'PASTOR DE BRIE',
    'PASTOR DE LAS OVEJAS AUSTRALIANO',
    'PASTOR DE LOS GANADOS AUSTRALIANO',
    'PEKINES',
    'PELO CRESTADO CHINO',
    'PELOS SIN PELO PERUANO',
    'PINSCHER',
    'PITBULL',
    'POINTER INGLES',
    'POMERANIA',
    'POODLE',
    'PUG',
    'RODESIAN RIDENBACK',
    'ROTTWEILLER',
    'SALUKI',
    'SAMOYEDO',
    'SAN BERNARDO',
    'SCHNAUZER',
    'SCOTISH TERRIER',
    'SETTER GORDON',
    'SETTER INGLES',
    'SETTER IRLANDES',
    'SHAR PEI',
    'SHETLAND SPEED DOG',
    'SHIBA INU',
    'SHIH TZU',
    'SKYE TERRIER',
    'SPANIEL TIBETANO',
    'SPITZ ALEMAN',
    'SPRINGER SPANIEL',
    'TECKEL',
    'TERRANOVA',
    'WEIMARANER',
    'WEST HIGHLAND WHITE TERRIER',
    'XOLOITZCUITLE',
    'YORK SHIRE TERRIER',


  ];

  String currentSelectedValue = 'RAZA';

  @override
  _BreedTypeState createState() => _BreedTypeState();
}

class _BreedTypeState extends State<BreedType> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          color: Colors.white,
          width: 330,
          height: 35,
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 20,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  widget.myHint,
                  style: const TextStyle(color: Colors.grey),
                ),
                dropdownColor: Colors.white,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Container(
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey.shade400,
                  ),
                ),
                iconSize: 22,
                elevation: 16,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),

                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: BreedType.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
//////////////////////////////////////////////////////////////////////
class BreedType2 extends StatefulWidget {
  BreedType2({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static List<String> deviceTypes = [
    'RAZA',

    'ABISINIO',
    'AMARICAN SHORT HAIR',
    'ANGHORA',
    'BALINES',
    'BENGALA',
    'BIRMANO',
    'BOBTAIL AMERICANO',
    'BOMBAY',
    'BORSQUE DE NORUEGA',
    'BRITANICO DE PELO CORTO',
    'BRITISH FOLD',
    'BURMES',
    'CARACAT',
    'CARTUJO',
    'CHAUSIE',
    'CRIOLLO',
    'CURL AMERICANO',
    'DEVON REX',
    'ESFINGE',
    'EUROPEAN SHORT HAIR',
    'EXOTICO PELO CORTO',
    'EXOTICO PELO LARGO',
    'HIGHLAND FOLD',
    'HIMALAYO',
    'KORAT',
    'MAINE COON',
    'PERSA',
    'RAGDOLL',
    'RUSO AZUL',
    'SAVANNAH',
    'SCOTTISH FOLD',
    'SIAMES',
    'SOMALI',
    'TURCO',




  ];

  String currentSelectedValue = 'RAZA';

  @override
  _BreedType2State createState() => _BreedType2State();
}

class _BreedType2State extends State<BreedType2> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          color: Colors.white,
          width: 330,
          height: 35,
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 20,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  widget.myHint,
                  style: const TextStyle(color: Colors.grey),
                ),
                dropdownColor: Colors.white,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Container(
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey.shade400,
                  ),
                ),
                iconSize: 22,
                elevation: 16,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),

                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: BreedType2.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class City extends StatefulWidget {
  City({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [

    'Ciudad',
    'BOGOTA',
    'MEDELLIN',
    'CALI',
    'BUCARAMANGA',
    'BARRANQUILLA',
    'CARTAGENA',
    'SANTA MARTA',
    'MANIZALES',
    'CUCUTA',
    'PEREIRA',
    'IBAGUE',
    'VILLAVICENCIO',
    'PASTO',
    'TUNJA',
    'VALLEDUPAR',
    'MONTERIA',
    'ARMENIA',
    'POPAYAN',
    'NEIVA',
    'RIOHACHA',
    'BUENAVENTURA',
    'QUIBDO',
    'SINCELEJO',
    'FLORENCIA',
    'YOPAL',
    'SOACHA',
    'BARRANCABERMEJA',
    'IPIALES',
    'TULUA',
    'PALMIRA',
    'LETICIA',
    'CARTAGO',
    'TUMACO',
    'ZIPAQUIRAÀ',
    'SAN JOSÈ DEL GUAVIARE',
    'GIRARDOT',
    'MOCOA',
    'PUERTO CARREÑO',
    'BELLO',
    'DUITAMA',
    'MITÙ',
    'BUGA',
    'APARTADO',
    'MAICAO',
    'CIÈNAGA',
    'ITAGÙI',
    'YUMBO',
    'MOMPÒS',
    'FUSAGASUGÀ',
    'INIRIDA',
    'JAMUNDI',
  ];
  String currentSelectedValue = 'Ciudad';

  @override
  _CityState createState() => _CityState();
}

class _CityState extends State<City> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          color: Colors.white,
          width: 330,
          height: 40,
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 20,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  widget.myHint,
                  style: const TextStyle(color: Colors.grey),
                ),
                dropdownColor: Colors.white,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Container(
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey.shade400,
                  ),
                ),
                iconSize: 22,
                elevation: 16,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),

                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: City.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class Expert extends StatefulWidget {
  Expert({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [
    'Especialidad',
    'Medicina General.',
    'Cardiología.',
    'Dermatología.',
    'Ortopedia.',
    'Oftalmología.',
    'Oncología.',
  ];
  String currentSelectedValue = 'Especialidad';

  @override
  _ExpertState createState() => _ExpertState();
}

class _ExpertState extends State<Expert> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          color: Colors.white,
          width: 330,
          height: 35,
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 20,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  widget.myHint,
                  style: const TextStyle(color: Colors.grey),
                ),
                dropdownColor: Colors.white,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Container(
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey.shade400,
                  ),
                ),
                iconSize: 22,
                elevation: 16,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),

                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: Expert.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class WorkAs extends StatefulWidget {
  WorkAs({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [
    'Trabajas Como',
    'Independiente',
    'En establecimiento veterinario'
  ];
  String currentSelectedValue = "Trabajas Como";

  @override
  _WorkAsState createState() => _WorkAsState();
}

class _WorkAsState extends State<WorkAs> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          color: Colors.white,
          width: 330,
          height: 35,
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 20,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  widget.myHint,
                  style: const TextStyle(color: Colors.grey),
                ),
                dropdownColor: Colors.white,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Container(
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey.shade400,
                  ),
                ),
                iconSize: 22,
                elevation: 16,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),

                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: WorkAs.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
class MultiSelected extends StatefulWidget {
  const MultiSelected({Key? key,required this.onChanged}) : super(key: key);
  final ValueChanged<List<String>?>? onChanged;
  @override
  _MultiSelectedState createState() => _MultiSelectedState();
}

class _MultiSelectedState extends State<MultiSelected> {


  List<String> selected = [];


  @override
  Widget build(BuildContext context) {
    return
          Container(
            color: Colors.white,
            width: 330,
            height: 50,
            margin: const EdgeInsets.only(
              top: 10,
              right: 10,
              left: 20,
            ),
            // DropDownMultiSelect comes from multiselect
            child: DropDownMultiSelect(
              onChanged: (List<String> x) {
                setState(() {
                  selected = x ;
                  widget.onChanged!.call(selected);
                });
              },
              options: const [
                'Servicios que ofrece',
                'Consulta veterinaria',
                'Hospitalizacion',
                'Cirugia',
                'Petshop',
                'Guarderia',
                'Baño y peluquerìa',
                'Otros servicios',
              ],
              selectedValues: selected,
              whenEmpty: 'Servicios que ofrece',
            ),
          )
        ;
  }
}


class Services extends StatefulWidget {
  Services({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [
    'Servicios que ofrece',
    'Consulta veterinaria',
    'Hospitalizacion',
    'Cirugia',
    'Petshop',
    'Guarderia',
    'Baño y peluquerìa',
    'Otros servicios',
  ];
  String currentSelectedValue = 'Servicios que ofrece';

  @override
  _ServicesState createState() => _ServicesState();
}


class _ServicesState extends State<Services> {



  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          color: Colors.white,
          width: 330,
          height: 35,
          margin: const EdgeInsets.only(
            top: 10,
            right: 10,
            left: 20,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  widget.myHint,
                  style: const TextStyle(color: Colors.grey),
                ),
                dropdownColor: Colors.white,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Container(
                  child: Icon(
                    Icons.keyboard_arrow_down_sharp,
                    color: Colors.grey.shade400,
                  ),
                ),
                iconSize: 22,
                elevation: 16,

                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),

                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: Services.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}

class City2 extends StatefulWidget {
  City2({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [
    'BOGOTA',
    'MEDELLIN'
        'CALI',
    'BUCARAMANGA',
    'BARRANQUILLA',
    'CARTAGENA',
    'SANTA MARTA',
    'MANIZALES',
    'CUCUTA',
    'PEREIRA',
    'IBAGUE',
    'VILLAVICENCIO',
    'PASTO',
    'TUNJA',
    'VALLEDUPAR',
    'MONTERIA',
    'ARMENIA',
    'POPAYAN',
    'NEIVA',
    'RIOHACHA',
    'BUENAVENTURA',
    'QUIBDO',
    'SINCELEJO',
    'FLORENCIA',
    'YOPAL',
    'SOACHA',
    'BARRANCABERMEJA',
    'IPIALES',
    'TULUA',
    'PALMIRA',
    'LETICIA',
    'CARTAGO',
    'TUMACO',
    'ZIPAQUIRAÀ',
    'SAN JOSÈ DEL GUAVIARE',
    'GIRARDOT',
    'MOCOA',
    'PUERTO CARREÑO',
    'BELLO',
    'DUITAMA',
    'MITÙ',
    'BUGA',
    'APARTADO',
    'MAICAO',
    'CIÈNAGA',
    'ITAGÙI',
    'YUMBO',
    'MOMPÒS',
    'FUSAGASUGÀ',
    'INIRIDA',
    'JAMUNDI',
  ];
  String currentSelectedValue = "BOGOTA";

  @override
  _City2State createState() => _City2State();
}

class _City2State extends State<City2> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          color: Colors.transparent,
          width: 100,
          height: 50,
          margin: const EdgeInsets.only(
            right: 10,
            left: 20,
          ),
          child: Column(
            children: [
              DropdownButtonHideUnderline(
                child: Container(
                  margin: const EdgeInsets.only(right: 5, left: 15),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    hint: Text(
                      widget.myHint,
                      style: const TextStyle(color: kLightBlue),
                    ),
                    dropdownColor: Colors.white,
                    value: widget.currentSelectedValue,
                    //iconEnabledColor: Colors.red,
                    icon: const Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: kLightBlue,
                    ),
                    iconSize: 22,
                    elevation: 16,

                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                    ),

                    onChanged: (String? newValue) {
                      setState(() {
                        widget.currentSelectedValue = newValue!;
                        widget.onChanged!.call(widget.currentSelectedValue);
                      });
                    },
                    items: City.deviceTypes.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              Container(
                height: 1,
                color: kLightBlue,
              ),
            ],
          ),
        );
      },
    );
  }
}
class Desparas_inter extends StatefulWidget {
  Desparas_inter({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [
    'NexGard Spectra',
    'Advocate',
    'Revolution',
    'Drontal',
    'Endogard',
    'Total',
    'Canisan',
    'Rondel',
    'Otro.Cual?'
  ];
  String currentSelectedValue = 'Advocate';

  @override
  _Desparas_interState createState() => _Desparas_interState();
}

class _Desparas_interState extends State<Desparas_inter> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return SizedBox(
          height: 40,
          child: DropdownButtonHideUnderline(
            child: Container(
              height: 30,
              margin: const EdgeInsets.only(right: 5, left: 15),
              child: DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  '${widget.myHint}',
                  style: const TextStyle(color: Colors.grey ,fontSize: 5),
                ),
                dropdownColor: Colors.grey,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.grey.shade400,
                ),
                iconSize: 22,
                elevation: 16,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: Desparas_inter.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}


class Desparas_extern extends StatefulWidget {
  Desparas_extern({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [
    'NexGard',
    'Advocate',
    'Advantage',
    'Advanitix',
    'Attack',
    'Bravecto',
    'Comfortis',
    'Credelio',
    'Simparica',
    'Otro.Cual?'
  ];
  String currentSelectedValue = 'Advocate';

  @override
  _Desparas_externState createState() => _Desparas_externState();
}

class _Desparas_externState extends State<Desparas_extern> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          height: 30,
          margin: const EdgeInsets.only(
            top: 10,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 15),
              child:  DropdownButton<String>(
                isExpanded: true,
                hint: Text(
                  '${widget.myHint}',
                  style: const TextStyle(color: Colors.grey ,fontSize: 5),
                ),
                dropdownColor: Colors.grey,
                value: widget.currentSelectedValue,
                //iconEnabledColor: Colors.red,
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.grey.shade400,
                ),
                iconSize: 22,
                elevation: 16,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: Desparas_extern.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}
class NewYear extends StatefulWidget {
  NewYear({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = [

    '2022',
    '2023',
    '2024',
    '2025',
    '2026',
    '2027',
    '2028',
    '2029',
    '2030',

  ];
  String currentSelectedValue = '2022';

  @override
  _NewYearState createState() => _NewYearState();
}

class _NewYearState extends State<NewYear> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      builder: (FormFieldState<String> state) {
        return Container(
          width: 150,
          color: Colors.transparent,
          height: 130,
          margin: const EdgeInsets.only(
            top: 10,
          ),
          child: DropdownButtonHideUnderline(
            child: Container(
              margin: const EdgeInsets.only(right: 5, left: 10),
              child:  DropdownButton<String>(
                isExpanded: true,
                dropdownColor: Colors.grey,
                value: widget.currentSelectedValue,
                hint: Text(
                  '${widget.myHint}',
                  style: const TextStyle(color: Colors.grey ,fontSize: 5),
                ),
                //iconEnabledColor: Colors.red,
                icon: Icon(
                  Icons.keyboard_arrow_down_sharp,
                  color: Colors.grey.shade400,
                ),
                iconSize: 22,
                elevation: 16,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
                underline: Container(
                  height: 2,
                  color: Colors.grey,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.currentSelectedValue = newValue!;
                    widget.onChanged!.call(widget.currentSelectedValue);
                  });
                },
                items: NewYear.deviceTypes.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value.toString(),
                    child: Text(value.toString()),
                  );
                }).toList(),
              ),
            ),
          ),
        );
      },
    );
  }
}