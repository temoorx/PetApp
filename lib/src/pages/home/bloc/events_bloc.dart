import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:your_app_test/src/pages/home/bloc/events_event.dart';
import 'package:your_app_test/src/pages/home/bloc/events_state.dart';

import 'package:bloc/bloc.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  StreamSubscription? _eventsSubscription;

  EventsBloc() : super(EventsLoading()) {
    on<LoadEvents>((event, emit) {
      _eventsSubscription?.cancel();
      _eventsSubscription = FirebaseFirestore.instance
          .collection('events')
          .orderBy('createdAt', descending: true)
          .snapshots()
          .listen((snapshot) {
        if (snapshot.docs.isEmpty) {
          emit(EventsEmpty());
        } else {
          List<Map<String, dynamic>> events =
              snapshot.docs.map((doc) => doc.data()).toList();
          emit(EventsLoaded(events));
        }
      }, onError: (error) {
        emit(EventsError('Error loading events'));
      });
    });
  }

  @override
  Future<void> close() {
    _eventsSubscription?.cancel();
    return super.close();
  }
}
