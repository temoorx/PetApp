part of 'add_events_cubit.dart';

@freezed
class AddEventsState with _$AddEventsState {
  const factory AddEventsState.initial() = _Initial;
  const factory AddEventsState.loading() = _Loading;
  const factory AddEventsState.error(String message) = _Error;
  const factory AddEventsState.loaded() = _Loaded;
}
