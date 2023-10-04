import 'package:flutter/material.dart';
import 'package:meals/screens/meals_screen.dart';

import '../models/meal.dart';
import 'categories.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> favoriteMeals = [];

  void _onSelectScreen(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessage(var action) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: const Duration(seconds: 2),
        content: Center(child: Text(action))));
  }

  void _toggleMealFavorites(Meal meal) {
    setState(() {
      if (favoriteMeals.contains(meal)) {
        favoriteMeals.remove(meal);
        _showInfoMessage("Meal removed from favorites");
      } else {
        favoriteMeals.add(meal);
        _showInfoMessage("Meal added to favorites");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget _currentScreen = CategoriesScreen(
      onToggleFavorite: _toggleMealFavorites,
    );
    var _activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      _currentScreen = MealsScreen(
        meals: favoriteMeals,
        onToggleFavorite: _toggleMealFavorites,
      );
      _activePageTitle = 'Favorites';
    }
    return Scaffold(
        appBar: AppBar(title: Text(_activePageTitle)),
        body: _currentScreen,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: (index) => _onSelectScreen(index),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.category), label: "categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "favories")
          ],
        ));
  }
}
