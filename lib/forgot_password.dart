import 'package:flutter/material.dart';
import 'package:project_login/authy_verification.dart';
import 'package:quickalert/quickalert.dart';

import 'services/api_connect.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController email = TextEditingController();
  bool loadSubmit = false;

  Future<void> checkData() async {
    Map<String, dynamic> datas = {
      "email": email.text,
    };
    bool isSuccess = await ApiConnect.submitForgotPassword(datas);
    if (isSuccess) {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => AuthyVerification())
      );
    } else {
      setState(() {
        loadSubmit = false;
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Lỗi",
        text: 'Email không tồn tại',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery
        .of(context)
        .size;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(top: screen.height * 0.1,
                left: screen.width * 0.05,
                right: screen.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Text("crypto app",),),
                SizedBox(height: screen.height * 0.05,),
                Text("Forgot Password",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                SizedBox(height: screen.height * 0.025,),
                Text(
                    "Opps. It happens to the best of us. Input your email address to fix the issue.",
                    style: TextStyle(fontSize: 16,)),
                SizedBox(height: screen.height * 0.075,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: email,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.black,
                              fontSize: 12),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black, width: 2),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black, width: 2),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                                color: Colors.black, width: 2),
                          ),
                        ),
                      ),
                    ),



                  ],
                ),
                SizedBox(height: screen.height * 0.2,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        checkData();
                        setState(() {
                          loadSubmit = true;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        minimumSize: Size(screen.width * 0.6, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: loadSubmit == true ? LinearProgressIndicator() : Text(
                          'Submittt', style: TextStyle(fontSize: 13, color: Colors
                          .white)),
                    ),
                  ),
                ),

              ],

            ),
          ),
        ),
      ),
    );
  }
}
