import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';

import 'movie_list_model.dart';

class MovieListWidget extends StatelessWidget {
  const MovieListWidget({super.key});

  // final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MovieListViewModel>(context);
    if (model.model.isLoad == true)
      return const Center(child: CircularProgressIndicator());
    return Stack(children: [
      ListView.builder(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          padding: EdgeInsets.only(top: 75),
          itemCount: model.model.movies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            model.showMovieAtIndex(index);
            final movie = model.model.movies[index];
            final posterPath = movie.posterPath;
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: Stack(children: [
                DecoratedBox(
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
                            placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                            imageUrl: ApiClient.imageUrl(posterPath),
                          ),
                        // Image.network(ApiClient.imageUrl(posterPath),
                          //   loadingBuilder: (BuildContext context, Widget child,
                          //       ImageChunkEvent? loadingProgress) {
                          //     if (loadingProgress == null) {
                          //       return child;
                          //     }
                          //     return Padding(
                          //       padding: const EdgeInsets.all(12.0),
                          //       child: Center(
                          //         child: CircularProgressIndicator(
                          //           value: loadingProgress.expectedTotalBytes != null
                          //               ? loadingProgress.cumulativeBytesLoaded /
                          //               loadingProgress.expectedTotalBytes!
                          //               : null,
                          //         ),
                          //       ),
                          //     );
                          //   },)
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
                              movie.title,
                              style: const TextStyle(
                                  fontSize: 17, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              model.stringFromDate(movie.releaseDate), /// DateFormat.yMMMMd().format(releaseDate)",
                              // movie.releaseDate.toString(),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.grey,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Text(
                              movie.overview,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(7),
                    onTap: () => model.onMovieTab(context, index),
                  ),
                )
              ]),
            );
          }),
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: TextField(
          onChanged: model.searchMovie,
          // controller: _searchController,
          decoration: InputDecoration(
              labelText: 'Search...',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: const OutlineInputBorder()),
        ),
      ),
    ]);
  }
}
