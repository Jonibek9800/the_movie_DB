import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/entity/movie_credits.dart';
import 'package:themoviedb/ui/navigator/main_navigator.dart';
import 'package:themoviedb/widgets/movie_details/movie_details_model.dart';

import '../../domain/api_client/image_downloader.dart';
import '../element/radial_percent_widget.dart';

class MovieDetailsMainInfoWidget extends StatelessWidget {
  const MovieDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MovieDetailsViewModel>(context);
    return Column(
      children: <Widget>[
        SizedBox(
            height: 220,
            width: MediaQuery.of(context).size.width,
            child: const _TopPostersWidget()),
        const Padding(
          padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
          child: _MoviesNameWidget(),
        ),
        const _ScoreWidget(),
        Container(
          color: const Color(0xFF1D1D1D),
          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          child: const _SummeryWidget(),
        ),
        Container(
            padding: const EdgeInsets.fromLTRB(15, 20, 0, 0),
            alignment: Alignment.centerLeft,
            child: Text(
              model.model.moviesDatails?.tagline ?? '',
              style: const TextStyle(color: Colors.grey, fontSize: 17.6),
            )),
        const _ReviewWidget(),
        const _PeopleWidget()
      ],
    );
  }
}

class _TopPostersWidget extends StatelessWidget {
  const _TopPostersWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MovieDetailsViewModel>(context);
    final backdropPath = model.model.moviesDatails?.backdropPath;
    final posterPath = model.model.moviesDatails?.posterPath;
    final imageDownloader = ImageDownloader();
    return Stack(
      children: [
        Positioned(
          top: 0,
          bottom: 0,
          right: 0,
          left: 0,
          // ApiClient.imageUrl(actor?.profilePath ?? "")
          child: backdropPath != null
              ? CachedNetworkImage(
                  imageUrl: imageDownloader.imageUrl(backdropPath),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                    child: CircularProgressIndicator(
                        value: downloadProgress.progress),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                )
              : const Center(child: Text("Загрузка...")),
        ),
        Positioned(
          top: 20,
          bottom: 20,
          left: 20,
          child: posterPath != null
              ? CachedNetworkImage(
                  imageUrl: imageDownloader.imageUrl(posterPath),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      Center(
                        child: CircularProgressIndicator(
                            value: downloadProgress.progress),
                      ),
                  errorWidget: (context, url, error) => const Icon(Icons.error))
              : const Center(child: Text("Загрузка...")),
        ),
        Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: Icon(model.model.isFavorite ? Icons.favorite : Icons.favorite_border, color: Colors.red,),
              onPressed: () {
                model.toggleFavorite();
              },
            ))
      ],
    );
  }
}

class _MoviesNameWidget extends StatelessWidget {
  const _MoviesNameWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MovieDetailsViewModel>(context);
    final movieName = model.model.moviesDatails?.title;
    final year = model.model.moviesDatails?.releaseDate?.year.toString() ?? '';

    return RichText(
        textAlign: TextAlign.center,
        maxLines: null,
        text: TextSpan(children: [
          TextSpan(
              text: movieName,
              style:
                  const TextStyle(fontWeight: FontWeight.w800, fontSize: 18)),
          TextSpan(
              text: " ($year)",
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.grey))
        ]));
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MovieDetailsViewModel>(context).model;
    final trailers = model.moviesDatails?.videos?.results
        ?.where((video) => video.type == "Trailer" && video.site == "YouTube");
    final trailerKey =
        trailers != null && trailers.isNotEmpty ? trailers.first.key : null;
    double percent = model.moviesDatails!.voteAverage! * 10 ?? 0.0;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
            onPressed: () {},
            child: Row(
              children: [
                Container(
                  width: 55,
                  height: 55,
                  child: RadialPercentWidget(
                    percent: percent,
                    fillColor: Colors.black,
                    freeColor: Colors.grey,
                    lineColor: Colors.green,
                    lineWidth: 3,
                    child: Text(
                      "${percent.toInt()}%",
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                const Text(
                  'Рейтинг',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            )),
        Container(
          color: Colors.grey,
          width: 2,
          height: 15,
        ),
        trailerKey != null
            ? TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                      MainNavigationRouteNames.movieTrailer,
                      arguments: trailerKey);
                },
                child: const Row(
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Воспроизвести трейлер',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ))
            : const Text(
                "Нет трейлера",
                style: TextStyle(color: Colors.white),
              ),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  const _SummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    var texts = [];
    final model = Provider.of<MovieDetailsViewModel>(context);
    final releasDate = model.model.moviesDatails?.releaseDate;
    if (releasDate != null) {
      texts.add(model.stringFromDate(
          releasDate)); // model.model.moviesDatails!.productionCountries.first.iso31661;
    }
    final productCountries = model.model.moviesDatails?.productionCountries;
    if (productCountries != null && productCountries.isNotEmpty) {
      texts.add('(${productCountries.first.iso})');
    }
    final runtime = model.model.moviesDatails?.runtime;
    final movieDuration = Duration(minutes: runtime!);
    final movieTimes =
        '${movieDuration.inHours}ч ${movieDuration.inMinutes % 60}м';
    texts.add(movieTimes);

    final genres = model.model.moviesDatails?.genres;
    if (genres != null && genres.isNotEmpty) {
      final movieGenres = genres.map((genre) => genre.name);
      texts.add(movieGenres?.join(', '));
    }
    return RichText(
        textAlign: TextAlign.center,
        maxLines: 4,
        text: TextSpan(children: [
          const TextSpan(
              text: "PG-13 ",
              style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Color.fromRGBO(255, 255, 255, 0.6))),
          TextSpan(
              text: texts.join(' '),
              style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.white))
        ]));
  }
}

class _ReviewWidget extends StatelessWidget {
  const _ReviewWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MovieDetailsViewModel>(context).model;
    final overview = model.moviesDatails?.overview;
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(15, 10, 0, 0),
            alignment: Alignment.centerLeft,
            child: const Text(
              "Обзор",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 21,
                  fontWeight: FontWeight.w600),
            )),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            overview!,
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      ],
    );
  }
}

class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget({
    super.key,
  });

  static const manStyle =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w700);
  static const jobStyle = TextStyle(color: Colors.white, fontSize: 14);

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MovieDetailsViewModel>(context).model;
    final crew = model.moviesCredits?.crew;
    final chuncks = <Crew>[];
    if (crew == null) {
      return const Text("Loading...");
    }
    final filteredCrew = crew.where((el) =>
        el.job == "Director" ||
        el.job == "Characters" ||
        el.job == "Screenplay" ||
        el.job == "Writer" ||
        el.job == "Story");

    for (var person in filteredCrew) {
      if (chuncks.any((el) => el.name == person.name)) {
        var existingPerson = chuncks.firstWhere((el) => el.name == person.name);
        existingPerson.job = "${existingPerson.job ?? ''}, ${person.job}";
      } else {
        chuncks.add(person);
      }
    }
    if (chuncks == null) return const SizedBox.shrink();
    return GridView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 15,
        ),
        shrinkWrap: true,
        primary: false,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            mainAxisExtent: 70),
        itemCount: chuncks.length,
        itemBuilder: (BuildContext context, int index) {
          final chunck = chuncks[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${chunck?.name}",
                style: manStyle,
              ),
              Text(
                "${chunck?.job}",
                style: jobStyle,
              )
            ],
          );
        });
  }
}
