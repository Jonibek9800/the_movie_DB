import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/widgets/auth/auth_model.dart';
import 'package:themoviedb/widgets/auth/auth_widget.dart';
import 'package:themoviedb/widgets/main_screen/main_screen_widget.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb/widgets/movie_list/movie_list.dart';
import 'package:themoviedb/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb/widgets/movie_trailers/movie_trailer_widget.dart';
import 'package:themoviedb/widgets/singUp/sign_up_model.dart';
import 'package:themoviedb/widgets/singUp/sing_up.dart';

import '../../widgets/loader_widget/loader_view_model.dart';
import '../../widgets/loader_widget/loader_widget.dart';

class ScreenFactorey {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const AuthWidget(),
    );
  }

  Widget makeMainScreen() {
    return const MainScreenWidget();
  }

  Widget makeSingUp() {
    return ChangeNotifierProvider(
      create: (_) => SignUpModel(),
      child: const SignUpWidget(),
    );
  }

  Widget makeMovieDetails(int movieId) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsViewModel(movieId: movieId),
      child: const MovieDetailsWidget(),
    );
  }

  Widget makeMovieTrailer(String youTubeKey) {
    return MovieTrailerWidget(youTubeKey: youTubeKey);
  }

  Widget makeHome() {
    return const Text("Home Page");
  }

  Widget makeMovieList() {
    return ChangeNotifierProvider(
      create: (_) => MovieListViewModel(),
      child: const MovieListWidget(),
    );
  }

  Widget makeSerials(){
    return const Text("Serials");
  }
}
