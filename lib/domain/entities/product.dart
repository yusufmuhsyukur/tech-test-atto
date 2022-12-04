import 'package:equatable/equatable.dart';

class Product extends Equatable {
  Product({
    required this.id,
    required this.name,
    this.qty = 0,
  });

  final int id;
  final String? name;
  int qty;

  @override
  List<Object?> get props => [
        id,
        name,
        qty,
      ];
}
