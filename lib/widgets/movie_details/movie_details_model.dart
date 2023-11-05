import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/entity/movie_credits.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';

import '../../domain/data_providerss/session_data_provider.dart';

class MovieDetailsModel {
  final _apiClient = ApiClient();
  final _sessionDataProvider = SessionDataProvider();

  MoviesDatails? _moviesDatails;

  MoviesDatails? get moviesDatails => _moviesDatails;
  String _locale = '';
  bool _isFavorite = false;

  bool get isFavorite => _isFavorite;
  late DateFormat _dateFormat;
  MovieCredits? _movieCredis;

  MovieCredits? get moviesCredits => _movieCredis;
}

class MovieDetailsViewModel extends ChangeNotifier {
  MovieDetailsViewModel({required this.movieId});

  final int movieId;
  MovieDetailsModel model = MovieDetailsModel();

  Future<void> setupLocale(BuildContext context) async {
    final local = Localizations.localeOf(context).toLanguageTag();
    if (model._locale == local) return;
    model._locale = local;
    model._dateFormat = DateFormat.yMMMMd(local);
    await loadDetails();
    await loadMovieCredits();
    notifyListeners();
  }

  Future<void>? Function()? onSessionExpaired;

  String stringFromDate(DateTime? date) =>
      date != null ? model._dateFormat.format(date) : '';

  Future<void> loadDetails() async {
    final sessionId = await model._sessionDataProvider.getSessionId();
    model._moviesDatails =
        await model._apiClient.movieDetails(movieId, model._locale);
    if (sessionId != null) {
      model._isFavorite =
          await model._apiClient.isFavorite(movieId, sessionId ?? '');
    }
  }

  Future<void> loadMovieCredits() async {
    model._movieCredis =
        await model._apiClient.movieCredits(movieId, model._locale);
  }

  Future<void> toggleFavorite() async {
    final sessionId = await model._sessionDataProvider.getSessionId();
    final accountId = await model._sessionDataProvider.getAccountId();
    if (accountId == null || sessionId == null) return;

    model._isFavorite = !model._isFavorite;
    try {
      await model._apiClient.markAsFavorite(
        acountId: accountId,
        sessionId: sessionId,
        mediaType: MediaType.Movie,
        mediaId: movieId,
        isFavorite: model._isFavorite,
      );
      notifyListeners();
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.SessionExpaired:
          await onSessionExpaired?.call();
          break;
        default:
          print(e);
      }
    }
  }
}
