import 'package:themoviedb/domain/entity/movies.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_model.dart';

abstract class CartBlocEvent {}

class AddCartEvent extends CartBlocEvent {
  Movie? movie;

  AddCartEvent({required this.movie});
}

// class AddedCartEvent extends CartBlocEvent {
//   List<MovieListRowData> movies;
//
//   AddedCartEvent({required this.movies});
// }

class RemoveFromCartEvent extends CartBlocEvent {
  Movie? movie;

  RemoveFromCartEvent({required this.movie});
}

class ErrorCartEvent extends CartBlocEvent {}

class AddQuantityEvent extends CartBlocEvent {
  Movie? movie;

  AddQuantityEvent({required this.movie});
}
class RemoveQuantityEvent extends CartBlocEvent {
  Movie? movie;

  RemoveQuantityEvent({required this.movie});
}