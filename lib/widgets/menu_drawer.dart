import 'package:figma_practice/riverpod/logged_in_user_provider.dart';

import 'package:figma_practice/screens/offer_screen.dart';
import 'package:figma_practice/screens/profile_screen.dart';
import 'package:figma_practice/screens/sign_up_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MenuDrawer2 extends ConsumerWidget {
  const MenuDrawer2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.only(left: 30, top: 150, bottom: 35),
      width: screenWidth * 0.9,
      height: screenHeight * 0.98,
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFFFA4A0C),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.person_2_rounded,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => ProfileScreen()));
                    },
                    child: const Text(
                      'Profile',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 30, bottom: 20),
                width: 130,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.30,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFF4F4F8),
                    ),
                  ),
                ),
              ),

              // second menu

              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.card_travel_outlined,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Orders',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 30, bottom: 20),
                width: 130,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.30,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFF4F4F8),
                    ),
                  ),
                ),
              ),

              //third menu

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(
                    Icons.pin_drop_outlined,
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (ctx) => OfferScreen()));
                    },
                    child: const Text(
                      'Offers and Pormo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 30, bottom: 20),
                width: 130,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.30,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFF4F4F8),
                    ),
                  ),
                ),
              ),

              //forth menu
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Icon(
                    Icons.security_rounded,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Privacy Policy',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 30, bottom: 20),
                width: 130,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      width: 0.30,
                      strokeAlign: BorderSide.strokeAlignCenter,
                      color: Color(0xFFF4F4F8),
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 340,
              ),

              GestureDetector(
                onTap: () {
                  ref
                      .read(loggedInUserProvider.notifier)
                      .logUserOut(ref.read(loggedInUserProvider)[0]);

                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (ctx) => SignUp()));
                },
                child: const Text(
                  'Sign-out',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 140,
            height: 560,
            child: Image(
              image: AssetImage('assets/image10.png'),
              fit: BoxFit.fill,
            ),
          )
        ],
      ),
    );
  }
}
