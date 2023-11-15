import 'package:themoviedb/domain/entity/movies.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_model.dart';

abstract class CartBlocEvent {}

class AddCartEvent extends CartBlocEvent {
  MovieListRowData? movie;

  AddCartEvent({required this.movie});
}

// class AddedCartEvent extends CartBlocEvent {
//   List<MovieListRowData> movies;
//
//   AddedCartEvent({required this.movies});
// }

class DeleteFromCartEvent extends CartBlocEvent {}

class ErrorCartEvent extends CartBlocEvent {}

class AddQuantityEvent extends CartBlocEvent {
  MovieListRowData? movie;

  AddQuantityEvent({required this.movie});
}
class RemoveQuantityEvent extends CartBlocEvent {}