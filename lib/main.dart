import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:project_login/login.dart';
import 'package:project_login/services/api_client.dart';

GetIt locator = GetIt.instance;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  runApp(MyApp());
}

Future<void> setupLocator() async {
  locator.registerLazySingleton<RestClient>(
        () => RestClient(Dio()),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page?.round() ?? 0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(screen.height*0.1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("crypto app"),
              Expanded(
                child: PageView(
                  controller: _pageController,
                  children: [
                    buildPage(1),
                    buildPage(2),
                    buildPage(3),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildPageIndicator(0, _currentPage == 0),
                  buildPageIndicator(1, _currentPage == 1),
                  buildPageIndicator(2, _currentPage == 2),
                ],
              ),
              SizedBox(height: 100),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      side: BorderSide(color: Colors.black, width: 1),
                      minimumSize: Size(screen.width * 0.8, 0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Get started', style: TextStyle(fontSize: 18)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (BuildContext context) => LoginPage())
                            );
                      },
                      style: TextButton.styleFrom(
                        primary: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                        side: BorderSide(color: Colors.black, width: 1),
                        minimumSize: Size(screen.width * 0.8, 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text('Login', style: TextStyle(fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildPage(int pageNumber) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 150,
          height: 150,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/landing_image$pageNumber.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Chào mừng bạn đến với trang $pageNumber!',
            style: TextStyle(fontSize: 20, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Chào mừng bạn đến với trang $pageNumber!',
            style: TextStyle(fontSize: 12, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  Widget buildPageIndicator(int index, bool isCurrentPage) {
    double indicatorWidth = isCurrentPage ? 30.0 : 10.0;
    double indicatorHeight = 10.0;

    return Container(
      margin: EdgeInsets.all(4),
      width: indicatorWidth,
      height: indicatorHeight,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(indicatorHeight / 2),
        color: Colors.grey,
      ),
    );
  }
}