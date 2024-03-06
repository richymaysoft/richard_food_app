import '/data/dummy_data.dart';
import '/models/meal.dart';
import '/riverpod/favorite_provider.dart';
import 'meal_details_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/models/category.dart';

class FullMealList extends ConsumerStatefulWidget {
  const FullMealList({super.key, required this.mealList, this.category});
  final List<Meal> mealList;
  final String? category;
  @override
  ConsumerState<FullMealList> createState() => _FullMealListState();
}

class _FullMealListState extends ConsumerState<FullMealList> {
  List<AssetImage> imageList = [];
  var getCategory = '';
  String? categoryName;
  bool favoriteAndNotEmpty = false;
  bool favoriteAndEmpty = false;

  @override
  void initState() {
    super.initState();
    for (Meal meal in widget.mealList) {
      imageList.add(AssetImage(meal.imageUrl));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (widget.category != null) {
      var getCategoryName = categories.firstWhere(
        (element) => element.id == widget.category,
        orElse: () =>
            const CategoryModel(id: 'favorite', name: 'Favorite Meals'),
      );

      getCategory = getCategoryName.name;
    }
    //var favoriteProvider = ref.watch(favoriteMealProvider);
    List<Meal> favoriteList = [];
    var mealCount = widget.mealList.length;
    bool pageIsFavorite = false;
    if (widget.category == 'favorite') {
      favoriteList = ref.watch(favoriteMealProvider);
      if (favoriteList.isNotEmpty) {
        mealCount = favoriteList.length;
      } else {
        mealCount = 0;
      }

      pageIsFavorite = true;
    }

    if (widget.category == 'favorite' && favoriteList.isNotEmpty) {
      favoriteAndNotEmpty = true;
    }

    if (widget.category == 'favorite' && favoriteList.isEmpty) {
      favoriteAndEmpty = true;
    }

    var screenHeight = MediaQuery.of(context).size.height;
    //var bottomNavBar = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFEEEEEE),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(
                top: 50,
                left: 45,
                bottom: 30,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  if (!pageIsFavorite)
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const SizedBox(
                        width: 30,
                        height: 30,
                        child: Icon(
                          Icons.chevron_left,
                          color: Colors.black,
                          size: 28,
                        ),
                      ),
                    ),
                  const SizedBox(
                    width: 35,
                  ),
                  Text(
                    widget.category == null ? 'Meals' : getCategory,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                      fontFamily: 'SF Pro Rounded',
                      fontWeight: FontWeight.w600,
                      height: 0,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 1, bottom: 50),
              // width: 414,
              // height: screenHeight * 0.85,
              decoration: ShapeDecoration(
                color: const Color(0xFFF9F9F9),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    'Found  $mealCount resuls',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontFamily: 'SF Pro Rounded',
                      fontWeight: FontWeight.w700,
                      height: 0,
                    ),
                  ),
                  Container(
                    height: screenHeight * 0.75,
                    padding: const EdgeInsets.only(
                        top: 15, right: 15, left: 15, bottom: 60),
                    child: (widget.mealList.isEmpty || favoriteAndEmpty)
                        ? const Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.search),
                                Text(
                                  'ohh snap! No Meal yet',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontFamily: 'Poppins',
                                    fontWeight: FontWeight.w500,
                                    height: 0,
                                    letterSpacing: -0.56,
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Opacity(
                                    opacity: 0.57,
                                    child: Text(
                                      'No meal found.',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 17,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    )),
                              ],
                            ),
                          )
                        : GridView.builder(
                            itemCount: mealCount,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    //  crossAxisSpacing: 10.0,
                                    childAspectRatio: 2 / 3),
                            itemBuilder: (ctx, item) {
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (ctx) => favoriteAndNotEmpty
                                          ? MealDetails(
                                              meal: favoriteList[item])
                                          : MealDetails(meal: meals[item])));
                                },
                                child: Container(
                                  //  alignment: Alignment(0, 1),
                                  padding: EdgeInsets.only(right: 1, left: 1),
                                  margin: const EdgeInsets.only(
                                      // bottom: 10,
                                      //  left: 10,
                                      // right: 10,
                                      ),
                                  //  height: 183.41,
                                  // width: 160,
                                  // color: Colors.grey.withOpacity(0.4),
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 30,
                                        left: 5,
                                        right: 5,
                                        child: Container(
                                          // alignment: Alignment.bottomCenter,
                                          padding: EdgeInsets.only(
                                              top: 115,
                                              left: 10,
                                              right: 10,
                                              bottom: 16),

                                          // height: 200.41,
                                          // width: 160,
                                          decoration: ShapeDecoration(
                                            color: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            shadows: const [
                                              BoxShadow(
                                                color: Color(0x19393939),
                                                blurRadius: 60,
                                                offset: Offset(0, 30),
                                                spreadRadius: 0,
                                              )
                                            ],
                                          ),
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Container(
                                                alignment: Alignment.center,
                                                width: 160,
                                                height: 45,
                                                margin:
                                                    EdgeInsets.only(bottom: 5),
                                                child: Text(
                                                  widget.mealList[item].title,
                                                  softWrap: true,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                    fontFamily:
                                                        'SF Pro Rounded',
                                                    fontWeight: FontWeight.w600,
                                                    height: 0.95,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 135.13,
                                                height: 14.93,
                                                child: Text(
                                                  widget.mealList[item].price
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: const TextStyle(
                                                    color: Color(0xFFFA4A0C),
                                                    fontSize: 17,
                                                    fontFamily:
                                                        'SF Pro Rounded',
                                                    fontWeight: FontWeight.w700,
                                                    height: 0.5,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 20,
                                        left: 20,
                                        child: Container(
                                          width: 216.95,
                                          height: 143.89,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                              image: imageList[item],
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                  )
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
