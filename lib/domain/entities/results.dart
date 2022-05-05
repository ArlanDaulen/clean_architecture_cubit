import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'results.g.dart';

@HiveType(typeId: 0)
class Results extends Equatable {
  @HiveField(0)
  bool? adult;
  @HiveField(1)
  String? backdropPath;
  @HiveField(2)
  List<int>? genreIds;
  @HiveField(3)
  int? id;
  @HiveField(4)
  String? originalLanguage;
  @HiveField(5)
  String? originalTitle;
  @HiveField(6)
  String? overview;
  @HiveField(7)
  double? popularity;
  @HiveField(8)
  String? posterPath;
  @HiveField(9)
  String? releaseDate;
  @HiveField(10)
  String? title;
  @HiveField(11)
  bool? video;
  @HiveField(12)
  num? voteAverage;
  @HiveField(13)
  int? voteCount;

  Results(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalLanguage,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount
      ];
}
