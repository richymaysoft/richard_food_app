import 'package:figma_practice/riverpod/favorite_provider.dart';
import 'package:figma_practice/screens/cart_screen.dart';
import 'package:figma_practice/screens/full_meal_list_screen.dart';

import 'package:figma_practice/screens/profile_screen.dart';
import 'package:figma_practice/widgets/food_screen_default.dart';

import 'package:figma_practice/widgets/menu_drawer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:figma_practice/models/meal.dart';

class FoodScreen extends ConsumerStatefulWidget {
  const FoodScreen({super.key});

  @override
  ConsumerState<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends ConsumerState<FoodScreen> {
  String currentTab = 'home';

  void selectTab(String tabKey) {
    setState(() {
      currentTab = tabKey;
    });
  }

  final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    List<Meal> favoriteMeal = ref.watch(favoriteMealProvider);
    Widget pageContent = const FoodScreenDefault();

    if (currentTab == 'home') {
      setState(() {
        pageContent = const FoodScreenDefault();
      });
    }

    if (currentTab == 'favorite') {
      setState(() {
        pageContent = FullMealList(
          mealList: favoriteMeal,
          category: currentTab == 'favorite' ? 'favorite' : null,
        );
      });
    }

    if (currentTab == 'profile') {
      setState(() {
        pageContent = ProfileScreen(
          currentTab: currentTab,
        );
      });
    }

    if (currentTab == 'reload') {
      setState(() {
        pageContent = const FoodScreenDefault();
      });
    }

    return Scaffold(
      key: _scaffoldState,
      appBar: currentTab == 'home'
          ? AppBar(
              leading: Container(
                padding: const EdgeInsets.only(top: 25),
                child: IconButton(
                    onPressed: () {
                      _scaffoldState.currentState!.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu_outlined,
                      size: 25,
                    )),
              ),
              leadingWidth: 140,
              iconTheme: const IconThemeData(
                color: Colors.black,
              ),
              backgroundColor: const Color(0xFFF2F2F2),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 30, right: 35),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => const CardScreen()));
                    },
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 36,
                    ),
                  ),
                )
              ],
            )
          : null,
      backgroundColor: const Color(0xFFF2F2F2),
      drawer: const MenuDrawer2(),
      body: pageContent,
      bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(
                onTap: () {
                  selectTab('home');
                },
                child: Icon(
                  Icons.home_outlined,
                  size: 30,
                  color: currentTab == 'home'
                      ? const Color(0x66D63700)
                      : Colors.black,
                  key: const ValueKey('home'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectTab('favorite');
                },
                child: Icon(
                  Icons.favorite_border_outlined,
                  size: 30,
                  color: currentTab == 'favorite'
                      ? const Color(0x66D63700)
                      : Colors.black,
                  //  key: ValueKey('favorite'),
                ),
              ),
              GestureDetector(
                onTap: () {
                  selectTab('profile');
                },
                child: Icon(
                  Icons.person_2_outlined,
                  size: 30,
                  color: currentTab == 'profile'
                      ? const Color(0x66D63700)
                      : Colors.black,
                  //  key: ValueKey('profile'),
                ),
              ),
              GestureDetector(
                  onTap: () {
                    selectTab('reload');
                  },
                  child: Icon(
                    Icons.restart_alt_outlined,
                    size: 30,
                    color: currentTab == 'reload'
                        ? const Color(0x66D63700)
                        : Colors.black,
                    //  key: ValueKey('reload'),
                  )),
            ],
          )),
    );
  }
}
