import 'package:clean_architecture_cubit/domain/entities/production_companies.dart';
import 'package:clean_architecture_cubit/domain/entities/production_countries.dart';

class ProductionCountriesModel extends ProductionCountries {
  ProductionCountriesModel({
    required String iso31661,
    required String name,
  }) : super(
          iso31661: iso31661,
          name: name,
        );

  ProductionCountriesModel.fromJson(Map<String, dynamic> json) {
    iso31661 = json['iso_3166_1'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    return data;
  }
}
