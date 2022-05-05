import 'package:equatable/equatable.dart';

class BelongsToCollection extends Equatable {
  int? id;
  String? name;
  String? posterPath;
  String? backdropPath;

  BelongsToCollection({this.id, this.name, this.posterPath, this.backdropPath});

  @override
  List<Object?> get props => [
        id,
        name,
        posterPath,
        backdropPath,
      ];

}
