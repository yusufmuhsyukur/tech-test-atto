import 'package:equatable/equatable.dart';
import 'package:tech_test_atto/domain/entities/product.dart';

class ProductModel extends Equatable {
  const ProductModel({
    required this.userId,
    required this.id,
    required this.title,
    required this.completed,
  });

  final int? userId;
  final int? id;
  final String? title;
  final bool? completed;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        userId: json["userId"],
        id: json["id"],
        title: json["title"],
        completed: json["completed"],
      );

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "id": id,
        "title": title,
        "completed": completed,
      };

  Product toEntity() {
    return Product(
      id: id!,
      name: title,
    );
  }

  @override
  List<Object?> get props => [
        id,
        userId,
        title,
        completed,
      ];
}
