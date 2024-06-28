import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_app_test/src/pages/home/bloc/events_bloc.dart';

class EventsTab extends StatelessWidget {
  const EventsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        return _buildUI(context, state);
      },
    );
  }

  Widget _buildUI(BuildContext context, EventsState state) {
    return state.maybeWhen(
      orElse: () {
        context.read<EventsBloc>().mapEventToState(EventsEvent.fetchEvents());
        return Center(child: Text('No events found'));
      },
      loading: () => Center(child: CircularProgressIndicator()),
      loaded: (events) {
        if (events.isEmpty) {
          return Center(child: Text('No events found'));
        } else {
          return ListView.builder(
            itemCount: events.length,
            itemBuilder: (context, index) {
              final doc = events[index];
              Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
              return ListTile(
                title: Text(data['name'],
                    style: TextStyle(fontSize: 20, color: Colors.white)),
                subtitle: Text(data['description'],
                    style: TextStyle(fontSize: 10, color: Colors.white)),
              );
            },
          );
        }
      },
      error: (message) => Center(child: Text(message)),
    );
  }
}
