
import 'package:clean_architecture_cubit/domain/entities/belongs_to_collection.dart';

class BelongsToCollectionModel extends BelongsToCollection {
  BelongsToCollectionModel({
    required int id,
    required String name,
    required String posterPath,
    required String backdropPath,
  }) : super(
          id: id,
          name: name,
          posterPath: posterPath,
          backdropPath: backdropPath,
        );

  BelongsToCollectionModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    posterPath = json['poster_path'];
    backdropPath = json['backdrop_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['poster_path'] = posterPath;
    data['backdrop_path'] = backdropPath;
    return data;
  }
}
