import 'package:figma_practice/models/meal.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:figma_practice/riverpod/favorite_provider.dart';

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'package:figma_practice/riverpod/cart_provider.dart';
import 'package:intl/intl.dart';

class MealDetails extends ConsumerStatefulWidget {
  const MealDetails({super.key, required this.meal});
  final Meal meal;

  @override
  ConsumerState<MealDetails> createState() {
    return _MealDetailsState();
  }
}

class _MealDetailsState extends ConsumerState<MealDetails> {
  final controller = PageController();

  final List<String?> imageList = [];
  final List<String> imgList = [];
  void countMealImages(String mealId2) {
    imageList.add(widget.meal.imageUrl2);
    imageList.add(widget.meal.imageUrl);

    imageList.add(widget.meal.imageUrl3);
    imageList.add(widget.meal.imageUrl4);

    for (String? img in imageList) {
      if (img != null) {
        imgList.add(img);
      }
    }
  }

  @override
  void initState() {
    super.initState();
    countMealImages(widget.meal.id);
  }

  @override
  Widget build(BuildContext context) {
    final toggleFavorute = ref.read(favoriteMealProvider.notifier);
    var checkFav = ref.watch(favoriteMealProvider);
    var fetchMeal = checkFav.firstWhere(
        (checkMeal) => checkMeal.id == widget.meal.id,
        orElse: () => Meal(
            categoryId: 'rfs',
            id: 'sdgdddd',
            imageUrl: 'susf',
            price: 554,
            frequency: 1,
            title: 'sfsf',
            details: 'sff'));
    var mealIsFavorite = fetchMeal.id == widget.meal.id;
    //bool checkCart;

    Meal currentMeal = ref.watch(cartProvider).firstWhere(
        (cartMeal) => cartMeal.id == widget.meal.id,
        orElse: () => Meal(
            id: 'id',
            title: 'title',
            details: 'details',
            categoryId: 'categoryId',
            price: 3,
            imageUrl: 'imageUrl',
            frequency: 3));

    bool checkCart = ref.watch(cartProvider).contains(currentMeal);

    final addCart = ref.read(cartProvider.notifier);

    var screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(left: 35, right: 35, top: 50, bottom: 45),
        width: 414,
        height: screenHeight * 0.98,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFF6F6F9),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: const Icon(
                    Icons.chevron_left,
                    color: Colors.black,
                    size: 35,
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      toggleFavorute.addFavorite(widget.meal);
                      //  print(checkFav);
                    },
                    child: Icon(
                      mealIsFavorite
                          ? Icons.favorite_sharp
                          : Icons.favorite_border_outlined,
                      color: Colors.black,
                    )),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
//start image slider region
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 40),
              width: 405.73,
              height: 269.09,
              child: Column(
                children: [
                  Expanded(
                    child: PageView(
                      controller: controller,
                      children: [
                        for (String image2 in imgList)
                          Image(image: AssetImage(image2), fit: BoxFit.fill),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SmoothPageIndicator(
                        onDotClicked: (index) => controller.animateToPage(
                          index,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeIn,
                        ),
                        controller: controller,
                        count: imgList.length,
                        effect: SlideEffect(
                            dotColor: Colors.grey.withOpacity(0.5),
                            activeDotColor: Colors.red,
                            dotHeight: 7.5,
                            dotWidth: 7.5),
                      )
                    ],
                  )
                ],
              ),
            ),

            SizedBox(
              height: 50,
              child: Text(
                widget.meal.title,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontFamily: 'SF Pro Rounded',
                  fontWeight: FontWeight.w600,
                  height: 1.0,
                ),
              ),
            ),
            SizedBox(
              width: 172,
              height: 19,
              child: Text(
                NumberFormat.compact(locale: Intl.defaultLocale)
                    .format(widget.meal.price),
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Color(0xFFFA4A0C),
                  fontSize: 22,
                  fontFamily: 'SF Pro Rounded',
                  fontWeight: FontWeight.w700,
                  height: 0.7,
                ),
              ),
            ),
            const SizedBox(
              height: 45,
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Delivery info',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'SF Pro Rounded',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 297,
                  height: 77,
                  child: Opacity(
                    opacity: 0.50,
                    child: Text(
                      'Delivered between monday aug and thursday 20 from 8pm to 91:32 pm',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                        letterSpacing: 0.30,
                      ),
                    ),
                  ),
                ),

                // Second meal details

                Text(
                  'Delivery info',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 17,
                    fontFamily: 'SF Pro Rounded',
                    fontWeight: FontWeight.w600,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 297,
                  height: 77,
                  child: Opacity(
                    opacity: 0.50,
                    child: Text(
                      'Delivered between monday aug and thursday 20 from 8pm to 91:32 pm',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontFamily: 'SF Pro Text',
                        fontWeight: FontWeight.w400,
                        height: 1.2,
                        letterSpacing: 0.30,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                checkCart
                    ? ref
                        .read(cartProvider.notifier)
                        .removeFromCart(widget.meal)
                    : addCart.addToCart(widget.meal);
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
                child: Text(
                  checkCart ? 'Remove from cart' : 'Add to cart',
                  style: const TextStyle(
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
    );
  }
}
