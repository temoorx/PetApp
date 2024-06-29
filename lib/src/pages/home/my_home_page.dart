import 'package:auto_route/auto_route.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:your_app_test/src/components/text_field_component.dart';
import 'package:your_app_test/src/constant/shared_preference_constants.dart';
import 'package:your_app_test/src/di/injector.dart';
import 'package:your_app_test/src/pages/home/compoenents/evens_tab.dart';
import 'package:your_app_test/src/pages/is_gradient_background_component/is_gradient_background_component.dart';
import 'package:your_app_test/src/pages/sign_in/components/primary_button.dart';
import 'package:your_app_test/src/route/app_router.dart';
import 'package:your_app_test/src/theme/palette.dart';
import 'package:your_app_test/src/util/shared_preferences_util.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _eventNameController = TextEditingController();
  final TextEditingController _eventDescriptionController =
      TextEditingController();

  Future<void> _saveEvent() async {
    if (_eventNameController.text.isEmpty ||
        _eventDescriptionController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill out all fields')),
      );
      return;
    }

    try {
      await FirebaseFirestore.instance.collection('events').add({
        'name': _eventNameController.text,
        'description': _eventDescriptionController.text,
        'createdAt': FieldValue.serverTimestamp(),
      });
      _eventNameController.clear();
      _eventDescriptionController.clear();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Event saved successfully')),
      );
    } catch (e) {
      debugPrint('Error saving event: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving event')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Palette.white,
        appBar: AppBar(
          title: Text('Event App'),
          actions: [
            IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {
                getIt
                    .get<SharedPreferencesUtil>()
                    .removeValue(SharedPreferenceConstants.userId)
                    .then((value) async => await context.router.pushAndPopUntil(
                        predicate: (route) => false, const SignInRoute()));
              },
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(
                  child: Icon(
                Icons.add,
                color: Colors.white,
              )),
              Tab(
                  child: Icon(
                Icons.list,
                color: Colors.white,
              )),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextFormFieldComponent(
                    controller: _eventNameController,
                    hintText: "Event Name",
                    onChanged: (value) {},
                  ),
                  TextFormFieldComponent(
                    controller: _eventDescriptionController,
                    hintText: "Event Description",
                    onChanged: (value) {},
                  ),
                  SizedBox(height: 20),
                  PrimaryButton(
                    onPressed: _saveEvent,
                    child: Text('Save Event'),
                  ),
                ],
              ),
            ),
            EventsTab(),
          ],
        ),
      ),
    );
  }
}

// class EventsTab extends StatelessWidget {
//   const EventsTab({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance
//           .collection('events')
//           .orderBy('createdAt', descending: true)
//           .snapshots(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(child: CircularProgressIndicator());
//         }

//         if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//           return Center(child: Text('No events found'));
//         }

//         return ListView(
//           children: snapshot.data!.docs.map((doc) {
//             Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
//             return ListTile(
//               title: Text(data['name'],
//                   style: TextStyle(fontSize: 20, color: Colors.white)),
//               subtitle: Text(data['description'],
//                   style: TextStyle(fontSize: 10, color: Colors.white)),
//             );
//           }).toList(),
//         );
//       },
//     );
//   }
// }
