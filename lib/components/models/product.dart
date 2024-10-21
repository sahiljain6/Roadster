import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  const Product(
      {required this.id,
      required this.title,
      required this.category,
      required this.description,
      required this.imageUrl,
      required this.price,
      required this.rating});
  final int id;
  final String title;
  final String imageUrl;
  final String description;
  final double price;
  final String category;
  final double rating;

  factory Product.fromJson(Map<String, dynamic> json) => $ProductFromJson(json);

  Map<String, dynamic> toJson() => $ProductToJson(this);
}
