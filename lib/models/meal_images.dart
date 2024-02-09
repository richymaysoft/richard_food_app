class MealImages {
  const MealImages(
      {required this.mealId,
      required this.imageUrl1,
      this.imageUrl2,
      this.imageUrl3,
      this.imageUrl4});

  final String mealId;
  final String imageUrl1;
  final String? imageUrl2;
  final String? imageUrl3;
  final String? imageUrl4;
}
