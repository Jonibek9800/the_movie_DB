import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movies.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';

import '../../ui/navigator/main_navigator.dart';

class MovieListModel {
  final _apiCliet = ApiClient();
  final List<Movie> _movies = [];

  List<Movie> get movies => _movies;
  late int _currentPage;
  late int _totalPage;
  bool isLoad = false;
  String? searchQuery;
  Timer? searchDebounce;
}

class MovieListViewModel extends ChangeNotifier {
  MovieListModel model = MovieListModel();
  late DateFormat _dateFormat;
  String _locale = '';

  String stringFromDate(DateTime? date) =>
      date != null ? _dateFormat.format(date) : '';

  Future<void> setupLocal(BuildContext context) async {
    final local = Localizations.localeOf(context).toLanguageTag();
    if (_locale == local) return;
    _locale = local;
    _dateFormat = DateFormat.yMMMMd(local);

    await _resetList();
  }

  Future<void> _resetList() async {
    model._currentPage = 0;
    model._totalPage = 1;
    model._movies.clear();
    await _loadNextPage();
  }

  Future<PopularMoviesResponse> _loadMovies(int nextPage, String locale) async {
    if (model.searchQuery == null) {
      return await model._apiCliet.popularMovies(nextPage, locale);
    } else {
      return await model._apiCliet
          .searchMovie(nextPage, locale, model.searchQuery!);
    }
  }

  Future<void> _loadNextPage() async {
    if (model.isLoad || model._currentPage >= model._totalPage) return;
    model.isLoad = true;

    final nextPage = model._currentPage + 1;
    try {
      final response = await _loadMovies(nextPage, _locale);
      model._movies.addAll(response.movies);
      model._currentPage = response.page;
      model._totalPage = response.totalPages;
      model.isLoad = false;
      notifyListeners();
    } catch (err) {
      model.isLoad = false;
    }
  }

  void onMovieTab(BuildContext context, int index) {
    final id = model._movies[index].id;
    Navigator.of(context)
        .pushNamed(MainNavigationRouteNames.movieDetails, arguments: id);
  }

  Future<void> searchMovie(String text) async {
    model.searchDebounce?.cancel();
    model.searchDebounce = Timer(const Duration(milliseconds: 300), () async {
      final _searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == model.searchQuery) return;
      model.searchQuery = _searchQuery;
      await _resetList();
    });
  }

  void showMovieAtIndex(int index) {
    if (index < model._movies.length - 1) return;
    _loadNextPage();
  }
}
