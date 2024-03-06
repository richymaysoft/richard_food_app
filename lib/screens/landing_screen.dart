import '/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color.fromARGB(255, 18, 32, 47),
      ),
      home: Scaffold(
        body: ListView(children: const [
          Iphone11ProMax1(),
        ]),
      ),
    );
  }
}

class Iphone11ProMax1 extends StatelessWidget {
  const Iphone11ProMax1({super.key});
  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(bottom: 20),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFFF4B3A),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              margin: const EdgeInsets.only(top: 30, left: 40),
              width: 73,
              height: 73,
              decoration: const ShapeDecoration(
                color: Colors.white,
                shape: OvalBorder(),
              ),
              child: Container(
                width: 40.22,
                height: 49.65,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/bellaolonjelogo1111.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 25, left: 40),
              child: const Text(
                'Food for \nEveryone',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 65,
                  fontFamily: 'sf-pro',
                  fontWeight: FontWeight.w800,
                  height: 0.8,
                  letterSpacing: -1.95,
                ),
              ),
            ),
            SizedBox(
              height: screenHeight * 0.5,
              child: Stack(
                children: [
                  const Positioned(
                      right: 0,
                      top: 110,
                      child: Image(
                          image: AssetImage(
                              'assets/ToyFaces_Tansparent_BG_29.png'))),
                  const Positioned(
                      left: 0,
                      top: 40,
                      child: Image(
                          image: AssetImage(
                              'assets/ToyFaces_Tansparent_BG_49.png'))),
                  Positioned(
                      bottom: 0,
                      child: Container(
                        width: screenWidth,
                        height: 100,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: [
                                const Color(0xFFFF4B3A).withOpacity(0.1),
                                const Color(0xFFFF4B3A).withOpacity(1)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                        ),
                      ))
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
              child: Container(
                margin: EdgeInsets.only(
                    left: screenWidth * 0.15,
                    right: screenWidth * 0.15,
                    top: 40,
                    bottom: 20),
                alignment: const Alignment(0, 0),
                width: screenWidth * 0.69,
                height: 70,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'Get started',
                  style: TextStyle(
                    color: Color(0xFFFF460A),
                    fontSize: 17,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
