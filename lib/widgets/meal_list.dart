import 'package:figma_practice/models/meal.dart';
import 'package:figma_practice/screens/meal_details_screen%20.dart';
import 'package:flutter/material.dart';

class MealList extends StatelessWidget {
  const MealList({super.key, required this.meal});
  final Meal meal;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (ctx) => MealDetails(meal: meal)));
      },
      child: SizedBox(
        width: 258,
        height: 312,
        child: Stack(children: [
          Positioned(
            left: 0,
            top: 0,
            child: SizedBox(
              width: 220,
              height: 322,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 42,
                    child: Container(
                      width: 220,
                      height: 270,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
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
                    ),
                  ),
                  Positioned(
                    left: 48,
                    top: 196,
                    child: SizedBox(
                      width: 125,
                      height: 52,
                      child: Opacity(
                        opacity: 0.90,
                        child: Text(
                          meal.title,
                          softWrap: true,
                          maxLines: 2,
                          textHeightBehavior: const TextHeightBehavior(
                              applyHeightToFirstAscent: false),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontFamily: 'SF Pro Rounded',
                            fontWeight: FontWeight.w600,
                            //  height: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 24,
                    top: 273,
                    child: SizedBox(
                      width: 172,
                      height: 19,
                      child: Text(
                        'N${meal.price}',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Color(0xFFFA4A0C),
                          fontSize: 17,
                          fontFamily: 'SF Pro Rounded',
                          fontWeight: FontWeight.w700,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 26,
                    top: 0,
                    child: Container(
                      padding: EdgeInsets.all(10),
                      width: 168,
                      height: 168,
                      decoration: ShapeDecoration(
                        image: DecorationImage(
                          image: AssetImage(meal.imageUrl),
                          fit: BoxFit.fill,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(75),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
