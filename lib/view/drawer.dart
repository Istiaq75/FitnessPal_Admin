
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/components/custom_darwer_grid.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import 'Authentication/LoginScreen/login_view.dart';


class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  _AppDrawerState createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  final FirebaseAuth auth = FirebaseAuth.instance;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController gymnameController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  final fireStore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250.0,
      child: Drawer(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20.0),
          color: TColor.secondaryColor,
          child: Center(
              child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 25.0),
                width: 100.0,
                height: 100.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: NetworkImage(
                        'https://cdn1.iconfinder.com/data/icons/engineer-construction/512/engineer_worker_avatar_mechanics-256.png'),
                    fit: BoxFit.scaleDown,
                  ),
                ),
              ),
              const SizedBox(height: 10.0),
              Expanded(
                child: Column(
                  children: [
                    StreamBuilder(
                        stream: fireStore
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(
                                  color: Colors.black),
                            );
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final data = snapshot.data;

                            return CustomDG(
                              f_name: data!['f_name'].toString(),
                              l_name: data['l_name'].toString(),
                              gymname: "Fitness Pal",
                            );
                          }
                        }),
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              Text(
                FirebaseAuth.instance.currentUser!.email.toString(),
                style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15.0),
              ),
              const SizedBox(height: 10.0),
              const Text('Update Your Details in Settings!'),
              const SizedBox(height: 10.0),
              const Divider(color: Colors.black),
              IconButton(
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.white,
                  ),
                  onPressed: () => {
                        Alert(
                            context: context,
                            title: "Pofile",
                            content: Column(
                              children: <Widget>[
                                TextField(
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.person),
                                    labelText: 'Your F-Name',
                                  ),
                                  controller: nameController,
                                ),
                                TextField(
                                  decoration: const InputDecoration(
                                    icon: Icon(Icons.home_rounded),
                                    labelText: 'Your L-name',
                                  ),
                                  controller: gymnameController,
                                ),
                              ],
                            ),
                            buttons: [
                              DialogButton(
                                color: TColor.secondaryColor,
                                onPressed: () => {
                                  fireStore
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .update(
                                    {
                                      'f_name': nameController.text,
                                      'l_name': gymnameController.text,
                                    },
                                  ).asStream(),
                                  nameController.clear(),
                                  gymnameController.clear(),
                                  descriptionController.clear(),
                                  Navigator.pop(context)
                                },
                                child: const Text(
                                  'UPDATE',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )
                            ]).show()
                      }),
              const Text(
                'Settings',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
              const Divider(color: Colors.black),
              IconButton(
                icon: const Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                tooltip: 'Log Out of the App',
                onPressed: () => {
                  FirebaseAuth.instance.signOut(),
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginView()),
                      (route) => false)
                },
              ),
              const Text(
                'Log Out',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.0),
              ),
              const Divider(color: Colors.black),
            ],
          )),
        ),
      ),
    );
  }
}