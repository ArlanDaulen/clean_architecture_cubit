import 'package:clean_architecture_cubit/data/models/genres_model.dart';
import 'package:clean_architecture_cubit/data/models/production_companies_model.dart';
import 'package:clean_architecture_cubit/data/models/production_countries_model.dart';
import 'package:clean_architecture_cubit/data/models/spoken_languages_model.dart';
import 'package:clean_architecture_cubit/domain/entities/movie_details.dart';
import 'belongs_to_collection_model.dart';

class MovieDetailsModel extends MovieDetails {
  MovieDetailsModel({
    required bool adult,
    required String backdropPath,
    required BelongsToCollectionModel belongsToCollection,
    required int budget,
    required List<GenresModel> genres,
    required String homepage,
    required int id,
    required String imdbId,
    required String originalLanguage,
    required String originalTitle,
    required String overview,
    required double popularity,
    required String posterPath,
    required List<ProductionCompaniesModel> productionCompanies,
    required List<ProductionCountriesModel> productionCountries,
    required String releaseDate,
    required int revenue,
    required int runtime,
    required List<SpokenLanguagesModel> spokenLanguages,
    required String status,
    required String tagline,
    required String title,
    required bool video,
    required double voteAverage,
    required int voteCount,
  }) : super(
          adult: adult,
          backdropPath: backdropPath,
          belongsToCollection: belongsToCollection,
          budget: budget,
          genres: genres,
          homepage: homepage,
          id: id,
          imdbId: imdbId,
          originalLanguage: originalLanguage,
          originalTitle: originalTitle,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          productionCompanies: productionCompanies,
          productionCountries: productionCountries,
          releaseDate: releaseDate,
          revenue: revenue,
          runtime: runtime,
          spokenLanguages: spokenLanguages,
          status: status,
          tagline: tagline,
          title: title,
          video: video,
          voteAverage: voteAverage,
          voteCount: voteCount,
        );

  MovieDetailsModel.fromJson(Map<String, dynamic> json) {
    adult = json['adult'];
    backdropPath = json['backdrop_path'];
    belongsToCollection = json['belongs_to_collection'] != null
        ? new BelongsToCollectionModel.fromJson(json['belongs_to_collection'])
        : null;
    budget = json['budget'];
    if (json['genres'] != null) {
      genres = <GenresModel>[];
      json['genres'].forEach((v) {
        genres!.add(new GenresModel.fromJson(v));
      });
    }
    homepage = json['homepage'];
    id = json['id'];
    imdbId = json['imdb_id'];
    originalLanguage = json['original_language'];
    originalTitle = json['original_title'];
    overview = json['overview'];
    popularity = json['popularity'];
    posterPath = json['poster_path'];
    if (json['production_companies'] != null) {
      productionCompanies = <ProductionCompaniesModel>[];
      json['production_companies'].forEach((v) {
        productionCompanies!.add(new ProductionCompaniesModel.fromJson(v));
      });
    }
    if (json['production_countries'] != null) {
      productionCountries = <ProductionCountriesModel>[];
      json['production_countries'].forEach((v) {
        productionCountries!.add(new ProductionCountriesModel.fromJson(v));
      });
    }
    releaseDate = json['release_date'];
    revenue = json['revenue'];
    runtime = json['runtime'];
    if (json['spoken_languages'] != null) {
      spokenLanguages = <SpokenLanguagesModel>[];
      json['spoken_languages'].forEach((v) {
        spokenLanguages!.add(new SpokenLanguagesModel.fromJson(v));
      });
    }
    status = json['status'];
    tagline = json['tagline'];
    title = json['title'];
    video = json['video'];
    voteAverage = json['vote_average'];
    voteCount = json['vote_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    if (belongsToCollection != null) {
      data['belongs_to_collection'] = BelongsToCollectionModel(
        id: belongsToCollection!.id!,
        name: belongsToCollection!.name!,
        posterPath: belongsToCollection!.posterPath!,
        backdropPath: belongsToCollection!.backdropPath!,
      ).toJson();
    }
    data['budget'] = budget;
    if (genres != null) {
      data['genres'] = genres!
          .map((v) => GenresModel(id: v.id!, name: v.name!).toJson())
          .toList();
    }
    data['homepage'] = homepage;
    data['id'] = id;
    data['imdb_id'] = imdbId;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    if (productionCompanies != null) {
      data['production_companies'] = productionCompanies!
          .map((v) => ProductionCompaniesModel(
                  id: v.id!,
                  logoPath: v.logoPath!,
                  name: v.name!,
                  originCountry: v.originCountry!)
              .toJson())
          .toList();
    }
    if (productionCountries != null) {
      data['production_countries'] = productionCountries!
          .map((v) =>
              ProductionCountriesModel(iso31661: v.iso31661!, name: v.name!)
                  .toJson())
          .toList();
    }
    data['release_date'] = releaseDate;
    data['revenue'] = revenue;
    data['runtime'] = runtime;
    if (spokenLanguages != null) {
      data['spoken_languages'] = spokenLanguages!
          .map((v) => SpokenLanguagesModel(
                  englishName: v.englishName!,
                  iso6391: v.iso6391!,
                  name: v.name!)
              .toJson())
          .toList();
    }
    data['status'] = status;
    data['tagline'] = tagline;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    return data;
  }
}
