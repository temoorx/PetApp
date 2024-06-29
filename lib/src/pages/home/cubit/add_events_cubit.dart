import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'add_events_state.dart';
part 'add_events_cubit.freezed.dart';

class AddEventsCubit extends Cubit<AddEventsState> {
  AddEventsCubit() : super(AddEventsState.initial());
  TextEditingController eventNameController = TextEditingController();
  TextEditingController eventDescriptionController = TextEditingController();
  TextEditingController eventInstructionController = TextEditingController();

  Future<void> addEvent() async {
    emit(AddEventsState.loading());
    try {
      await FirebaseFirestore.instance.collection('events').add({
        'name': eventNameController.text,
        'description': eventDescriptionController.text,
        'createdAt': FieldValue.serverTimestamp(),
        'instructions': eventInstructionController.text,
      }).then((value) {
        emit(AddEventsState.loaded());
      });
      eventNameController.clear();
      eventDescriptionController.clear();
    } catch (e) {
      emit(AddEventsState.error(e.toString()));
    }
  }
}
