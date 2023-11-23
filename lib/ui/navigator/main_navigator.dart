import 'package:flutter/material.dart';

import '../../domain/factories/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const loaderWidget = "/";
  static const auth = "/auth";
  static const mainScreen = "/main_screen";
  static const movieDetails = "/main_screen/movie_details";
  static const movieTrailer = "/main_screen/movie_details/trailer";
  static const movieCart = "/main_screen/movie_cart";

  static const signUp = "/sign_up";
}

class MainNavigation {
  static final _screenFactory = ScreenFactorey();

  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.loaderWidget: (_) => _screenFactory.makeLoader(),
    MainNavigationRouteNames.auth: (_) => _screenFactory.makeAuth(),
    MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeMainScreen(),
    MainNavigationRouteNames.signUp: (_) => _screenFactory.makeSingUp(),
    MainNavigationRouteNames.movieCart: (_) => _screenFactory.makeCart(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeMovieDetails(movieId),
        );
      case MainNavigationRouteNames.movieTrailer:
        final arguments = settings.arguments;
        final youTubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeMovieTrailer(youTubeKey),
        );
      default:
        const widget = Text("navigation error!!!");
        return MaterialPageRoute(builder: (_) => widget);
    }
  }

  static void resetNavigation(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(MainNavigationRouteNames.loaderWidget, (route) => false);
  }
}
