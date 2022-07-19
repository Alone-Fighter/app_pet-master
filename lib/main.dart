import 'dart:async';

import 'package:app_pet/CustomWidgets/calendar2.dart';
import 'package:app_pet/Ui/pet_login.dart';
import 'package:app_pet/Utils/config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart';
import 'CustomWidgets/calendar.dart';
import 'CustomWidgets/calendar2.dart';
import 'CustomWidgets/calendar3.dart';
import 'CustomWidgets/navigatebar.dart';
import 'CustomWidgets/vet_navigationbar.dart';
import 'Model/alarm_info.dart';
import 'Provider/ApiService.dart';
import 'Provider/MusicPlayer.dart';
import 'Provider/RecordControler.dart';
import 'Ui/calendar_view.dart';
import 'Ui/intro.dart';
import 'Ui/settings_page.dart';
import 'Utils/my_button.dart';
import 'constants.dart';
import 'firebase_options.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await Hive.initFlutter();
  Hive.registerAdapter(AlarmInfoAdapter());
  await Hive.openBox('vet');
  var initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
  var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
          ) async {});
  var initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String? payload) async {
        if (payload != null) {
          debugPrint('notification payload: $payload');
        }
      });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => SettingChangeNotifier(),),
      ChangeNotifierProvider(create: (context) => CalendarChangeNotifier(),),
      ChangeNotifierProvider(create: (context) => CalendarViewChangeNotifier(),),
      ChangeNotifierProvider(create: (context) => CalendarChangeNotifier2(),),
      ChangeNotifierProvider(create: (context) => CalendarChangeNotifier3(),),
      ChangeNotifierProvider(create: (context) => ApiService(),),
      ChangeNotifierProvider(create: (context) => RecordController(),),
      ChangeNotifierProvider(create: (context) => MusicPlayer(),),
    ],
    child: MaterialApp(

      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  const MyHomePage(),
    ),);
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  void initState() {// TODO: implement initState
    super.initState();
    bool a = context.read<ApiService>().checkLogin();
    Timer.periodic(const Duration(seconds: 3), (timer){
      Box b = Hive.box('vet');
          if(a){
            Provider.of<ApiService>(context , listen: false).getDefPet();
            kNavigatorBack(context);
            if(b.get('vet' , defaultValue: false)){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const VetNavigatorBar()));
            }else{
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const NavigatorBar()));
            }
          }else{
            kNavigatorBack(context);
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const MainClass()));
          }
      timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Config.blue,
      body: Center(
        child: Image(image: const AssetImage('assets/images/wlogo.png'),width: w / 3, height:  w/3,),
      ),
    );
  }
}


class MainClass extends StatelessWidget {
  const MainClass({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ApiService>(builder: (context, value, child) {
      return Scaffold(
        body: Center(
            child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  image: DecorationImage(
                    image: AssetImage("assets/images/start.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.53,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MyImagedButton(
                            'assets/images/start2.png', 120.0, 120.0, () {
                          value.setVet(true);
                          kNavigator(context,  const IntroPage(vet: true));
                        }),
                        MyImagedButton('assets/images/start3.png', 120.0, 120.0, (){
                          value.setVet(false);
                          kNavigator(context,   const IntroPage(vet: false));
                        })
 
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.13,
                    ),
                    RichText(
                      text:  TextSpan(
                        text: '¿Ya estás registrado?   ',style: const TextStyle(color: Colors.grey,
                          fontSize: 14
                      ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Inicia sesión',
                            style: const TextStyle(color: kLightBlue,

                                fontSize: 14
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                kNavigator(context, Login());
                              },
                          ),
                        ],
                      ),
                    ) ],
                ))),
      );
    },);
  }
}


