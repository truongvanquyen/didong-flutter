import 'package:flutter/material.dart';
import 'package:project_login/login.dart';
import 'package:project_login/main.dart';
import 'package:project_login/models/Users.dart';
import 'package:project_login/services/api_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:logger/logger.dart';
import 'package:quickalert/quickalert.dart';

class ApiConnect extends ChangeNotifier {

  static Future<bool> loginAPI(Map<String, dynamic> data) async {
    try {
      Users? users = await locator<RestClient>().login(data);
      if (users != null && users.token != null) {
        saveTokenToSharedPreferences(users.token.toString());
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }

  static Future<void> logoutAPI(context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("token");
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginPage()));
  }
  static Future<void> saveTokenToSharedPreferences(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    print("Lưu token");
  }

  static Future<bool> submitForgotPassword(Map<String, dynamic> data) async {
    try {
      Users? users = await locator<RestClient>().forgotPassword(data);
      print(users!.errors!.first.toString());
      return true;
    } catch (error) {
      print(error);
      return false;
    }
  }
//xác minh
  static Future<String> submitVerification(int data) async {
    try {
      Users? users = await locator<RestClient>().verify(data);
      print(users!.token.toString());
      return users!.token.toString();
    } catch (error) {
      print(error);
      return "";
    }
  }
//thay đổi
  static Future<bool> submitPassword(Map<String, dynamic> data,String idUser) async {

    try {
      Users? users = await locator<RestClient>().changePassword(data,idUser);
      if (users != null && users.token != null) {
        saveTokenToSharedPreferences(users.token.toString());
        return true;
      } else {
        return false;
      }
    } catch (error) {
      print(error);
      return false;
    }
  }


}
