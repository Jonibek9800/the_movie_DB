import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:themoviedb/domain/blocs/cart_blocs/cart_bloc_event.dart';
import 'package:themoviedb/domain/blocs/cart_blocs/cart_bloc_model.dart';
import 'package:themoviedb/domain/blocs/cart_blocs/cart_bloc_state.dart';
import 'package:themoviedb/domain/entity/movie_cart.dart';
import 'package:themoviedb/domain/entity/movies.dart';

enum CartBlocViewState { addCart, addedCart }

class CartBloc extends Bloc<CartBlocEvent, CartBlocState> {
  CartBloc() : super(InitCartState(cartBlocModel: CartBlocModel())) {
    on<AddCartEvent>((event, emit) => addMovieFromStorageAndCart(emit, event.movie));
    on<AddQuantityEvent>((event, emit) => addQuantity(emit, event.movie));
    on<RemoveQuantityEvent>((event, emit) => removeQuantity(emit, event.movie));
    on<RemoveFromCartEvent>((event, emit) => removeMovie(emit, event.movie));
  }

  // Future<void> addToCart(Emitter emit, Movie? movie) async {
  //   var currentState = state.cartBlocModel;
  //
  //   try {
  //     // var movieIndex = -1;
  //     // movieIndex = currentState.movieListOnCart
  //     //     .indexWhere((element) => element.movieListRowData?.id == movie?.id);
  //     // if (movieIndex != -1) {
  //     //   currentState.movieListOnCart[movieIndex] = MovieCart(
  //     //       quantity: currentState.movieListOnCart[movieIndex].quantity! + 1,
  //     //       movieListRowData: movie);
  //     // } else {
  //     //   MovieCart movieCart = MovieCart(quantity: 1, movieListRowData: movie);
  //     //   currentState.movieListOnCart.add(movieCart);
  //     // }
  //     print("rabotaet");
  //     await addMovieFromStorage(emit, movie);
  //     // emit(AddCartState(cartBlocModel: currentState));
  //   } catch (e) {
  //     emit(ErrorCartState(cartBlocModel: currentState));
  //   }
  // }

  void addMovieFromStorageAndCart(Emitter emit, Movie? movie) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    var currentState = state.cartBlocModel;
    try {
      var movieIndex = -1;
      movieIndex = currentState.movieFromJson
          .indexWhere((element) => element.movieListRowData?.id == movie?.id);
      if (movieIndex != -1) {
        currentState.movieFromJson[movieIndex] = MovieCart(
            quantity: currentState.movieFromJson[movieIndex].quantity! + 1,
            movieListRowData: movie);
        currentState.setMovieFromJson();
      } else {
        currentState.movieFromJson.add(MovieCart(quantity: 1, movieListRowData: movie));
        List jsonMovies = currentState.movieFromJson.map((movie) => movie.toJson()).toList();
        await prefs.setString("movies", jsonEncode(jsonMovies));
        currentState.setMovieFromJson();
        currentState.getMoviesFromStorage();
      }
      emit(AddCartState(cartBlocModel: currentState));
    } catch (e) {
      emit(ErrorCartState(cartBlocModel: currentState));
    }
  }

  void addQuantity(Emitter emit, Movie? movie) {
    var currentState = state.cartBlocModel;
    try {
      var movieIndex = -1;
      movieIndex = currentState.movieFromJson
          .indexWhere((element) => element.movieListRowData?.id == movie?.id);
      currentState.movieFromJson[movieIndex] = MovieCart(
          quantity: currentState.movieFromJson[movieIndex].quantity! + 1,
          movieListRowData: movie);
      currentState.setMovieFromJson();
      emit(AddQuantityState(cartBlocModel: currentState));
    } catch (e) {
      emit(ErrorCartState(cartBlocModel: currentState));
    }
  }

  void removeQuantity(Emitter emit, Movie? movie) {
    var currentState = state.cartBlocModel;
    try {
      var movieIndex = -1;
      movieIndex = currentState.movieFromJson
          .indexWhere((element) => element.movieListRowData?.id == movie?.id);
      currentState.movieFromJson[movieIndex] = MovieCart(
          quantity: currentState.movieFromJson[movieIndex].quantity! - 1,
          movieListRowData: movie);
      currentState.setMovieFromJson();
      if (currentState.movieFromJson[movieIndex].quantity == 0) {
        removeMovie(emit, movie);
      }
      emit(AddQuantityState(cartBlocModel: currentState));
    } catch (e) {
      emit(ErrorCartState(cartBlocModel: currentState));
    }
  }

  void removeMovie(Emitter emit, Movie? movie) {
    var currentState = state.cartBlocModel;
    currentState.movieFromJson = currentState.movieFromJson
        .where((cartMovie) => cartMovie.movieListRowData?.id != movie?.id)
        .toList();
    currentState.setMovieFromJson();
    currentState.getMoviesFromStorage();
    emit(RemoveToCartState(cartBlocModel: currentState));
  }
}
