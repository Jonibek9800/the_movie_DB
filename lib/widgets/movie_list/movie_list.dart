import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/domain/blocs/cart_blocs/cart_bloc.dart';
import 'package:themoviedb/domain/blocs/cart_blocs/cart_bloc_event.dart';
import 'package:themoviedb/domain/blocs/cart_blocs/cart_bloc_state.dart';

import 'movie_list_model.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<MovieListViewModel>().setupLocal(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Stack(children: [
      _MovieListWidget(),
      _SearchWidget(),
    ]);
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieListViewModel>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: model.searchMovie,
        decoration: InputDecoration(
            labelText: 'Search...',
            filled: true,
            fillColor: Colors.white.withAlpha(235),
            border: const OutlineInputBorder()),
      ),
    );
  }
}

class _MovieListWidget extends StatelessWidget {
  const _MovieListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieListViewModel>();

    return ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: const EdgeInsets.only(top: 75),
        itemCount: model.model.movies.length,
        itemExtent: 200,
        itemBuilder: (BuildContext context, int index) {
          model.showMovieAtIndex(index);
          return _MovieListRowWidget(
            index: index,
          );
        });
  }
}

class _MovieListRowWidget extends StatelessWidget {
  const _MovieListRowWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieListViewModel>();
    final imageDownloader = ImageDownloader();
    final movie = model.model.movies[index];
    final posterPath = movie.posterPath;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: InkWell(
        borderRadius: BorderRadius.circular(7),
        onTap: () => model.onMovieTab(context, index),
        child: Ink(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 2))
            ],
          ),
          child: Row(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: CachedNetworkImage(
                  placeholder: (context, url) =>
                      const Center(child: CircularProgressIndicator()),
                  imageUrl: imageDownloader.imageUrl(posterPath ?? ''),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      movie.title ?? "",
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      model.stringFromDate(movie.releaseDate),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      movie.overview ?? '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    BlocBuilder<CartBloc, CartBlocState>(
                      builder: (BuildContext context, state) {
                        if (state.cartBlocModel.isEmptyMovie(movie) == true) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () => context
                                    .read<CartBloc>()
                                    .add(RemoveQuantityEvent(movie: movie)),
                                child: const Icon(Icons.remove),
                              ),
                              Text("${state.cartBlocModel.movieQuanti}"),
                              TextButton(
                                onPressed: () => context
                                    .read<CartBloc>()
                                    .add(AddQuantityEvent(movie: movie)),
                                child: const Icon(Icons.add),
                              ),
                            ],
                          );
                        } else {
                          return Align(
                              alignment: Alignment.centerRight,
                              child: ElevatedButton(
                                  onPressed: () => context
                                      .read<CartBloc>()
                                      .add(AddCartEvent(movie: movie)),
                                  child: const Text(
                                    "Add Cart",
                                    style: TextStyle(color: Colors.blue),
                                  )));
                        }
                      },
                    )
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
