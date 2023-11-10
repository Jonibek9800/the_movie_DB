import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/services/movie_service.dart';
import 'package:themoviedb/library/pagination.dart';

import '../../domain/entity/movies.dart';
import '../../ui/navigator/main_navigator.dart';

class MovieListRowData {
  final int id;
  final String? posterPath;
  final String? title;
  final String? releaseDate;
  final String? overview;

  const MovieListRowData(
      {required this.id,
      required this.posterPath,
      required this.releaseDate,
      required this.title,
      required this.overview});
}

class MovieListModel {
  final _movieService = MovieService();
  late final Pagination<Movie> _popularMoviePagination;
  late final Pagination<Movie> _searchMoviePagination;
  Timer? searchDebounce;
  String _locale = '';

  List<MovieListRowData> _movies = [];

  List<MovieListRowData> get movies => _movies;
  String? searchQuery;

  MovieListModel() {
    _popularMoviePagination = Pagination<Movie>((page) async {
      final result = await _movieService.popularMovie(page, _locale);
      return PaginationLoadData(
          data: result.movies,
          currentPage: result.page,
          totalPage: result.totalPages);
    });
    _searchMoviePagination = Pagination<Movie>((page) async {
      final result =
          await _movieService.searchMovie(page, _locale, searchQuery ?? '');
      return PaginationLoadData(
          data: result.movies,
          currentPage: result.page,
          totalPage: result.totalPages);
    });
  }
}

class MovieListViewModel extends ChangeNotifier {
  MovieListModel model = MovieListModel();
  late DateFormat _dateFormat;

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  bool get isSearchMode {
    final searchQuery = model.searchQuery;
    return searchQuery != null && searchQuery.isNotEmpty;
  }

  Future<void> setupLocal(BuildContext context) async {
    final local = Localizations.localeOf(context).toLanguageTag();
    if (model._locale == local) return;
    model._locale = local;
    _dateFormat = DateFormat.yMMMMd(local);

    await _resetList();
  }

  Future<void> _resetList() async {
    await model._searchMoviePagination.reset();
    await model._popularMoviePagination.reset();
    model._movies.clear();
    await _loadNextPage();
  }

  Future<void> _loadNextPage() async {
    if (isSearchMode) {
      await model._searchMoviePagination.loadNextPage();
      model._movies =
          model._searchMoviePagination.data.map(_makeRowData).toList();
    } else {
      await model._popularMoviePagination.loadNextPage();
      model._movies =
          model._popularMoviePagination.data.map(_makeRowData).toList();
    }
    notifyListeners();
  }

  MovieListRowData _makeRowData(Movie movie) {
    final releaseDate = movie.releaseDate;
    final dateForString =
        releaseDate != null ? _dateFormat.format(releaseDate) : '';
    return MovieListRowData(
        id: movie.id ?? 0,
        posterPath: movie.posterPath,
        releaseDate: dateForString,
        title: movie.title,
        overview: movie.overview);
  }

  void onMovieTab(BuildContext context, int index) {
    final id = model._movies[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.movieDetails, arguments: id);
  }

  Future<void> searchMovie(String text) async {
    model.searchDebounce?.cancel();
    model.searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      print(searchQuery);
      print(model.searchQuery);
      if (searchQuery == model.searchQuery) return;
      model.searchQuery = searchQuery;
      model._movies.clear();
      if (isSearchMode) {
       await model._searchMoviePagination.reset();
      }
      _loadNextPage();
    });
  }

  void showMovieAtIndex(int index) {
    if (index < model._movies.length - 1) return;
    _loadNextPage();
  }
}
