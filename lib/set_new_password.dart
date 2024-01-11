import 'package:flutter/material.dart';
import 'package:project_login/home.dart';
import 'package:project_login/login.dart';
import 'package:project_login/services/api_connect.dart';
import 'package:quickalert/quickalert.dart';

class SetNewPassword extends StatefulWidget {
  final String? id;
  const SetNewPassword({super.key, this.id});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  TextEditingController password = TextEditingController();
  TextEditingController config = TextEditingController();

  bool hintPassword = true;
  bool hintConfig = true;
  Future<void> checkData(context,screen) async {
    Map<String, dynamic> datas = {
      "passwordNew": password.text,
      "passwordConfig": config.text,
    };
    bool isSuccess = await ApiConnect.submitPassword(datas,widget.id.toString());
    if (isSuccess) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        builder: (context) => PasswordChangeSuccessBottomSheet(context, screen),
      );
    } else {
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Lỗi",
        text: 'Bạn nhập không đúng yêu cầu hoặc mật khẩu nhập không thành công',
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
                Text("Set new password",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                SizedBox(height: screen.height * 0.025,),
                Text(
                    "Enter your new password below and check the hint while setting it.",
                    style: TextStyle(fontSize: 16,)),
                SizedBox(height: screen.height * 0.075,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: password,
                        obscureText: hintPassword,
                        decoration: InputDecoration(
                          labelText: 'Set new password',
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

                            },
                            child: Text("Forgot Password?", style: TextStyle(color: Colors.red,fontWeight: FontWeight.bold, fontSize: 12))),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: TextField(
                        controller: config,
                        obscureText: hintConfig,

                        decoration: InputDecoration(
                          labelText: 'Confirm password',
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
                            icon: Icon(hintConfig ? Icons.visibility : Icons.visibility_off),
                            color: Colors.black,
                            onPressed: () {
                              setState(() {
                                hintConfig = !hintConfig;
                              });
                            },
                          ),

                        ),
                      ),
                    ),


                  ],
                ),
                SizedBox(height: screen.height * 0.1,),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: ElevatedButton(
                      onPressed: () {
                        if(password.text == ""){
                          QuickAlert.show(
                            context: context,
                            type: QuickAlertType.error,
                            title: "Lỗi",
                            text: 'Không được để trống',
                          );
                        } else {
                          checkData(context,screen);
                        }


                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.symmetric(
                            vertical: 20, horizontal: 40),
                        minimumSize: Size(screen.width * 0.6, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                          'Submit password', style: TextStyle(fontSize: 13, color: Colors
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
  Widget PasswordChangeSuccessBottomSheet(context,screen){
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.green,
            size: 64,
          ),
          SizedBox(height: 16),
          Text(
            'Password Recovery Successfully',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8),
          Text(
            'Your password has been updated successfully.',
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 16),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ElevatedButton(
                onPressed: () async {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  await Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => HomePage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                  padding: EdgeInsets.symmetric(
                      vertical: 20, horizontal: 40),
                  minimumSize: Size(screen.width * 0.6, 0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Text(
                    'Return', style: TextStyle(fontSize: 13, color: Colors
                    .white)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
