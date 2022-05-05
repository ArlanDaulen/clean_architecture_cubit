import 'package:equatable/equatable.dart';

class Genres extends Equatable {
  int? id;
  String? name;

  Genres({this.id, this.name});

  @override
  List<Object?> get props => [id, name];
}
