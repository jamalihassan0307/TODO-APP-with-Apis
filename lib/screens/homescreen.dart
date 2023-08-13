import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/ToDoModel.dart';
import 'package:flutter_application_1/utill/Alert_Dialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import '../utill/color.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<ToDoModel> fetchData;

  @override
  void initState() {
    super.initState();
    fetchData = getdata();
  }

  bool value1 = false;
  delect(BuildContext context) {}

  Future<ToDoModel> getdata() async {
    try {
      var response = await http.get(
        Uri.parse("https://api.nstack.in/v1/todos?page=1&limit=10"),
        headers: {"accept": "application/json"},
      );

      var data = jsonDecode(response.body);

      return ToDoModel.fromJson(data); // Replace with your model parsing logic
    } catch (e) {
      print("Error: $e");
      throw e;
    }
  }

  createshowalert() {
    showDialog(
      context: context,
      builder: (context) {
        return Dilogbox(); // Replace with your AlertDialog implementation
      },
    );
  }

  Future<void> refreshData() async {
    setState(() {
      fetchData = getdata();
    });
  }

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
        centerTitle: true,
      ),
      backgroundColor: AppTheme.bgcolor,
      body: RefreshIndicator(
        onRefresh: refreshData,
        child: FutureBuilder<ToDoModel>(
            future: fetchData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text("An error occurred."));
              } else if (!snapshot.hasData || snapshot.data!.items!.isEmpty) {
                return Center(child: Text("No items available."));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.items!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: EdgeInsets.all(28.0),
                        child: Slidable(
                          endActionPane:
                              ActionPane(motion: StretchMotion(), children: [
                            SlidableAction(
                              onPressed: delect,
                              icon: Icons.edit,
                              backgroundColor: Colors.green,
                            ),
                            SlidableAction(
                              onPressed: delect,
                              icon: Icons.delete,
                              backgroundColor: Colors.red,
                            ),
                          ]),
                          child: Container(
                              height: height * 0.09,
                              color: AppTheme.primarycolor,
                              alignment: Alignment.centerLeft,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(left: 28.0),
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
                                      snapshot.data!.items![index].title
                                          .toString(),
                                      // snapshot.data!.items![index].title.toString(),
                                      style: TextStyle(fontSize: 25),
                                    ),
                                  ],
                                ),
                              )),
                        ));
                  },
                );
              }
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          createshowalert();
        },
        backgroundColor: AppTheme.primarycolor,
        child: Icon(Icons.add),
      ),
    );
  }
}
