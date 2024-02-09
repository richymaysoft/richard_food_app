import 'package:flutter/material.dart';

class CheckoutPaymentScreen extends StatefulWidget {
  const CheckoutPaymentScreen({
    super.key,
    required this.deliveryMethod,
    required this.totalPrice,
  });
  final String deliveryMethod;
  final int totalPrice;

  @override
  State<CheckoutPaymentScreen> createState() => _CheckoutPaymentScreenState();
}

class _CheckoutPaymentScreenState extends State<CheckoutPaymentScreen> {
  String paymentMethod = 'card';

  void setPayment(String paymentOption) {
    setState(() {
      paymentMethod = paymentOption;
    });
  }

  Future<void> showPaymentDialog() {
    return showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Container(
              width: 315,
              height: 322,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 20, left: 25),
                    width: 315,
                    height: 66,
                    decoration: ShapeDecoration(
                      color: Color(0xFFECECEC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                    child: Text(
                      'Please note',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w500,
                        height: 0,
                      ),
                    ),
                  ),
                  Container(
                    height: 256,
                    padding: EdgeInsets.only(
                        left: 30, top: 20, bottom: 15, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Opacity(
                          opacity: 0.50,
                          child: Text(
                            'DELIVERY TO MAINLAND',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          ' N1000 - N2000',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Opacity(
                          opacity: 0.50,
                          child: Container(
                            width: 240,
                            decoration: ShapeDecoration(
                              shape: RoundedRectangleBorder(
                                side: BorderSide(
                                  width: 0.50,
                                  strokeAlign: BorderSide.strokeAlignCenter,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Opacity(
                          opacity: 0.50,
                          child: Text(
                            'DELIVERY TO Ikorodun',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                          ' N2000 - N3000',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Opacity(
                              opacity: 0.50,
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                width: 159,
                                alignment: Alignment.center,
                                height: 60,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFFA4A0C),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                ),
                                child: Text(
                                  'Proceed',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w600,
                                    height: 0,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
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
          padding: EdgeInsets.only(top: 30),
          child: const Text(
            'Checkout Payment',
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
      backgroundColor: Color(0xFFF5F5F8),
      body: ListView(
        children: [
          Column(
            children: [
              Container(
                padding:
                    EdgeInsets.only(top: 40, left: 45, right: 45, bottom: 30),
                width: 414,
                height: screenHeight * 0.9,
                clipBehavior: Clip.antiAlias,
                decoration: ShapeDecoration(
                  color: Color(0xFFF5F5F8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 34,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Payment method',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      width: 315,
                      height: 205,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x07000000),
                            blurRadius: 40,
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setPayment('card');
                                },
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: ShapeDecoration(
                                    shape: OvalBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFFFA4A0C)),
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 7,
                                      height: 7,
                                      decoration: ShapeDecoration(
                                        color: paymentMethod == 'card'
                                            ? Color(0xFFFA4A0C)
                                            : Colors.white,
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 40,
                                height: 40,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF47A0A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Icon(Icons.card_giftcard),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Card',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Opacity(
                            opacity: 0.30,
                            child: Container(
                              width: 232,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 0.50,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setPayment('bank');
                                },
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  decoration: ShapeDecoration(
                                    shape: OvalBorder(
                                      side: BorderSide(
                                          width: 1, color: Color(0xFFFA4A0C)),
                                    ),
                                  ),
                                  child: Center(
                                    child: Container(
                                      width: 7,
                                      height: 7,
                                      decoration: ShapeDecoration(
                                        color: paymentMethod == 'card'
                                            ? Colors.white
                                            : Color(0xFFFA4A0C),
                                        shape: OvalBorder(),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Container(
                                alignment: Alignment.center,
                                width: 40,
                                height: 40,
                                decoration: ShapeDecoration(
                                  color: Color(0xFFF47A0A),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Icon(Icons.home_mini_outlined),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Bank Transfer',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // payment method region

                    SizedBox(
                      height: 20,
                    ),

                    Text(
                      'Payment method',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 20, left: 20, right: 20),
                      width: 315,
                      height: 145,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x07000000),
                            blurRadius: 40,
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: ShapeDecoration(
                                  shape: OvalBorder(
                                    side: BorderSide(
                                        width: 1, color: Color(0xFFFA4A0C)),
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 7,
                                    height: 7,
                                    decoration: ShapeDecoration(
                                      color: widget.deliveryMethod == 'door'
                                          ? Color(0xFFFA4A0C)
                                          : Colors.white,
                                      shape: OvalBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Door Delivery',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Opacity(
                            opacity: 0.30,
                            child: Container(
                              width: 232,
                              decoration: ShapeDecoration(
                                shape: RoundedRectangleBorder(
                                  side: BorderSide(
                                    width: 0.50,
                                    strokeAlign: BorderSide.strokeAlignCenter,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                width: 15,
                                height: 15,
                                decoration: ShapeDecoration(
                                  shape: OvalBorder(
                                    side: BorderSide(
                                        width: 1, color: Color(0xFFFA4A0C)),
                                  ),
                                ),
                                child: Center(
                                  child: Container(
                                    width: 7,
                                    height: 7,
                                    decoration: ShapeDecoration(
                                      color: widget.deliveryMethod == 'door'
                                          ? Colors.white
                                          : Color(0xFFFA4A0C),
                                      shape: OvalBorder(),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              Text(
                                'Pick up',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    //end of Payment methos
                    //Total price begins.

                    SizedBox(
                      height: 55,
                    ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 17,
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        Text(
                          'N ${widget.totalPrice.toString()}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 35,
                    ),

                    GestureDetector(
                      onTap: () {
                        showPaymentDialog();
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 314,
                        height: 70,
                        decoration: ShapeDecoration(
                          color: Color(0xFFFA4A0C),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
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
