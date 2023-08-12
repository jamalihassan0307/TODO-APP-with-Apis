import 'package:flutter/material.dart';
import 'package:flutter_application_1/utill/color.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

bool value1 = false;
delect(BuildContext context) {
  print("object");
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primarycolor,
        title: Text(
          "T O   D O ",
          style: TextStyle(fontSize: 30),
        ),
        toolbarHeight: height * 0.1,
        centerTitle: true,
      ),
      backgroundColor: AppTheme.bgcolor,
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Slidable(
          endActionPane: ActionPane(motion: StretchMotion(), children: [
            SlidableAction(
              onPressed: delect,
              icon: Icons.delete,
              backgroundColor: Colors.red,
            )
          ]),
          child: Container(
              height: height * 0.09,
              color: AppTheme.primarycolor,
              alignment: Alignment.centerLeft,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 28.0),
                child: Row(
                  children: [
                    Checkbox(
                        activeColor: Colors.grey.shade600,
                        checkColor: Colors.white,
                        value: value1,
                        splashRadius: 30,
                        onChanged: (value) {
                          setState(() {
                            value1 = value!;
                          });
                        }),
                    Text(
                      "Make time table",
                      style: TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
