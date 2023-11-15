import '../../entity/movie_cart.dart';

class CartBlocModel {
  List<MovieCart> movieListOnCart = [];

  int cartQty() {
    return movieListOnCart.fold(
        0, (previousValue, element) => previousValue + (element.quantity ?? 0));
  }

  bool isEmptyMovie(movie) {
    return movieListOnCart
        .any((element) => element.movieListRowData?.id == movie.id);
  }
}
