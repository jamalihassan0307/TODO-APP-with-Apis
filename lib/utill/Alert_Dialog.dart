import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/utill/color.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

class Dilogbox extends StatelessWidget {
  const Dilogbox({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titlecontroller = TextEditingController();
    TextEditingController discriptioncontroller = TextEditingController();
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    return AlertDialog(
      backgroundColor: AppTheme.primarycolor,
      content: Container(
        height: height * 0.3,
        width: width * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              autofillHints: const [AutofillHints.email],
              onEditingComplete: () => TextInput.finishAutofillContext(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: titlecontroller,
              autofocus: false,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: InputBorder.none,
                filled: true,
                fillColor: AppTheme.primarycolor,
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black54,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                hintText: 'Title',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: width * 0.03,
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                  size: width * 0.047,
                ),
              ),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter your title';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            TextFormField(
              autofillHints: const [AutofillHints.email],
              onEditingComplete: () => TextInput.finishAutofillContext(),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: discriptioncontroller,
              autofocus: false,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                border: InputBorder.none,
                filled: true,
                fillColor: AppTheme.primarycolor,
                labelText: 'Discription',
                labelStyle: TextStyle(
                  color: Colors.black,
                  fontSize: width * 0.035,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.black,
                    width: 2,
                    style: BorderStyle.solid,
                  ),
                ),
                hintText: 'Discription',
                hintStyle: TextStyle(
                  color: Colors.grey,
                  fontSize: width * 0.03,
                ),
                prefixIcon: Icon(
                  Icons.email,
                  color: Colors.black,
                  size: width * 0.047,
                ),
              ),
              validator: (String? value) {
                if (value!.isEmpty) {
                  return 'Please enter your discription';
                }
                return null;
              },
              keyboardType: TextInputType.emailAddress,
            ),
            InkWell(
              onTap: () async {
                var uuid = Uuid().v4();
                var url = Uri.parse("https://api.nstack.in/v1/todos");

                Map<String, String> headers = {
                  "Content-Type": "application/json",
                };

                Map<String, dynamic> body = {
                  "_id": uuid,
                  "title": titlecontroller.text.toString(),
                  "description": discriptioncontroller.text.toString(),
                };

                var response = await http.post(
                  url,
                  headers: headers,
                  body: jsonEncode(body), // Encode the body as JSON
                );

                if (response.statusCode == 200) {
                  print("Data posted successfully!");
                } else {
                  print("Error posting data - ${response.statusCode}");
                  print("Response body: ${response.body}");
                }
                Navigator.pop(context);
              },
              child: Container(
                height: height * 0.04,
                width: width * 0.2,
                decoration: BoxDecoration(
                    color: AppTheme.primarycolor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                      style: BorderStyle.solid,
                    )),
                child: Center(
                    child: Text(
                  "ADD",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
