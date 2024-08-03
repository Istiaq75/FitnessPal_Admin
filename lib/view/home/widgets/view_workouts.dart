import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/components/Section.dart';
import 'package:fitness/components/image_card_with_internal.dart';
import 'package:fitness/view/drawer.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart' as url_launcher;



class ViewWorkouts extends StatefulWidget {
  const ViewWorkouts({super.key});

  @override
  State<ViewWorkouts> createState() => _ViewWorkoutsState();
}

class _ViewWorkoutsState extends State<ViewWorkouts> {
  final fireStore = FirebaseFirestore.instance;
  List firebaseSliders = [];

  // Updated getSlider to be asynchronous and return a List<Widget>
  Future<List<Widget>> getSlider(BuildContext context, String? type) async {
    var data = await fireStore.collection(type!).get();
    List<Widget> sliderList = [];

    // Process data.docs and create a list of widgets
    for (var doc in data.docs) {
      // Extract relevant data from the document and create a Widget
      // Adjust the logic based on your data structure
      var image = doc['image'];
      var title = doc['title'];
      var time = doc['time'];
      var url = doc['url'];

      var widget = InkWell(
        onTap: () {
          url_launcher.launch(url.toString());
        },
        child: ImageCardWithInternal(
          image: image,
          title: title,
          duration: time,
        ),
      );

      // Add the widget to the list
      sliderList.add(widget);
    }

    return sliderList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryColor,
      appBar: AppBar(
          backgroundColor: TColor.secondaryColor,
          elevation: 0.0,
          title: const Text("View Workouts",style: TextStyle(color: Colors.white),),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios,color: Colors.white),
            iconSize: 28.0,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Column(
          children: [
            Column(
              children: [
                FutureBuilder<List<Widget>>(
                  future: getSlider(context, 'Loose'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Colors.black));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Display the list of widgets from the future
                      return snapshot.data!.isNotEmpty ? Section(
                        title: 'Loose weight',
                        horizontalList: snapshot.data!,
                      ) : const SizedBox();
                    }
                  },
                ),

                FutureBuilder<List<Widget>>(
                  future: getSlider(context, 'Maintain'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Colors.black));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Display the list of widgets from the future
                      return  snapshot.data!.isNotEmpty ? Section(
                        title: 'Maintain weight',
                        horizontalList: snapshot.data!,
                      ) : const SizedBox();
                    }
                  },
                ),

                FutureBuilder<List<Widget>>(
                  future: getSlider(context, 'Gain'),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator(color: Colors.black));
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Display the list of widgets from the future
                      return snapshot.data!.isNotEmpty  ? Section(
                        title: 'Gain weight',
                        horizontalList: snapshot.data!,
                      ) : const SizedBox();
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
