import 'package:app_pet/CustomWidgets/button.dart';
import 'package:app_pet/DataSaver/settings.dart';
import 'package:app_pet/Provider/ApiService.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:provider/provider.dart';
import 'package:app_pet/Utils/term_screen.dart';
import '../constants.dart';
import '../main.dart';

class SettingChangeNotifier extends ChangeNotifier {
  late Settings settings;

  bool permission = false;
  bool notification = false;
  bool location = false;
  bool sound = false;

  isPermission() => permission;

  isNotification() => notification;

  isLocation() => location;

  isSound() => sound;

  SettingChangeNotifier() {
    init();
  }

  init() async {
    await Hive.openBox('setting');
    settings = Settings();
    permission = settings.getPermission();
    notification = settings.getNotification();
    location = settings.getLocation();
    sound = settings.getSound();
    notifyListeners();
  }

  setPermission(bool b) {
    settings.setPermission(b);
    permission = b;
    notifyListeners();
  }

  setNotification(bool b) {
    settings.setNotification(b);
    notification = b;
    notifyListeners();
  }

  setLocation(bool b) {
    settings.setLocation(b);
    location = b;
    notifyListeners();
  }

  setSound(bool b) {
    settings.setSound(b);
    sound = b;
    notifyListeners();
  }
}

class SettingPage extends StatelessWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Configuration',
          style: Config.textStyleH(Config.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(child: Consumer<SettingChangeNotifier>(
        builder: (context, value, child) {
          return Container(
            color: Colors.black.withOpacity(.04),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                Container(
                  height: 40,
                  padding: const EdgeInsets.only(left: 16),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'PERFIL',
                    style: Config.textStyleS(Colors.black.withOpacity(.5)),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Config.white,
                  child: Column(
                    children: [
                      SwitchButtonSetting(
                        text: 'Notificaciones',
                        value: value.isNotification(),
                        onChange: (val) {
                          value.setNotification(val);
                        },
                      ),
                      SwitchButtonSetting(
                        text: 'Ubicación',
                        value: value.isLocation(),
                        onChange: (val) {
                          value.setLocation(val);
                        },
                      ),
                      // SwitchButtonSetting(
                      //   text: 'Sound',
                      //   value: value.isSound(),
                      //   onChange: (val) {
                      //     value.setSound(val);
                      //   },
                      // )
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: Config.white,
                  margin: const EdgeInsets.only(top: 8),
                  child: Column(
                    children: [
                      TextButtonSetting(
                        text: 'Ayuda',
                        onClick: () {},
                      ),
                      TextButtonSetting(
                        text: 'Terminos y condiciones ',
                        onClick: () {
                          kNavigator(context, TermsScreen());
                        },
                      ),
                      TextButtonSetting(
                        text: 'Cerrar sesión ',
                        onClick: () {
                          Provider.of<ApiService>(context, listen: false)
                              .signOut(context);
                        },
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                ),
                const Text(
                  '¿Tienes alguna pregunta? Escríbenos a AHAnimalHealthComunication.BOG@boehringer-ingelheim.com',
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
                )
              ],
            ),
          );
        },
      )),
    );
  }
}
