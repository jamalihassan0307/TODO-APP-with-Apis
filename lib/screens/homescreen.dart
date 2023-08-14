import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/ToDoModel.dart';
import 'package:flutter_application_1/utill/Alert_Dialog.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:shimmer/shimmer.dart';
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
  Future<void> delete(String id) async {
    try {
      print("id${id}");
      var uri = Uri.parse("https://api.nstack.in/v1/todos/$id");
      var response =
          await http.delete(uri, headers: {"accept": "application/json"});
      print("response.statusCode${response.statusCode}");
      if (response.statusCode == 200) {
        // Assuming 204 is the correct status code for successful deletion
        print("Delete successful");
        setState(() {
          // Update your UI here if needed
        });
      } else {
        print("Error in delete");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> updatestatus(
      String id, String title, String discription, bool status) async {
    var url = Uri.parse("https://api.nstack.in/v1/todos/$id");
    try {
      Map<String, dynamic> body1 = {
        "_id": id.toString(),
        "title": title.toString(),
        "description": discription.toString(),
        "is_completed": "${status.toString()}"
      };
      print("map ${body1["is_completed"]}");
      var response = await http.put(url, body: body1);
      print("response.statusCode: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Update successful");
        refreshData();
        setState(() {
          // Update your UI here if needed
        });
      } else {
        print("Error in update");
      }
    } catch (e) {
      print("Error: $e");
      print("2");
    }
  }

  Future<ToDoModel> getdata() async {
    try {
      var response = await http.get(
        Uri.parse("https://api.nstack.in/v1/todos?page=1&limit=10"),
        headers: {"accept": "application/json"},
      );

      var data = jsonDecode(response.body);

      return ToDoModel.fromJson(data); // Replace with your model parsing logic
    } catch (e) {
      print("Error in get data: $e");
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
                onTap: () {
                  refreshData();
                },
                child: Icon(Icons.refresh)),
          )
        ],
        centerTitle: true,
      ),
      backgroundColor: AppTheme.bgcolor,
      body: FutureBuilder<ToDoModel>(
          future: fetchData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Shimmer.fromColors(
                  baseColor: Colors.green.shade100,
                  highlightColor: Colors.grey.shade200,
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                          padding: EdgeInsets.all(10.0),
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
                                        value: false,
                                        splashRadius: 30,
                                        onChanged: (value) {}),
                                    Container(
                                      height: height * 0.02,
                                      width: width * 0.5,
                                    )
                                  ],
                                ),
                              )));
                    },
                  ));
            } else if (snapshot.hasError) {
              return Center(child: Text("An error occurred."));
            } else if (!snapshot.hasData || snapshot.data!.items!.isEmpty) {
              return Center(child: Text("No items available."));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.items!.length,
                itemBuilder: (BuildContext context, int index) {
                  var data = snapshot.data!.items![index];
                  return Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Slidable(
                        endActionPane:
                            ActionPane(motion: StretchMotion(), children: [
                          SlidableAction(
                            onPressed: (context) {
                              print("object1");
                              // updatestatus(
                              //             data.sId!,
                              //             data.title!,
                              //             data.description!,
                              //             value!,
                              //           );
                              // delete(
                              //   snapshot.data!.items![index].sId.toString(),
                              // );
                            },
                            icon: Icons.edit,
                            backgroundColor: Colors.green,
                          ),
                          SlidableAction(
                            onPressed: (context) {
                              print("object2");
                              delete(
                                snapshot.data!.items![index].sId.toString(),
                              );
                            },
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
                                      value: snapshot
                                          .data!.items![index].isCompleted,
                                      splashRadius: 30,
                                      onChanged: (value) {
                                        updatestatus(
                                          data.sId!,
                                          data.title!,
                                          data.description!,
                                          value!,
                                        );
                                        setState(() {
                                          print("object");
                                        });
                                      }),
                                  Text(
                                    snapshot.data!.items![index].title
                                        .toString(),
                                    // snapshot.data!.items![index].title.toString(),
                                    style: TextStyle(fontSize: 20),
                                  ),
                                ],
                              ),
                            )),
                      ));
                },
              );
            }
          }),
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
