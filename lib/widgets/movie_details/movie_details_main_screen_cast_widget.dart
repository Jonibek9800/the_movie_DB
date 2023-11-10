import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/domain/api_client/image_downloader.dart';
import 'package:themoviedb/resources/resources.dart';
import 'package:themoviedb/utils/extensions.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'movie_details_model.dart';


class MovieDetailsMainScreenCastWidget extends StatelessWidget {
  const MovieDetailsMainScreenCastWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<MovieDetailsViewModel>(context).model;
    final imageDownloader = ImageDownloader();
    if(model.moviesCredits?.cast == null) {
      return const Center(
        child: Text("Нет актерского состава")
      );
    } else{
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Text(
              "В главных ролях",
              style: TextStyle(fontSize: 19, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(
            height: 330,
            child: Scrollbar(
              radius: const Radius.circular(15),
              child: ListView.builder(
                  itemCount: model.moviesCredits?.cast?.sortedTwentyList().length,
                  itemExtent: 130,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    final actor = model.moviesCredits?.cast?.sortedTwentyList()[index];
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                                color: Colors.black.withOpacity(0.2)),
                            borderRadius: BorderRadius.circular(7),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              )
                            ]),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(7),
                          // clipBehavior: Clip.hardEdge,
                          child: Column(
                            children: [
                              SizedBox(
                                  height: 180,
                                  child: actor?.profilePath != null
                                      ?
                                  CachedNetworkImage(
                                    imageUrl: imageDownloader.imageUrl(actor?.profilePath ?? ""),
                                    progressIndicatorBuilder: (context, url, downloadProgress) =>
                                        Center(child: CircularProgressIndicator(value: downloadProgress.progress)),
                                    errorWidget: (context, url, error) => const Icon(Icons.error),
                                  ) : const Image(
                                          fit: BoxFit.cover,
                                          image: AssetImage(AppImages.person))),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      actor?.name ?? '',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16),
                                    ),
                                    Text(
                                      overflow: TextOverflow.ellipsis,
                                      actor?.character ?? '',
                                      maxLines: 3,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: TextButton(
                onPressed: () {},
                child: const Text(
                  "Полный актёрский и съёмочный состав",
                  style: TextStyle(color: Colors.black),
                )),
          )
        ],
      ),
    );}
  }
}
