import 'package:flutter/material.dart';
import 'package:project_login/set_new_password.dart';
import 'package:quickalert/quickalert.dart';

import 'services/api_connect.dart';

class AuthyVerification extends StatefulWidget {
  const AuthyVerification({super.key});

  @override
  State<AuthyVerification> createState() => _AuthyVerificationState();
}

class _AuthyVerificationState extends State<AuthyVerification> {
  List<TextEditingController> controllers =
      List.generate(5, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(5, (index) => FocusNode());
  @override
  void initState() {
    super.initState();

    for (int i = 0; i < 4; i++) {
      controllers[i].addListener(() {
        if (controllers[i].text.length == 1) {
          focusNodes[i + 1].requestFocus();
        }
      });
    }
  }

  bool loadSubmit = false;

  Future<void> checkData() async {
    List<String> dataValues = controllers.map((controller) => controller.text).toList();
    String concatenatedData = dataValues.join();
    int finalValue = int.parse(concatenatedData);
    print(finalValue);

    String id = await ApiConnect.submitVerification(finalValue);
    if (id != "") {
      Navigator.push(context,
          MaterialPageRoute(builder: (BuildContext context) => SetNewPassword(id: id))
      );
    } else {
      setState(() {
        loadSubmit = false;
      });
      QuickAlert.show(
        context: context,
        type: QuickAlertType.error,
        title: "Lỗi",
        text: 'Mã code bị sai',
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
            padding: EdgeInsets.only(
                top: screen.height * 0.1,
                left: screen.width * 0.05,
                right: screen.width * 0.05),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    "crypto app",
                  ),
                ),
                SizedBox(
                  height: screen.height * 0.05,
                ),
                Text(
                  "Authy Verification",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: screen.height * 0.025,
                ),
                Text(
                    "Copy the verification code in your authy application to verify this account recovery",
                    style: TextStyle(
                      fontSize: 16,
                    )),
                SizedBox(
                  height: screen.height * 0.075,
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: TextField(
                            textAlign: TextAlign.center,
                            controller: controllers[index],
                            focusNode: focusNodes[index],
                            maxLength: 1,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              counterText: "",
                              labelStyle:
                                  TextStyle(color: Colors.black, fontSize: 12),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide:
                                    BorderSide(color: Colors.black, width: 2),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: screen.height * 0.2,
                ),
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
                        primary: Colors.black,
                        padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        minimumSize: Size(screen.width * 0.6, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: loadSubmit == true ? LinearProgressIndicator() :  Text('Submit verification',
                          style: TextStyle(fontSize: 13, color: Colors.white)),
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
