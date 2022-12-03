import 'package:equatable/equatable.dart';

class Product extends Equatable {
  Product({
    required this.id,
    required this.name,
  });

  int id;
  String? name;

  @override
  List<Object?> get props => [
        id,
        name,
      ];
}
