// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product $ProductFromJson(Map<String, dynamic> json) => Product(
    id: json['id'] as int,
    title: json['title'] as String,
    category: json['category'] as String,
    description: json['description'] as String,
    imageUrl: json['image'] as String,
    price: ((json['price'] as num).toDouble()) * 80,
    rating: (json['rating']['rate'] as num).toDouble());

Map<String, dynamic> $ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'imageUrl': instance.imageUrl,
      'description': instance.description,
      'price': instance.price,
      'category': instance.category,
      'rating': instance.rating
    };
