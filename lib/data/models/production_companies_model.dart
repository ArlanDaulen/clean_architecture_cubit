import 'package:clean_architecture_cubit/domain/entities/production_companies.dart';

class ProductionCompaniesModel extends ProductionCompanies {
  ProductionCompaniesModel({
    required int id,
    required String logoPath,
    required String name,
    required String originCountry,
  }) : super(
          id: id,
          logoPath: logoPath,
          name: name,
          originCountry: originCountry,
        );

  ProductionCompaniesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    logoPath = json['logo_path'];
    name = json['name'];
    originCountry = json['origin_country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    data['origin_country'] = originCountry;
    return data;
  }
}
