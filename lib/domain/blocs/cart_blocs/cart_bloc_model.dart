import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../entity/movie_cart.dart';

class CartBlocModel {
  List<MovieCart> movieListOnCart = [];
  int movieQuanti = 0;
  List<MovieCart> movieFromJson = [];

  void getMoviesFromStorage() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String? stringMovies = prefs.getString("movies");
    List fromJsonMovies = jsonDecode(stringMovies ?? "");
    movieFromJson.clear();
    for (var item in fromJsonMovies) {
      movieFromJson.add(MovieCart.fromJson(item));
    }
    movieListOnCart = movieFromJson;
  }

  void setMovieFromJson() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List jsonMovies = movieFromJson.map((movie) => movie.toJson()).toList();
    await prefs.setString("movies", jsonEncode(jsonMovies));
  }

  int cartQty() {
    return movieListOnCart.fold(
        0, (previousValue, element) => previousValue + (element.quantity ?? 0));
  }

  bool isEmptyMovie(movie) {
    movieQuantity(movie);
    return movieListOnCart
        .any((element) => element.movieListRowData?.id == movie.id);
  }

  void movieQuantity(movie) {
    for(int i = 0; i < movieListOnCart.length; i++) {
      if(movieListOnCart[i].movieListRowData?.id == movie.id) {
        movieQuanti = movieListOnCart[i].quantity!;
      }
    }
  }
}
