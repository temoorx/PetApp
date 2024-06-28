import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'events_bloc.freezed.dart';
part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  EventsBloc() : super(const EventsState.initial());

  Stream<EventsState> mapEventToState(EventsEvent event) async* {
    yield* event.map(
      fetchEvents: (e) async* {
        yield const EventsState.loading();
        try {
          final events = await _fetchEventsFromFirestore();
          yield EventsState.loaded(events);
        } catch (e) {
          yield EventsState.error('Failed to fetch events');
        }
      },
    );
  }

  Future<List<DocumentSnapshot>> _fetchEventsFromFirestore() async {
    // Initialize Firebase app if not already initialized
    await Firebase.initializeApp();

    // Fetch events from Firestore
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('events')
        .orderBy('createdAt', descending: true)
        .get();

    return querySnapshot.docs;
  }
}
