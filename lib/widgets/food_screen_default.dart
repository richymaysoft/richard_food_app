import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '/riverpod/meals_provider.dart';
import '/riverpod/category_provider.dart';
import '/screens/full_meal_list_screen.dart';
import '/models/meal.dart';
import '/data/dummy_data.dart';

import '/widgets/meal_list.dart';

class FoodScreenDefault extends ConsumerStatefulWidget {
  const FoodScreenDefault({super.key});

  @override
  ConsumerState<FoodScreenDefault> createState() => _FoodScreenDefaultState();
}

String currentCat = 'cat0';
List<Meal> categoryMealList = meals;
final _focusNode = FocusNode();
var controller = TextEditingController();

class _FoodScreenDefaultState extends ConsumerState<FoodScreenDefault> {
  void searchFood(query) {
    if (currentCat == 'cat0') {
      var filterMeal = meals.where((food) {
        var mealLowerCase = food.title.toLowerCase();
        var input = query.toLowerCase();
        var filteredMeal = mealLowerCase.contains(input);
        return filteredMeal;
      }).toList();
      setState(() {
        categoryMealList = filterMeal;
      });
    } else {
      List<Meal> catMealList =
          meals.where((meal) => meal.categoryId == currentCat).toList();
      var filterMeal = catMealList.where((food) {
        var mealLowerCase = food.title.toLowerCase();
        var input = query.toLowerCase();
        var filteredMeal = mealLowerCase.contains(input);
        return filteredMeal;
      }).toList();
      setState(() {
        categoryMealList = filterMeal;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var meals = ref.read(mealsProvider);
    var categories = ref.read(categoryProvider);

    void focusCategory(String cId) {
      if (cId == 'cat0') {
        setState(() {
          currentCat = cId;

          categoryMealList = meals;
          searchFood(controller.text);
        });
      } else {
        var newCatMeals =
            meals.where((catId) => catId.categoryId == cId).toList();
        setState(() {
          currentCat = cId;

          categoryMealList = newCatMeals;
          searchFood(controller.text);
        });
      }
    }

    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 70,
            ),

            const Text(
              'Delicious \nfood for you',
              style: TextStyle(
                color: Colors.black,
                fontSize: 34,
                fontFamily: 'SF Pro Rounded',
                fontWeight: FontWeight.w700,
                height: 0,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              width: 314,
              height: 60,
              decoration: ShapeDecoration(
                color: const Color(0xFFEFEEEE),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      style: const TextStyle(color: Colors.black),
                      focusNode: _focusNode,
                      decoration: const InputDecoration(
                          prefixIcon: Icon(
                            Icons.search_outlined,
                            color: Colors.black,
                          ),
                          label: Text('Seaarch'),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelStyle: TextStyle(color: Colors.black),
                          border: InputBorder.none),

                      onChanged: searchFood,
                      // onTapOutside: (event) => searchFood,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // first category column... This

                  ...categories.map((cat) {
                    return InkWell(
                      onTap: () {
                        focusCategory(cat.id);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(
                            top: 30, left: 5, right: 5, bottom: 35),
                        child: Column(
                          children: [
                            Text(
                              cat.name,
                              style: TextStyle(
                                color: cat.id == currentCat
                                    ? const Color(0xFFFA4A0C)
                                    : Colors.black,
                                fontSize: 17,
                                fontFamily: 'SF Pro Text',
                                fontWeight: FontWeight.w400,
                                height: 0,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: 87,
                              height: 3,
                              decoration: ShapeDecoration(
                                color: cat.id == currentCat
                                    ? const Color(0xFFFA4A0C)
                                    : Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                                shadows: const [
                                  BoxShadow(
                                    color: Color(0x19C33F15),
                                    blurRadius: 4,
                                    offset: Offset(0, 4),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),

                  // second category column...
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (ctx) => FullMealList(
                                  mealList: categoryMealList,
                                )));
                    // Send all the list if Category '));
                  },
                  child: const Text(
                    'see more',
                    style: TextStyle(
                      color: Color(0xFFFA4A0C),
                      fontSize: 15,
                      fontFamily: 'SF Pro Rounded',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            //horizontal list of meals

            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                ...categoryMealList.map((catMeal) {
                  return MealList(meal: catMeal);
                })
              ]),
            ),
          ]),
        ),
      ),
    );
  }
}
