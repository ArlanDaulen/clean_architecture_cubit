import 'package:clean_architecture_cubit/domain/entities/spoken_languages.dart';

class SpokenLanguagesModel extends SpokenLanguages {
  SpokenLanguagesModel({
    required String englishName,
    required String iso6391,
    required String name,
  }) : super(
          englishName: englishName,
          iso6391: iso6391,
          name: name,
        );
  SpokenLanguagesModel.fromJson(Map<String, dynamic> json) {
    englishName = json['english_name'];
    iso6391 = json['iso_639_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['english_name'] = englishName;
    data['iso_639_1'] = iso6391;
    data['name'] = name;
    return data;
  }
}
