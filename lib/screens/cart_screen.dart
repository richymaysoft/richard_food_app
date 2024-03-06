import '/models/meal.dart';
import '/riverpod/cart_provider.dart';
import '/screens/checkout2_address_screen.dart';
import '/widgets/cart_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CardScreen extends ConsumerStatefulWidget {
  const CardScreen({super.key});

  @override
  ConsumerState<CardScreen> createState() => _CardScreenState();
}

class _CardScreenState extends ConsumerState<CardScreen> {
  int totalCartPrice = 0;
  void onTotalCart(int totalPrice) {
    setState(() {
      totalCartPrice = totalPrice;
    });
  }

  @override
  Widget build(BuildContext context) {
    var cartItemList = ref.read(cartProvider);
    int cartSumUp() {
      int sumUp = 0;
      for (Meal mealValue in cartItemList) {
        sumUp += mealValue.price * mealValue.frequency;
      }

      return sumUp;
    }

    totalCartPrice = cartSumUp();
    var screenHeight = MediaQuery.of(context).size.height;

    List<Meal> cartMeals = ref.watch(cartProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F8),
      appBar: AppBar(
        leadingWidth: 150,
        centerTitle: true,
        leading: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: const Icon(
              Icons.chevron_left,
              size: 35,
              color: Colors.black,
            )),
        title: const Text(
          'Cart',
          style: TextStyle(
            color: Colors.black,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xFFF5F5F8),
      ),
      body: ListView(children: [
        Container(
          padding: const EdgeInsets.only(
            top: 40,
          ),
          //  width: 414,
          //  height: screenHeight * 0.9,
          clipBehavior: Clip.antiAlias,
          decoration: ShapeDecoration(
            color: const Color(0xFFF5F5F8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.chevron_left_outlined),
                    Text(
                      'swipe on an item to delete',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w400,
                        height: 0,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                SizedBox(
                  height: screenHeight * 0.6,
                  child: cartMeals.isEmpty
                      ? const Center(
                          child: Text(
                            'No item in Cart',
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        )
                      : SingleChildScrollView(
                          child: Column(
                            children: [
                              for (Meal meal in cartMeals)
                                CartItem(
                                  meal: meal,
                                  onTotalCart: onTotalCart,
                                  onCartSumUp: cartSumUp,
                                )
                            ],
                          ),
                        ),
                ),
                if (cartMeals.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) =>
                              CheckoutAddress(totalPrice: totalCartPrice)));
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top: 45, bottom: 20),
                      width: 314,
                      height: 70,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFFA4A0C),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        'Complete order',
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
        ),
      ]),
    );
  }
}
