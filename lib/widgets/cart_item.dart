import 'package:figma_practice/models/meal.dart';
import 'package:figma_practice/riverpod/cart_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem extends ConsumerStatefulWidget {
  const CartItem(
      {super.key,
      required this.meal,
      required this.onTotalCart,
      required this.onCartSumUp});
  final int Function() onCartSumUp;
  final Meal meal;
  final void Function(int total) onTotalCart;

  @override
  ConsumerState<CartItem> createState() => _CartItemState();
}

int cartItemCount = 1;

class _CartItemState extends ConsumerState<CartItem> {
  @override
  Widget build(BuildContext context) {
    List<Meal> cartItemList = ref.read(cartProvider);
    // var newCartList = cartItemList;

    int totalCartPrice;

    void increaseFrequency(Meal meal) {
      final indexOfMeal = cartItemList.indexOf(widget.meal);
      int newCartItemFreq = meal.frequency + 1;
      cartItemList.remove(meal);
      setState(() {
        cartItemList.insert(
            indexOfMeal,
            Meal(
                id: meal.id,
                title: meal.title,
                details: meal.details,
                categoryId: meal.categoryId,
                price: meal.price,
                imageUrl: meal.imageUrl,
                frequency: newCartItemFreq,
                imageUrl2: meal.imageUrl2,
                imageUrl3: meal.imageUrl3,
                imageUrl4: meal.imageUrl4));

        totalCartPrice = widget.onCartSumUp();
        widget.onTotalCart(totalCartPrice);
      });

      ref.read(cartProvider.notifier).updateCartList(cartItemList);
    }

    //the function that reduces the frequescy of cart item.

    void reduceFrequency(Meal meal) {
      final indexOfMeal = cartItemList.indexOf(widget.meal);
      if (meal.frequency < 2) {
        cartItemList.remove(meal);
        setState(() {
          totalCartPrice = widget.onCartSumUp();
          widget.onTotalCart(totalCartPrice);
        });
      } else {
        int newCartItemFreq = meal.frequency - 1;
        cartItemList.remove(meal);

        setState(() {
          cartItemList.insert(
              indexOfMeal,
              Meal(
                  id: meal.id,
                  title: meal.title,
                  details: meal.details,
                  categoryId: meal.categoryId,
                  price: meal.price,
                  imageUrl: meal.imageUrl,
                  frequency: newCartItemFreq,
                  imageUrl2: meal.imageUrl2,
                  imageUrl3: meal.imageUrl3,
                  imageUrl4: meal.imageUrl4));

          totalCartPrice = widget.onCartSumUp();
          widget.onTotalCart(totalCartPrice);
        });
      }

      ref.read(cartProvider.notifier).updateCartList(cartItemList);
    }

    void removeFromCart(Meal meal) {
      setState(() {
        cartItemList.remove(meal);
        ref.read(cartProvider.notifier).updateCartList(cartItemList);
        totalCartPrice = widget.onCartSumUp();
        widget.onTotalCart(totalCartPrice);
      });
    }

    return Dismissible(
      onDismissed: (xg) {
        removeFromCart(widget.meal);
      },
      direction: DismissDirection.endToStart,
      background: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: const ShapeDecoration(
              color: Color(0xFFDF2C2C),
              shape: OvalBorder(),
            ),
            child: const Center(
              child: Icon(
                Icons.favorite_border_outlined,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(
            width: 14,
          ),
          Container(
            width: 45,
            height: 45,
            decoration: const ShapeDecoration(
              color: Color(0xFFDF2C2C),
              shape: OvalBorder(),
            ),
            child: const Center(
              child: Icon(
                Icons.delete_forever_outlined,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      key: ValueKey(widget.meal.id),
      behavior: HitTestBehavior.deferToChild,
      child: Stack(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 20),
            padding: const EdgeInsets.only(left: 18, right: 18),
            width: 315,
            height: 102,
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
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(30),
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage(widget.meal.imageUrl),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.meal.title,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'SF Pro Rounded',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'N ${widget.meal.price.toString()}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Color(0xFFFA4A0C),
                        fontSize: 15,
                        fontFamily: 'SF Pro Rounded',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          Positioned(
            bottom: 35,
            right: 30,
            child: Container(
              width: 52,
              height: 20,
              decoration: ShapeDecoration(
                color: const Color(0xFFFA4A0C),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      reduceFrequency(widget.meal);
                    },
                    child: const Text(
                      '-',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFFF4F4F7),
                        fontSize: 15,
                        fontFamily: 'SF Pro Rounded',
                        fontWeight: FontWeight.w600,
                        height: 0,
                      ),
                    ),
                  ),
                  Text(
                    cartItemList
                        .firstWhere((element) => element.id == widget.meal.id)
                        .frequency
                        .toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontFamily: 'SF Pro Rounded',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                    height: 12,
                    child: GestureDetector(
                      onTap: () {
                        increaseFrequency(widget.meal);
                      },
                      child: const Text(
                        '+',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFFF4F4F7),
                          fontSize: 10,
                          fontFamily: 'SF Pro Rounded',
                          fontWeight: FontWeight.w600,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
