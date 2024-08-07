
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/components/Section.dart';
import 'package:fitness/components/daily_tip.dart';
import 'package:fitness/components/image_card_with_internal.dart';
import 'package:fitness/components/main_card_programs.dart';
import 'package:fitness/view/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:url_launcher/url_launcher.dart' as UrlLauncher;



class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final fireStore = FirebaseFirestore.instance;
  List firebaseSliders = [];

  // Updated getSlider to be asynchronous and return a List<Widget>
  Future<List<Widget>> getSlider(BuildContext context) async {
    var data = await fireStore.collection('burning').get();
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
          UrlLauncher.launch(url.toString());
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
      backgroundColor: TColor.white,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome Back,",
                          style: TextStyle(color: TColor.gray, fontSize: 12.sp),
                        ),
                        StreamBuilder(
                            stream: fireStore
                                .collection('users')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .snapshots(),
                            builder: ((context, snapshot) {
                              final data = snapshot.data;
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                      color: Colors.black),
                                );
                              } else {
                                return Text(
                                  "${data!['f_name']} ${data['l_name']}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20.sp,
                                    color: TColor.black,
                                  ),
                                );
                              }
                            })),
                      ],
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfileView(),
                            ),
                          );
                        },
                        icon: const Icon(Icons.person))
                  ],
                ),
                MainCardPrograms(), // MainCard
                FutureBuilder<List<Widget>>(
                  future: getSlider(context),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator(color: Colors.black);
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Display the list of widgets from the future
                      return Section(
                        title: 'Fat burning',
                        horizontalList: snapshot.data!,
                      );
                    }
                  },
                ),

                // Section(
                //   title: 'Abs Generating',
                //   horizontalList: [
                //     ImageCardWithInternal(
                //       image:
                //           'https://firebasestorage.googleapis.com/v0/b/fitnesspal-2744b.appspot.com/o/image005.jpg?alt=media&token=ec588623-21b2-436c-8a49-7d92bb3fe4af',
                //       title: 'Core \nWorkout',
                //       duration: '7 min',
                //     ),
                //     ImageCardWithInternal(
                //       image:
                //           'https://firebasestorage.googleapis.com/v0/b/fitnesspal-2744b.appspot.com/o/image005.jpg?alt=media&token=ec588623-21b2-436c-8a49-7d92bb3fe4af',
                //       title: 'Core \nWorkout',
                //       duration: '7 min',
                //     ),
                //     ImageCardWithInternal(
                //       image:
                //           'https://firebasestorage.googleapis.com/v0/b/fitnesspal-2744b.appspot.com/o/image005.jpg?alt=media&token=ec588623-21b2-436c-8a49-7d92bb3fe4af',
                //       title: 'Core \nWorkout',
                //       duration: '7 min',
                //     ),
                //   ],
                // ),
                Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  padding: const EdgeInsets.only(top: 10.0, bottom: 40.0),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                  ),
                  child: Column(
                    children: <Widget>[
                      Section(
                        title: "Daily Tips",
                        horizontalList: <Widget>[
                          DailyTip(
                              title: "3 Main workout tips",
                              subtitle:
                                  "The American Council on Exercises (ACE) recently surveyed 3,000 ACE-certificated personal trainers about the best!",
                              image:
                                  "https://images.pexels.com/photos/3289711/pexels-photo-3289711.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500&fbclid=IwAR3Ab90Q9LjhoAfHKlsjTaFuddkf8QyEL-dgJujLT8_Y_xdzT_RY3gdh9Qc"),
                          DailyTip(
                              title: "2 Main workout tips",
                              subtitle:
                                  "The American Council on Exercises (ACE) recently surveyed 3,000 ACE-certificated personal trainers about the best!",
                              image:
                                  "https://watermark.lovepik.com/photo/20211124/large/lovepik-gym-exercise-male-warm-up-picture_500910761.jpg?fbclid=IwAR32A1OcHIXYdFmRyZqDjH5dBZH0Ju_bh6eB4Qe2Ix-fG1UdKwV3dCB-HCI"),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
