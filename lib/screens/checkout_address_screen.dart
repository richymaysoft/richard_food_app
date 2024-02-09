import 'package:figma_practice/models/user.dart';
import 'package:figma_practice/riverpod/logged_in_user_provider.dart';

import 'package:figma_practice/screens/checkout_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutAddress extends ConsumerStatefulWidget {
  const CheckoutAddress({
    super.key,
    required this.totalPrice,
  });
  final int totalPrice;

  @override
  ConsumerState<CheckoutAddress> createState() => CheckoutAddressState();
}

class CheckoutAddressState extends ConsumerState<CheckoutAddress> {
  String deliveryMethod = 'door';
  void setDelivery(String method) {
    setState(() {
      deliveryMethod = method;
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final User userDetails = ref.read(loggedInUserProvider)[0];
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      appBar: AppBar(
        leadingWidth: 130,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: EdgeInsets.only(top: 27),
              child: const Icon(
                Icons.chevron_left,
                size: 30,
                color: Colors.black,
              ),
            )),
        title: Container(
          padding: const EdgeInsets.only(top: 30),
          child: const Text(
            'Checkout',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontFamily: 'SF Pro Text',
              fontWeight: FontWeight.w600,
              height: 0,
            ),
          ),
        ),
        backgroundColor: Color(0xFFF5F5F8),
      ),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                width: 414,
                height: screenHeight * 0.9,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: const Color(0xFFF5F5F8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    const Positioned(
                      left: 50,
                      top: 124 - 65,
                      child: Text(
                        'Delivery',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 34,
                          fontFamily: 'SF Pro Text',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 50,
                      top: 735 - 65,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (ctx) => CheckoutPaymentScreen(
                                  totalPrice: widget.totalPrice,
                                  deliveryMethod: deliveryMethod)));
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 314,
                          height: 70,
                          decoration: ShapeDecoration(
                            color: const Color(0xFFFA4A0C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'Proceed to payment',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFFF6F6F9),
                              fontSize: 17,
                              fontFamily: 'SF Pro Text',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 41,
                      top: 60 - 65,
                      child: Container(
                        width: 24,
                        height: 24,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(),
                        child: Stack(children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: const Icon(
                                Icons.chevron_left,
                                size: 35,
                              )),
                        ]),
                      ),
                    ),
                    Positioned(
                      left: 50,
                      top: 210 - 65,
                      child: SizedBox(
                        width: 315,
                        height: 196,
                        child: Stack(
                          children: [
                            const Positioned(
                              left: 3,
                              top: 0,
                              child: Text(
                                'Address details',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 254,
                              top: 0,
                              child: Text(
                                'change',
                                style: TextStyle(
                                  color: Color(0xFFF47A0A),
                                  fontSize: 15,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              top: 40,
                              child: Container(
                                width: 315,
                                height: 156,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x07000000),
                                      blurRadius: 40,
                                      offset: Offset(0, 10),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 30,
                              top: 65,
                              child: SizedBox(
                                width: 232,
                                height: 106,
                                child: Stack(
                                  children: [
                                    Positioned(
                                      left: 0,
                                      top: 0,
                                      child: Text(
                                        userDetails.name,
                                        style: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontFamily: 'SF Pro Text',
                                          fontWeight: FontWeight.w500,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 36,
                                      child: Text(
                                        userDetails.address == null
                                            ? 'No address yet. add an Addredd now'
                                            : userDetails.address!,
                                        style: TextStyle(
                                          color: userDetails.address == null
                                              ? Colors.red
                                              : Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'SF Pro Text',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 88,
                                      child: Text(
                                        userDetails.phone == null
                                            ? 'No Phone yet!'
                                            : userDetails.phone!,
                                        style: TextStyle(
                                          color: userDetails.address == null
                                              ? Colors.red
                                              : Colors.black,
                                          fontSize: 15,
                                          fontFamily: 'SF Pro Text',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 28,
                                      child: Opacity(
                                        opacity: 0.30,
                                        child: Container(
                                          width: 232,
                                          decoration: const ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 0.50,
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 80,
                                      child: Opacity(
                                        opacity: 0.30,
                                        child: Container(
                                          width: 232,
                                          decoration: const ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 0.50,
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 61,
                              top: 139,
                              child: Container(
                                width: 20,
                                height: 20,
                                clipBehavior: Clip.antiAlias,
                                decoration: const BoxDecoration(),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: 50,
                      top: 448 - 65,
                      child: SizedBox(
                        width: 318,
                        height: 289,
                        child: Stack(
                          children: [
                            const Positioned(
                              left: 6,
                              top: 0,
                              child: Text(
                                'Delivery method.',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                            const Positioned(
                              left: 0,
                              top: 246,
                              child: Text(
                                'Total',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 237,
                              top: 243,
                              child: Text(
                                'N ${widget.totalPrice}',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 22,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                            Positioned(
                              left: 3,
                              top: 40,
                              child: Container(
                                width: 315,
                                height: 156,
                                decoration: ShapeDecoration(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  shadows: const [
                                    BoxShadow(
                                      color: Color(0x07000000),
                                      blurRadius: 40,
                                      offset: Offset(0, 10),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 24,
                              top: 70,
                              child: SizedBox(
                                width: 262,
                                height: 45,
                                child: Stack(
                                  children: [
                                    const Positioned(
                                      left: 31,
                                      top: 0,
                                      child: Text(
                                        'Door delivery',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontFamily: 'SF Pro Text',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 30,
                                      top: 45,
                                      child: Opacity(
                                        opacity: 0.30,
                                        child: Container(
                                          width: 232,
                                          decoration: const ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 0.50,
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          setDelivery('door');
                                        },
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                          decoration: ShapeDecoration(
                                            shape: OvalBorder(
                                              side: BorderSide(
                                                  width: 1,
                                                  color: deliveryMethod ==
                                                          'door'
                                                      ? const Color(0xFFFA4A0C)
                                                      : Colors.black),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    deliveryMethod == 'door'
                                        ? Positioned(
                                            left: 4,
                                            top: 5,
                                            child: Container(
                                              width: 7,
                                              height: 7,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFFA4A0C),
                                                shape: OvalBorder(),
                                              ),
                                            ),
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 24,
                              top: 140,
                              child: SizedBox(
                                width: 90,
                                height: 20,
                                child: Stack(
                                  children: [
                                    const Positioned(
                                      left: 31,
                                      top: 0,
                                      child: Text(
                                        'Pick up',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 17,
                                          fontFamily: 'SF Pro Text',
                                          fontWeight: FontWeight.w400,
                                          height: 0,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 0,
                                      top: 1,
                                      child: GestureDetector(
                                        onTap: () {
                                          setDelivery('pick');
                                        },
                                        child: Container(
                                          width: 15,
                                          height: 15,
                                          decoration: ShapeDecoration(
                                            shape: OvalBorder(
                                              side: BorderSide(
                                                  width: 1,
                                                  color:
                                                      deliveryMethod == 'door'
                                                          ? Colors.black
                                                          : Colors.red),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    deliveryMethod == 'door'
                                        ? Container()
                                        : Positioned(
                                            left: 4,
                                            top: 5,
                                            child: Container(
                                              width: 7,
                                              height: 7,
                                              decoration: const ShapeDecoration(
                                                color: Color(0xFFFA4A0C),
                                                shape: OvalBorder(),
                                              ),
                                            ),
                                          ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
