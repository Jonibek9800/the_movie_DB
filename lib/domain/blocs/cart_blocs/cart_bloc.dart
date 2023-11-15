import 'package:bloc/bloc.dart';
import 'package:themoviedb/domain/blocs/cart_blocs/cart_bloc_event.dart';
import 'package:themoviedb/domain/blocs/cart_blocs/cart_bloc_model.dart';
import 'package:themoviedb/domain/blocs/cart_blocs/cart_bloc_state.dart';
import 'package:themoviedb/domain/entity/movie_cart.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_model.dart';

enum CartBlocViewState { addCart, addedCart }

class CartBloc extends Bloc<CartBlocEvent, CartBlocState> {
  CartBloc() : super(InitCartState(cartBlocModel: CartBlocModel())) {
    on<AddCartEvent>((event, emit) => addToCart(emit, event.movie));
    on<AddQuantityEvent>((event, emit) => addQuantity(emit, event.movie));
  }

  void addToCart(Emitter emit, MovieListRowData? movie) {
    var currentState = state.cartBlocModel;

    try {
      var movieIndex = -1;
      movieIndex = currentState.movieListOnCart
          .indexWhere((element) => element.movieListRowData?.id == movie?.id);
      if (movieIndex != -1) {
        currentState.movieListOnCart[movieIndex] = MovieCart(
            quantity: currentState.movieListOnCart[movieIndex].quantity! + 1,
            movieListRowData: movie);
      } else {
        MovieCart movieCart = MovieCart(quantity: 1, movieListRowData: movie);
        currentState.movieListOnCart.add(movieCart);
      }
      emit(AddCartState(cartBlocModel: currentState));
    } catch (e) {
      emit(ErrorCartState(cartBlocModel: currentState));
    }
  }

  void addQuantity(Emitter emit, MovieListRowData? movie) {
    var currentState = state.cartBlocModel;
    var movieIndex = -1;
    movieIndex = currentState.movieListOnCart
        .indexWhere((element) => element.movieListRowData?.id == movie?.id);
    currentState.movieListOnCart[movieIndex] = MovieCart(
        quantity: currentState.movieListOnCart[movieIndex].quantity! + 1,
        movieListRowData: movie);
    emit(AddQuantityState(cartBlocModel: currentState));
  }

}
