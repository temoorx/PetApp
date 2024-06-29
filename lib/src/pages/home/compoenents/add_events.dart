import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_app_test/src/components/text_field_component.dart';
import 'package:your_app_test/src/pages/sign_in/components/primary_button.dart';
import 'package:your_app_test/src/theme/palette.dart';

import 'package:your_app_test/src/pages/home/cubit/add_events_cubit.dart';

@RoutePage()
class AddEventScreen extends StatelessWidget {
  const AddEventScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Palette.white,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Palette.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Palette.white,
        title: Text('Add Event', style: TextStyle(color: Palette.black)),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: BlocListener<AddEventsCubit, AddEventsState>(
          listener: (context, state) => state.maybeWhen(
            orElse: () {
              return null;
            },
            loaded: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Event saved successfully")),
              );
              Navigator.of(context).pop();
              return null;
            },
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error saving event")),
              );
              return null;
            },
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldComponent(
                isLabel: true,
                label: "Event Name",
                controller: context.read<AddEventsCubit>().eventNameController,
                hintText: "Team Building Event",
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              TextFormFieldComponent(
                isLabel: true,
                label: "Event Description",
                controller:
                    context.read<AddEventsCubit>().eventDescriptionController,
                hintText: "Event Description",
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              TextFormFieldComponent(
                isLabel: true,
                label: "Instructions",
                controller:
                    context.read<AddEventsCubit>().eventInstructionController,
                hintText: "Event Instructions",
                onChanged: (value) {},
              ),
              SizedBox(height: 20),
              PrimaryButton(
                onPressed: () {
                  if (context
                          .read<AddEventsCubit>()
                          .eventNameController
                          .text
                          .isEmpty ||
                      context
                          .read<AddEventsCubit>()
                          .eventDescriptionController
                          .text
                          .isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Please fill all fields")),
                    );
                  } else {
                    context.read<AddEventsCubit>().addEvent();
                  }
                },
                child: Text('Save Event'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
