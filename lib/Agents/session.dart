// ignore_for_file: deprecated_member_use

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';


class UserSessionData {
  int id;
  String email;
  UserSessionData(
      {required this.id,
      required this.email,
      });
  static UserSessionData? sessionUser;
  factory UserSessionData.fromJson(Map<dynamic, dynamic> i) => UserSessionData(
        //Recuperer un fichier Json depuis la Bd
        id: i["id_agt"],
        email: i["username"],
      );

  Map<String, dynamic> toMap() => {
        //convertir le fichier json en map
        "id_agt": id,
        "username": email,
      };

  static void savesession(UserSessionData user) async {
    //save data
    final prefs = await SharedPreferences.getInstance();
    var userdata =
        json.encode(user.toMap()); //convertir la map en string a l'aide de json
    prefs.setString("user", userdata);
    prefs.commit();
    print("SessionSave");
  }

  static getuser() async {
    final prefs = await SharedPreferences.getInstance();
    var data = prefs.getString("user");
    if (data =="") {
      sessionUser = null;
    } else {
      var userDecode = json.decode(data!);
      var user = UserSessionData.fromJson(userDecode);
      sessionUser = user;
      print(sessionUser);
    }
  }

  static Disconnect() async {
    final p = await SharedPreferences.getInstance();
    p.setString("user", '');
    sessionUser = null;
    p.commit();
    print('Disconnected');
  }
}


