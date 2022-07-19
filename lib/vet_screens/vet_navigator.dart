
import 'package:app_pet/Ui/Location.dart';
import 'package:app_pet/Ui/calendar_view.dart';
import 'package:app_pet/Ui/main_menu.dart';
import 'package:app_pet/Ui/settings_page.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:app_pet/screens/medical_diary.dart';
import 'package:flutter/material.dart';


class vetNavigatorBar extends StatefulWidget {
  const vetNavigatorBar({Key? key}) : super(key: key);

  @override
  State<vetNavigatorBar> createState() => _vetNavigatorBarState();
}

class _vetNavigatorBarState extends State<vetNavigatorBar> {
  int currentIndex = 0;
  final List<Widget> children =
  [
    MainMenu(),
    MedicalDiary(),
    const CalendarView(),
    LocationScreen(),
    const SettingPage(),
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        child: children[currentIndex],
      ),
      drawer: Drawer(
        child: Container(
          width: w * 0.80,
          height: double.infinity,
          color: Config.white,
          child: Text('sddsgf'),
        ),
      ),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 10 , right: 10 , bottom: 10),
        decoration:  BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          boxShadow:  [
            BoxShadow(color: Colors.black.withOpacity(.2), spreadRadius: 1, blurRadius:5),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0)
          ),
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/home.png',
                  height: 30,
                  width: 30,
                  color: Colors.black54,
                ),
                label: 'inicio',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/medicaldiary.png',
                  height: 30,
                  width: 30,
                  color: Colors.black54,
                ),
                label: 'Medical diary',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/mycalendar.png',
                  height: 30,
                  width: 30,
                  color: Colors.black54,
                ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/location.png',
                  height: 30,
                  width: 30,
                  color: Colors.black54,
                ),
                label: 'home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  'assets/images/settings.png',
                  height: 30,
                  width: 30,
                  color: Colors.black54,
                ),
                label: 'home',
              ),
            ],
            currentIndex: currentIndex,
            onTap: (index) => setState(() {
              currentIndex = index;
            }),
            selectedItemColor: Colors.blue.shade400,
            unselectedItemColor: Colors.red,
          ),
        ),
      ),
    );
  }
}
