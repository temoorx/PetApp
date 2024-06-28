part of 'events_bloc.dart';

@freezed
class EventsState with _$EventsState {
  const factory EventsState.initial() = Initial;
  const factory EventsState.loading() = Loading;
  const factory EventsState.loaded(List<DocumentSnapshot> events) = Loaded;
  const factory EventsState.error(String message) = Error;
}
