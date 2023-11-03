import 'package:json_annotation/json_annotation.dart';

import 'movie_dateparser.dart';

part 'movie_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MoviesDatails {
  final bool? adult;
  final String? backdropPath;
  final BelongsToCollection? belongsToCollection;
  final int? budget;
  final List<Genres>? genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompanies>? productionCompanies;
  final List<ProductionCountries>? productionCountries;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguages>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final VideosDetails? videos;

  MoviesDatails(
      {this.adult,
        this.backdropPath,
        this.belongsToCollection,
        this.budget,
        this.genres,
        this.homepage,
        this.id,
        this.imdbId,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.productionCompanies,
        this.productionCountries,
        this.releaseDate,
        this.revenue,
        this.runtime,
        this.spokenLanguages,
        this.status,
        this.tagline,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
        this.videos});

  factory MoviesDatails.fromJson(Map<String, dynamic> json) => _$MoviesDatailsFromJson(json);

  Map<String, dynamic> toJson() => _$MoviesDatailsToJson(this);

}

@JsonSerializable(fieldRename: FieldRename.snake)
class BelongsToCollection {
  final int? id;
  final String? name;
  final String? posterPath;
  final String? backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});


  factory BelongsToCollection.fromJson(Map<String, dynamic> json) => _$BelongsToCollectionFromJson(json);

  Map<String, dynamic> toJson() => _$BelongsToCollectionToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Genres {
  final int? id;
  final String? name;

  Genres({this.id, this.name});

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

  Map<String, dynamic> toJson() => _$GenresToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCompanies {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) => _$ProductionCompaniesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompaniesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ProductionCountries {
  @JsonKey(name: 'iso_3166_1')
  final String? iso;
  final String? name;

  ProductionCountries({this.iso, this.name});

  factory ProductionCountries.fromJson(Map<String, dynamic> json) => _$ProductionCountriesFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountriesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class SpokenLanguages {
  final String? englishName;
  final String? iso6391;
  final String? name;

  SpokenLanguages({this.englishName, this.iso6391, this.name});


  factory SpokenLanguages.fromJson(Map<String, dynamic> json) => _$SpokenLanguagesFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguagesToJson(this);
  }




@JsonSerializable(fieldRename: FieldRename.snake)
class VideosDetails {
  List<Results>? results;

  VideosDetails({this.results});
  factory VideosDetails.fromJson(Map<String, dynamic> json) => _$VideosDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$VideosDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake)
class Results {
  @JsonKey(name: 'iso_639_1')
  String? iso6391;
  @JsonKey(name: 'iso_3166_1')
  String? iso31661;
  String? name;
  String? key;
  String? site;
  int? size;
  String? type;
  bool? official;
  String? publishedAt;
  String? id;

  Results(
      {this.iso6391,
        this.iso31661,
        this.name,
        this.key,
        this.site,
        this.size,
        this.type,
        this.official,
        this.publishedAt,
        this.id});

  factory Results.fromJson(Map<String, dynamic> json) => _$ResultsFromJson(json);

  Map<String, dynamic> toJson() => _$ResultsToJson(this);
}