import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../domain/api_client/image_downloader.dart';
import '../../domain/blocs/cart_blocs/cart_bloc.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_event.dart';
import '../../domain/blocs/cart_blocs/cart_bloc_state.dart';

class CartWidget extends StatelessWidget {
  const CartWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final imageDownloader = ImageDownloader();
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Корзина",
            style: TextStyle(color: Colors.white),
          ),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        body: BlocBuilder<CartBloc, CartBlocState>(
          builder: (BuildContext context, state) {
            final cartMovies = state.cartBlocModel.movieListOnCart;
            return ListView.builder(
                itemExtent: 240,
                itemCount: cartMovies.length,
                itemBuilder: (BuildContext context, int index) {
                  final movie = cartMovies[index];
                  final posterPath = movie.movieListRowData?.posterPath;
                  final dreleaceDate = movie.movieListRowData?.releaseDate;
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              bottomLeft: Radius.circular(10)),
                          child: CachedNetworkImage(
                            placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator()),
                            imageUrl:
                                imageDownloader.imageUrl(posterPath ?? ''),
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
                                movie.movieListRowData?.title ?? "",
                                style: const TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                              DateFormat().format(dreleaceDate!),
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
                                movie.movieListRowData?.overview ?? '',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Align(
                                  alignment: Alignment.centerRight,
                                  child: ElevatedButton(
                                      onPressed: () => context
                                          .read<CartBloc>()
                                          .add(RemoveFromCartEvent(
                                              movie: movie.movieListRowData)),
                                      child: const Text(
                                        "Remove movie",
                                        style: TextStyle(color: Colors.blue),
                                      ))),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  TextButton(
                                    onPressed: () => context
                                        .read<CartBloc>()
                                        .add(RemoveQuantityEvent(
                                            movie: movie.movieListRowData)),
                                    child: const Icon(Icons.remove),
                                  ),
                                  Text("${movie.quantity}"),
                                  TextButton(
                                    onPressed: () => context
                                        .read<CartBloc>()
                                        .add(AddQuantityEvent(
                                            movie: movie.movieListRowData)),
                                    child: const Icon(Icons.add),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                    ),
                  );
                });
          },
        ));
  }
}
