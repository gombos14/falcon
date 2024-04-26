class Furniture {
  final int id;
  final String title;
  final String description;
  final String image;
  final double price;
  final bool isPopular;
  final bool isNew;

  Furniture({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.image,
    this.isPopular = false,
    this.isNew = false
  });

  factory Furniture.fromJson(Map<String, dynamic> json) {
    return Furniture(
      id: json['id'] as int,
      title: json['title'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      price: double.parse(json['price'] as String),
    );
  }
}
