import 'package:hive/hive.dart';

class Settings {
  late Box setting;

  Settings(){
    setting =  Hive.box('setting');
  }


  getPermission(){
    bool permission = setting.get('permission', defaultValue: false);
    return permission;
  }

  getNotification(){
    bool notification = setting.get('notification', defaultValue: false);
    return notification;
  }

  getLocation(){
    bool location = setting.get('location', defaultValue: false);
    return location;
  }

  getSound(){
    bool sound = setting.get('sound', defaultValue: false);
    return sound;
  }

  setPermission(bool b){
    setting.put('permission',b);
  }

  setNotification(bool b){
    setting.put('notification',b);
  }

  setLocation(bool b){
    setting.put('location',b);
  }

  setSound(bool b){
    setting.put('sound',b);
  }

}