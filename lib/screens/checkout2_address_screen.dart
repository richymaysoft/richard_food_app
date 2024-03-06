import 'dart:convert';

import 'package:flutter/services.dart';

import '/models/user.dart';
import '/riverpod/logged_in_user_provider.dart';

import '/screens/checkout_payment_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

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
  bool isGettingLocation = false;
  double? lat;
  double? lon;
  String? address;
  var addressController = TextEditingController();
  var phoneController = TextEditingController();

  String? enteredAddress;
  String? enteredPhone;

  void setDelivery(String method) {
    setState(() {
      deliveryMethod = method;
    });
  }

  void getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    if (locationData.latitude != null) {
      setState(() {
        isGettingLocation = true;
        lat = locationData.latitude;
        lon = locationData.longitude;
      });
    }

    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=AIzaSyD1MqGVaTHpVo3lOD7VSwDwN4PulFUVR2I');
    final response = await http.get(url);
    // print(jsonDecode(response.body));
    var addressResult = json.decode(response.body);
    var specifcAddress = addressResult['results'][0]['formatted_address'];
    //  print(json.decode(response.body['results'][0]["formatted_address"]));
    setState(() {
      address = specifcAddress;
      isGettingLocation = false;
    });
  }

  void showForm() {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return Container(
            padding: EdgeInsets.only(
                left: 30,
                right: 30,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            height: 600,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Update Your details',
                    style: TextStyle(color: Colors.black, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: addressController,
                    maxLength: 60,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_city_outlined),
                        labelText: 'Address (Optional)',
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    style: const TextStyle(color: Colors.black),
                    controller: phoneController,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.location_city_outlined),
                        labelText: 'Phone (Optional)',
                        labelStyle: TextStyle(color: Colors.black)),
                    maxLength: 13,
                    maxLengthEnforcement: MaxLengthEnforcement.enforced,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      ref
                          .read(loggedInUserProvider.notifier)
                          .updateLoggedInUser(
                              addressController.text, phoneController.text);
                      Navigator.pop(context);
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
                        'Update',
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
            ));
      },
    );
  }

  @override
  void initState() {
    getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final User userDetails = ref.watch(loggedInUserProvider)[0];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      appBar: AppBar(
        leadingWidth: 100,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              padding: const EdgeInsets.only(top: 27),
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
        backgroundColor: const Color(0xFFF5F5F8),
      ),
      body: ListView(
        children: [
          Container(
            padding:
                const EdgeInsets.only(top: 40, left: 45, right: 45, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Delivery',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 34,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Address details',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    GestureDetector(
                      onTap: showForm,
                      child: const Text(
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
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 35),
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  width: 315,
                  height: 169,
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        // alignment: Alin,
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
                      Opacity(
                        opacity: 0.30,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          width: 232,
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.50,
                                strokeAlign: BorderSide.strokeAlignCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      isGettingLocation
                          ? Container(
                              alignment: Alignment.centerLeft,
                              height: 40,
                              width: 235,
                              child: const Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    'Fetching address...',
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(),
                                  ),
                                ],
                              ))
                          : Container(
                              alignment: Alignment.centerLeft,
                              height: 40,
                              width: 235,
                              child: Text(
                                ((userDetails.address == null &&
                                            address == null) ||
                                        (userDetails.address == '' &&
                                            address == null))
                                    ? 'No address yet. add an Addredd now'
                                    : (userDetails.address == null ||
                                            userDetails.address!.isEmpty)
                                        ? address!
                                        : userDetails.address!,
                                maxLines: 2,
                                style: TextStyle(
                                  color: ((address == null &&
                                              userDetails.address == null) ||
                                          (address == null &&
                                              userDetails.address == ''))
                                      ? Colors.red
                                      : Colors.black,
                                  fontSize: 15,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,

                                  // height: 0,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                      Opacity(
                        opacity: 0.30,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          width: 232,
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.50,
                                strokeAlign: BorderSide.strokeAlignCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        height: 15,
                        width: 235,
                        child: Text(
                          (userDetails.phone == null || userDetails.phone == '')
                              ? 'No Phone yet!'
                              : userDetails.phone!,
                          style: TextStyle(
                            color: (userDetails.address == null ||
                                    userDetails.phone == '')
                                ? Colors.red
                                : Colors.black,
                            fontSize: 15,
                            fontFamily: 'SF Pro Text',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),
                const Text(
                  'Delivery method.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'SF Pro Text',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.only(
                      left: 25, right: 25, bottom: 30, top: 30),
                  margin: const EdgeInsets.only(top: 20, bottom: 35),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                          onTap: () {
                            setDelivery('door');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                  right: 20,
                                ),
                                width: 15,
                                height: 15,
                                decoration: ShapeDecoration(
                                  shape: OvalBorder(
                                    side: BorderSide(
                                        width: 1,
                                        color: deliveryMethod == 'door'
                                            ? const Color(0xFFFA4A0C)
                                            : Colors.black),
                                  ),
                                ),
                                child: deliveryMethod == 'door'
                                    ? Center(
                                        child: Container(
                                          width: 7,
                                          height: 7,
                                          decoration: const ShapeDecoration(
                                            color: Color(0xFFFA4A0C),
                                            shape: OvalBorder(),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                              const Text(
                                'Door delivery',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          )),
                      Opacity(
                        opacity: 0.30,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 15),
                          width: 232,
                          decoration: const ShapeDecoration(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                width: 0.50,
                                strokeAlign: BorderSide.strokeAlignCenter,
                              ),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                          onTap: () {
                            setDelivery('pick');
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: const EdgeInsets.only(right: 20),
                                width: 15,
                                height: 15,
                                decoration: ShapeDecoration(
                                  shape: OvalBorder(
                                    side: BorderSide(
                                        width: 1,
                                        color: deliveryMethod == 'pick'
                                            ? const Color(0xFFFA4A0C)
                                            : Colors.black),
                                  ),
                                ),
                                child: deliveryMethod == 'pick'
                                    ? Center(
                                        child: Container(
                                          width: 7,
                                          height: 7,
                                          decoration: const ShapeDecoration(
                                            color: Color(0xFFFA4A0C),
                                            shape: OvalBorder(),
                                          ),
                                        ),
                                      )
                                    : Container(),
                              ),
                              const Text(
                                'Pick UP',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontFamily: 'SF Pro Text',
                                  fontWeight: FontWeight.w400,
                                  height: 0,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
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
                      'N ${widget.totalPrice}',
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 22,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (ctx) => CheckoutPaymentScreen(
                            totalPrice: widget.totalPrice,
                            deliveryMethod: deliveryMethod)));
                  },
                  child: Container(
                    margin: const EdgeInsets.only(top: 25, bottom: 10),
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
