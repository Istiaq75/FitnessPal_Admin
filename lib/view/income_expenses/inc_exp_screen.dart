
import 'package:fitness/view/drawer.dart';
import 'package:fitness/view/packages/add_packages.dart';
import 'package:fitness/view/packages/view_packages.dart';
import 'package:flutter/material.dart';

import '../../common/colo_extension.dart';
import 'add_expense.dart';
import 'add_income.dart';
import 'view_expense.dart';
import 'view_income.dart';

class IncExpScreen extends StatefulWidget {
  @override
  _IncExpScreenState createState() => _IncExpScreenState();
}

class _IncExpScreenState extends State<IncExpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.primaryColor,
      appBar: AppBar(
        backgroundColor: TColor.secondaryColor,
        elevation: 0.0,
        title: const Text('Revenue & Expenses'),
      ),
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.grey[350],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Image.asset( 'assets/images/increase_presentation_Profit_growth-512.png', width: 84.0,),

                      const Text('Incomes', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),),

                      ElevatedButton( style: ButtonStyle( backgroundColor: MaterialStateProperty.all(TColor.secondaryColor),),
                        onPressed: () {
                        Navigator.push( context, MaterialPageRoute( builder: (context) => ViewIncome()));
                        },

                        child: const Row( mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                            Icon( Icons.list_alt, color: Colors.white, size: 40.0,),

                            Text( 'View Incomes', style: TextStyle( fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                          ],
                        ),
                      ),
                      ElevatedButton( style: ButtonStyle( backgroundColor: MaterialStateProperty.all(TColor.secondaryColor),),
                        onPressed: () {
                          Navigator.push( context, MaterialPageRoute( builder: (context) => AddIncome(),),);
                        },

                        child: const Row( mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Icon( Icons.add_circle_outline,  color: Colors.white, size: 40.0,),
                            Text( 'Add New Incomes', style: TextStyle( fontSize: 20,  fontWeight: FontWeight.w700,  color: Colors.white,),),

                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.grey[350],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Image.asset(
                        'assets/images/decrease_presentation_down_loss-512.png',
                        width: 84.0,
                      ),
                      const Text(
                        'Expenses',
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20.0),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(TColor.secondaryColor),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ViewExpense(),
                            ),
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(
                              Icons.list_alt,
                              color: Colors.white,
                              size: 40.0,
                            ),
                            Text(
                              'View Expenses',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(TColor.secondaryColor),
                        ),
                        // shape: RoundedRectangleBorder(
                        //   borderRadius: BorderRadius.circular(18.0),
                        // ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddExpense(),
                            ),
                          );
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
                              'Add New Expenses',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Card(
                  elevation: 5,
                  margin: const EdgeInsets.all(8.0),
                  color: Colors.grey[350],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      Image.asset( 'assets/images/subscription.png', width: 84.0,),

                      const Text('Packages', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.0),),

                      ElevatedButton( style: ButtonStyle( backgroundColor: MaterialStateProperty.all(TColor.secondaryColor),),
                        onPressed: () {
                          Navigator.push( context, MaterialPageRoute( builder: (context) => ViewPackages()));
                        },

                        child: const Row( mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
                          Icon( Icons.list_alt, color: Colors.white, size: 40.0,),

                          Text( 'View Incomes', style: TextStyle( fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white,),),
                        ],
                        ),
                      ),
                      ElevatedButton( style: ButtonStyle( backgroundColor: MaterialStateProperty.all(TColor.secondaryColor),),
                        onPressed: () {
                          Navigator.push( context, MaterialPageRoute( builder: (context) => AddPackages(),),);
                        },

                        child: const Row( mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[

                            Icon( Icons.add_circle_outline,  color: Colors.white, size: 40.0,),
                            Text( 'Add New Incomes', style: TextStyle( fontSize: 20,  fontWeight: FontWeight.w700,  color: Colors.white,),),

                          ],
                        ),
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