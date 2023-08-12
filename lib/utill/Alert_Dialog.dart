import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/utill/color.dart';

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
                  // borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: Colors.black54,
                    width: 2,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(50),
                  borderSide: const BorderSide(
                    color: Colors.red,
                    width: 2,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(50),
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
                enabledBorder: OutlineInputBorder(
                    // borderRadius: BorderRadius.circular(50),

                    ),
                errorBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.all(Radius.circular(50)),
                  borderSide: BorderSide(
                    width: 2,
                    color: Colors.red,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  // borderRadius: BorderRadius.circular(50),
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
            Container(
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
                "sf",
                style: TextStyle(
                  fontSize: 20,
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
