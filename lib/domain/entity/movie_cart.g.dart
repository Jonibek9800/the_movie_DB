// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_cart.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieCart _$MovieCartFromJson(Map<String, dynamic> json) => MovieCart(
      quantity: json['quantity'] as int?,
      movieListRowData: json['movie_list_row_data'] == null
          ? null
          : Movie.fromJson(json['movie_list_row_data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MovieCartToJson(MovieCart instance) => <String, dynamic>{
      'quantity': instance.quantity,
      'movie_list_row_data': instance.movieListRowData?.toJson(),
    };
