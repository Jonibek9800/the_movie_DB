import 'package:json_annotation/json_annotation.dart';

import 'movies.dart';

part 'movie_cart.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieCart {
  int? quantity;
  Movie? movieListRowData;

  MovieCart({this.quantity, this.movieListRowData});

  factory MovieCart.fromJson(Map<String, dynamic> json) => _$MovieCartFromJson(json);

  Map<String, dynamic> toJson() => _$MovieCartToJson(this);
}