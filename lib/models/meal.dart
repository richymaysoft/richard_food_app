class Meal {
  Meal(
      {required this.id,
      required this.title,
      required this.details,
      required this.categoryId,
      required this.price,
      required this.imageUrl,
      this.imageUrl2,
      this.imageUrl3,
      this.imageUrl4,
      required this.frequency});
  final String id;
  final String title;
  final String details;
  final String categoryId;
  final int price;
  final String imageUrl;
  final String? imageUrl2;
  final String? imageUrl3;
  final String? imageUrl4;
  int frequency;
}
