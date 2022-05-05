import 'package:clean_architecture_cubit/domain/entities/belongs_to_collection.dart';
import 'package:clean_architecture_cubit/domain/entities/genres.dart';
import 'package:clean_architecture_cubit/domain/entities/production_companies.dart';
import 'package:clean_architecture_cubit/domain/entities/production_countries.dart';
import 'package:clean_architecture_cubit/domain/entities/spoken_languages.dart';
import 'package:equatable/equatable.dart';

class MovieDetails extends Equatable {
  bool? adult;
  String? backdropPath;
  BelongsToCollection? belongsToCollection;
  int? budget;
  List<Genres>? genres;
  String? homepage;
  int? id;
  String? imdbId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  List<ProductionCompanies>? productionCompanies;
  List<ProductionCountries>? productionCountries;
  String? releaseDate;
  int? revenue;
  int? runtime;
  List<SpokenLanguages>? spokenLanguages;
  String? status;
  String? tagline;
  String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  MovieDetails({
     this.adult,
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
  });

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        belongsToCollection,
        budget,
        genres,
        homepage,
        id,
        imdbId,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        productionCompanies,
        productionCountries,
        releaseDate,
        revenue,
        runtime,
        spokenLanguages,
        status,
        tagline,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
