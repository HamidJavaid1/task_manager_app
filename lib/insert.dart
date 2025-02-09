import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager_app/view_data.dart';

class InsertData extends StatefulWidget {
  const InsertData({super.key});

  @override
  State<InsertData> createState() => _InsertDataState();
}

class _InsertDataState extends State<InsertData> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> insertrecord() async {
    if (name.text != "" && email.text != "" && password.text != "") {
      try {
        String uri = "http://10.0.2.2/task_manager_api/insert_record.php";
        var res = await http.post(Uri.parse(uri), body: {
          "name": name.text,
          "email": email.text,
          "password": password.text
        });

        print("Response body: ${res.body}"); // Debug response
        var response = jsonDecode(res.body);

        if (response["success"] == true) {
          _showDialog("Success", "Record inserted successfully!");
          name.clear();
          email.clear();
          password.clear();
        } else {
          _showDialog(
              "Error", response["message"] ?? "Failed to insert record.");
        }
      } catch (e) {
        _showDialog("Exception", "An error occurred: $e");
      }
    } else {
      _showDialog("Warning", "Please fill all fields");
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Insert Data"),
        ),
        body: Column(
          children: [
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                    controller: name,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter your name"),
                    ))),
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                    controller: email,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter your Email"),
                    ))),
            Container(
                margin: EdgeInsets.all(10),
                child: TextField(
                    controller: password,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text("Enter your password"),
                    ))),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.blue), // Set button background color
                ),
                onPressed: () {
                  insertrecord();
                },
                child: Text("Insert", style: TextStyle(color: Colors.white)),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: Builder(builder: (cntext) {
                return ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                        Colors.blue), // Set button background color
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => ViewData()));
                  },
                  child:
                      Text("View Data", style: TextStyle(color: Colors.white)),
                );
              }),
            )
          ],
        ));
  }
}
