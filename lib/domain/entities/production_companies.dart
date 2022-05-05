import 'package:equatable/equatable.dart';

class ProductionCompanies extends Equatable {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  @override
  List<Object?> get props => [id, logoPath, name, originCountry];
}
