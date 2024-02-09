import 'package:figma_practice/models/meal.dart';
import 'package:figma_practice/models/category.dart';
import 'package:figma_practice/models/meal_images.dart';

List<Meal> meals = [
  Meal(
      id: 'a1',
      title: 'First fried beans1',
      details:
          'Fried beans made with african flafour. This will quench your taste in no time',
      categoryId: 'cat1',
      price: 1302,
      imageUrl: 'assets/image2.png',
      imageUrl2: 'assets/image3.png',
      frequency: 1),
  Meal(
      id: 'a2',
      title: 'African fried beans2',
      details:
          'Fried beans made with african flafour. This will quench your taste in no time',
      categoryId: 'cat3',
      price: 1002,
      imageUrl: 'assets/image3.png',
      frequency: 1),
  Meal(
      id: 'a3',
      title: 'African fried beans3',
      details:
          'Fried beans made with african flafour. This will quench your taste in no time',
      categoryId: 'cat2',
      price: 1002,
      imageUrl: 'assets/image3.png',
      frequency: 1),
  Meal(
      id: 'a4',
      title: 'African fried beans4',
      details:
          'Fried beans made with african flafour. This will quench your taste in no time',
      categoryId: 'cat1',
      price: 1002,
      imageUrl: 'assets/image3.png',
      frequency: 1),
  Meal(
      id: 'a5',
      title: 'African fried beans5',
      details:
          'Fried beans made with african flafour. This will quench your taste in no time',
      categoryId: 'cat2',
      price: 1002,
      imageUrl: 'assets/image3.png',
      frequency: 1),
  Meal(
      id: 'a6',
      title: 'African fried beans6',
      details:
          'Fried beans made with african flafour. This will quench your taste in no time',
      categoryId: 'cat4',
      price: 1002,
      imageUrl: 'assets/image3.png',
      frequency: 1),
  Meal(
      id: 'a7',
      title: 'African fried beans6',
      details:
          'Fried beans made with african flafour. This will quench your taste in no time',
      categoryId: 'cat4',
      price: 1002,
      imageUrl: 'assets/image3.png',
      frequency: 1),
  Meal(
      id: 'a8',
      title: 'African fried beans8',
      details:
          'Fried beans made with african flafour. This will quench your taste in no time',
      categoryId: 'cat5',
      price: 1002,
      imageUrl: 'assets/image3.png',
      frequency: 1),
  Meal(
      id: 'a9',
      title: 'African fried beans9',
      details:
          'Fried beans made with african flafour. This will quench your taste in no time',
      categoryId: 'cat4',
      price: 1002,
      imageUrl: 'assets/image3.png',
      frequency: 1),
];

List<CategoryModel> categories = const [
  CategoryModel(id: 'cat0', name: 'All'),
  CategoryModel(id: 'cat1', name: 'Protein'),
  CategoryModel(id: 'cat2', name: 'Snacks'),
  CategoryModel(id: 'cat3', name: 'Carbohydrate'),
  CategoryModel(id: 'cat4', name: 'Vegetables'),
  CategoryModel(id: 'cat5', name: 'African'),
];

List<MealImages> mealImages = const [
  MealImages(
      mealId: 'a1',
      imageUrl1: 'assets/image2.png',
      imageUrl2: 'assets/image3.png',
      imageUrl3: 'assets/image2.png')
];
