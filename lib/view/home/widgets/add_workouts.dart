
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/components/make_input.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


class AddWorkouts extends StatefulWidget {
  const AddWorkouts({super.key});

  @override
  _AddWorkoutsState createState() => _AddWorkoutsState();
}

class _AddWorkoutsState extends State<AddWorkouts> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController imageController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController urlController = TextEditingController();
  String? collection;
  String? hintText = 'Choose workout type';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryColor,
      appBar: AppBar(
          backgroundColor: TColor.secondaryColor,
          elevation: 0.0,
          title: const Text("Add Workout"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            iconSize: 28.0,
            onPressed: () {
              Navigator.pop(context);
            },
          )),
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: TColor.secondaryColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40.0),
                  bottomRight: Radius.circular(40.0),
                ),
              ),
              child: const Row(
                children: [
                  Flexible(
                    child: Center(
                      child: Text(
                        'Enter Details',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MakeInput(
                        label: 'Title',
                        obscureText: false,
                        controllerID: titleController,
                      ),
                      MakeInput(
                        label: 'Image of the Banner',
                        obscureText: false,
                        controllerID: imageController,
                      ),
                      MakeInput(
                        label: 'Duration',
                        obscureText: false,
                        controllerID: timeController,
                      ),
                      MakeInput(
                        label: 'Url for tutorial',
                        obscureText: false,
                        controllerID: urlController,
                      ),
                      DropdownButton(
                          hint:  Text( hintText!, style: const TextStyle( fontSize: 20.0, fontWeight: FontWeight.w700,color: Colors.black87,)),
                          items:
                          const [
                            DropdownMenuItem( value: 'Loose',
                              child: Text( 'Loose weight', style: TextStyle( fontSize: 15.0, fontWeight: FontWeight.w700,color: Colors.black87,)
                              ),
                            ),

                            DropdownMenuItem( value: 'Maintain',
                              child: Text( 'Maintain weight', style: TextStyle( fontSize: 15.0, fontWeight: FontWeight.w700,color: Colors.black87,)
                              ),
                            ),

                            DropdownMenuItem( value: 'Gain',
                              child: Text( 'Gain weight', style: TextStyle( fontSize: 15.0, fontWeight: FontWeight.w700,color: Colors.black87,)
                              ),
                            ),


                          ], onChanged: (String? value){
                        setState(() {
                          collection = value;
                          hintText = value;
                        });
                      }),
                      const SizedBox(height: 10,),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: TColor.secondaryColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40.0),
                  topRight: Radius.circular(40.0),
                ),
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                  MaterialStateProperty.all(TColor.secondaryColor),
                ),
                onPressed: () async {

                  if(collection == null || collection!.isEmpty){
                    showTopSnackBar(
                      Overlay.of(context),
                      const CustomSnackBar.error(
                        message: 'Choose workout type',
                      ),
                    );
                  }

                  try {
                    final data = FirebaseFirestore.instance
                        .collection(collection!)
                        .doc();
                    await data.set({
                      'title': titleController.text,
                      'image': imageController.text,
                      'time': timeController.text,
                      'url':  urlController.text,
                    }).then((value) {
                      showTopSnackBar(
                          Overlay.of(context),
                          const CustomSnackBar.success(
                            message: "Expense Added Successfully",
                          ));

                      titleController.clear();
                      imageController.clear();
                      timeController.clear();
                      urlController.clear();
                      collection = null;
                    });
                  } catch (e) {
                    showTopSnackBar(
                      Overlay.of(context),
                      CustomSnackBar.error(
                        message: e.toString(),
                      ),
                    );
                  }
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.add_circle_outline,
                      color: Colors.white,
                      size: 40.0,
                    ),
                    Text(
                      'Confirm Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}