part of 'home_cubit.dart';

@freezed
abstract class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = _Loading;
  const factory HomeState.laoded(List<Results> movies) = _Loaded;
  const factory HomeState.error(String message) = _Error;
}
