import 'package:flutter/material.dart';
import 'package:meals/screens/meals_details.dart';
import 'package:meals/widgets/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

import '../models/meal.dart';

class MealItem extends StatelessWidget {
  MealItem({super.key, required this.meal,required this.onSelectMeal});

  final Meal meal;


  void Function(Meal meal) onSelectMeal;


  String get affordabilityText {
    return meal.affordability.name.toUpperCase()[0] +
        meal.affordability.name.substring(1);
  }

  String get complexityText {
    return meal.complexity.name.toUpperCase()[0] +
        meal.complexity.name.substring(1);
  }



  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        splashColor: Theme
            .of(context)
            .cardTheme
            .shadowColor,
        onTap: () {
          onSelectMeal(meal);
        },
        child: Stack(
          children: [
            FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(meal.imageUrl),
              fit: BoxFit.cover,
              height: 200,
              width: double.infinity,
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 5,
              child: Container(
                  color: Colors.black54,
                  child: Column(
                    children: [
                      Text(meal.title,
                          textAlign: TextAlign.center,
                          softWrap: true,
                          maxLines: 2,
                          style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.white)),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          MealItemTrait(
                              icon: Icons.timelapse,
                              label: '${meal.duration.toString()} min'),
                          const SizedBox(width: 12),
                          MealItemTrait(
                              icon: Icons.monetization_on,
                              label: affordabilityText),
                          const SizedBox(width: 12),
                          MealItemTrait(icon: Icons.work, label: complexityText)
                        ],
                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
