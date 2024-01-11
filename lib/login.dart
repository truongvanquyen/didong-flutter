import 'package:flutter/material.dart';
import 'package:project_login/forgot_password.dart';
import 'package:project_login/home.dart';
import 'package:project_login/services/api_connect.dart';
import 'package:quickalert/quickalert.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool hintPassword = true;
  Future<void> checkLogin() async {
    Map<String, dynamic> datas = {
      "email": email.text,
      "password": password.text,
    };
    bool isSuccess = await ApiConnect.loginAPI(datas);
    Navigator.pop(context);
    if (isSuccess) {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.success,
        title: 'Thành công',
        showCancelBtn: false,
        barrierDismissible: false,
        onConfirmBtnTap: () async {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        },
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Lỗi",
        text: 'Tài khoản hoặc mật khẩu không chính xác',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: screen.height*0.1, left: screen.width*0.05, right: screen.width*0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("crypto app",),),
                SizedBox(height: screen.height*0.05,),
                Text("Login", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                SizedBox(height: screen.height*0.025,),
                Text("Welcome back. Input your details to pickup where you left off." ,
                    style: TextStyle(fontSize: 16,)),
                SizedBox(height: screen.height*0.075,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black, fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                    ),

                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: password,
                        obscureText: hintPassword,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Colors.black, fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.black, width: 2),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(hintPassword ? Icons.visibility : Icons.visibility_off),
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                hintPassword = !hintPassword;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Hint here", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
                        InkWell(
                            onTap: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (BuildContext context) => ForgotPassword())
                              );
                            },
                            child: Text("Forgot Password?", style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold, fontSize: 12))),
                      ],
                    ),

                  ],
                ),
                SizedBox(height: screen.height*0.075,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        QuickAlert.show(
                          context: context,
                          type: QuickAlertType.loading,
                          title: 'Login',
                          text: 'Đang đăng nhập',
                        );
                        checkLogin();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Color(0xD7FFFFFF),
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        minimumSize: Size(screen.width * 0.6, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Logins', style: TextStyle(fontSize: 13, color: Colors.black)),
                    ),
                  ),
                ),
                SizedBox(height: screen.height*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Dont have an account?", style: TextStyle(fontSize: 12, color: Colors.deepPurpleAccent)),
                    Text(" Signup", style: TextStyle(fontSize: 12,fontWeight: FontWeight.bold, color: Colors.deepPurpleAccent)),
                  ],
                ),
              ],

            ),
          ),
        ),
      ),
    );
  }
}
