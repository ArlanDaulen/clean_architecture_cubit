import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;
  Failure(this.message, [List props = const <dynamic>[]]);
}

class ServerFailure extends Failure {
  ServerFailure(String message) : super(message);

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failure {
  CacheFailure(String message) : super(message);

  @override
  List<Object?> get props => [message];
}