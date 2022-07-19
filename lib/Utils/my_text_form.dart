import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'config.dart';
import 'custom_snackbar.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm(
      {required this.labelname,
      required this.hinttext,
      required this.whC,
      required this.fontsize,
      required this.myWidth,
      required this.keyType,
      this.passkey,
      this.dayV,
      this.monthV,
      this.yearV});

  final keyType;
  final labelname;
  final myWidth;
  final hinttext;
  final whC;
  final passkey;
  final dayV;
  final monthV;
  final yearV;
  final fontsize;

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: widget.myWidth,
      height: 50,
      margin: const EdgeInsets.only(
        top: 10,
        right: 10,
        left: 20,

      ),

      child: TextFormField(

        validator: (value) {
          if (value!.isEmpty) {
            return 'Please type something';
          } else {
            return null;
          }
        },
        // inputFormatters: [
        //   LengthLimitingTextInputFormatter(50),
        // ],

        obscureText: (widget.passkey == 1) ? true : false,
        enableSuggestions: (widget.passkey == 1) ? false : true,
        autocorrect: (widget.passkey == 1) ? false : true,
        keyboardType:
            (widget.keyType == 0) ? TextInputType.text : TextInputType.number,
        controller: widget.whC,
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white, width: 3),
          ),
          labelText: widget.labelname,
          labelStyle: TextStyle(color: Colors.grey, fontSize: widget.fontsize),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: widget.hinttext,
          hintStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: widget.fontsize),
        ),
      ),
    );
  }

  InputValidationMixin() {
    if (widget.dayV) {
      bool isDayValid(whC) {
        if (whC <= 31 && whC > 0) {
          return true;
        } else {
          return ModeSnackBar.show(
              context, 'we just have 31 day:)', SnackBarMode.error);
        }
      }
    } else if (widget.monthV) {
      bool isMonthValid(whC) {
        if (whC <= 12 && whC > 0) {
          return true;
        } else {
          return ModeSnackBar.show(
              context, 'we just have 12 month:)', SnackBarMode.error);
        }
      }
    } else if (widget.yearV) {
      bool isYearValid(String whC) {
        if (whC.length == 4) {
          return true;
        } else {
          return ModeSnackBar.show(
              context, 'Enter Correctly', SnackBarMode.error);
        }
      }
    }
  }
}

//---------------------------------------------------------------------------
class typeFieldWidget extends StatefulWidget {
  typeFieldWidget({required this.myHint, required this.onChanged});

  final myHint;
  final ValueChanged<String?>? onChanged;
  static const deviceTypes = ["Mac", "Windows", "Mobile"];
  String currentSelectedValue = "Mac";

  @override
  _typeFieldWidgetState createState() => _typeFieldWidgetState();
}

class _typeFieldWidgetState extends State<typeFieldWidget> {
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
              margin: const EdgeInsets.only(right: 5, left: 15,bottom: 5),
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
                items: typeFieldWidget.deviceTypes.map((String value) {
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

class DatePicker extends StatefulWidget {


  DatePicker(this.day, this.month, this.year, this.label,{ required this.onChanged});

  final bool day;
  final bool month;
  final bool year;
  final String label;
  final ValueChanged<String?>? onChanged;
  String currentSelectedValue = "";

  @override
  State<StatefulWidget> createState() {
    return DatePickerState();
  }
}

class DatePickerState extends State<DatePicker> {
  List selectedItemValue = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: 1,
        itemExtent: 50.0,
        itemBuilder: (BuildContext context, int index) {
          for (int i = 0; i < 20; i++) {
            selectedItemValue.add(
              "${widget.label}",
            );
          }
          return Container(
            width: 70,
            height: 40,
            child: DropdownButtonHideUnderline(
              child: Container(
                margin: const EdgeInsets.only(right: 5, left: 10),
                child: DropdownButton(
                  isExpanded: true,
                  icon: Container(
                    child: Icon(
                      Icons.keyboard_arrow_down_sharp,
                      color: Colors.grey.shade400,
                    ),
                  ),
                  value: selectedItemValue[index].toString(),
                  items: _dropDownItem(),
                  onChanged: (value) {
                    selectedItemValue[index] = value;
                    setState(() {
                      widget.currentSelectedValue = value.toString();
                      widget.onChanged!.call(widget.currentSelectedValue);
                    });
                  },
                ),
              ),
            ),
          );
        });
  }

  List<DropdownMenuItem<String>> _dropDownItem() {
    if (widget.year == true) {
      var now = DateTime.now();
      var formatter = DateFormat('yyyy');
      String nowYear = formatter.format(now);

      List<String> ddl = [
        "${widget.label}",
      ];
      int myYear = int.parse(nowYear);
      for (int i = 1900; i <= myYear; i++) {
        ddl.add(i.toString());
      }

      return ddl
          .map((value) => DropdownMenuItem(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.grey)),
              ))
          .toList();
    } else if (widget.day == true) {
      List<String> ddl = [
        "${widget.label}",
      ];

      for (int i = 1; i <= 31; i++) {
        ddl.add(i.toString());
      }

      return ddl
          .map((value) => DropdownMenuItem(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.grey)),
              ))
          .toList();
    } else {
      List<String> ddl = [
        "${widget.label}",
      ];


         ddl=[
           'Mes',
          // 'Enero',
          // 'Febrero',
          // 'Marzo',
          // 'Abril',
          // 'Mayo',
          // 'Junio',
          // 'Julio',
          // 'Agosto',
          // 'Septiembre',
          // 'Octubre',
          // 'Noviembre',
          // 'Diciembre',
           '1',
           '2',
           '3',
           '4',
           '5',
           '6',
           '7',
           '8',
           '9',
           '10',
           '11',
           '12',
        ];
        //ddl.add(mes.toString());


      return ddl
          .map((value) => DropdownMenuItem(
                value: value,
                child: Text(value, style: TextStyle(color: Colors.grey)),
              ))
          .toList();
    }
  }
}
