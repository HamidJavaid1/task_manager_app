import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class UpdateRecord extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  UpdateRecord(this.name, this.email, this.password);

  @override
  State<UpdateRecord> createState() => _UpdateRecordState();
}

class _UpdateRecordState extends State<UpdateRecord> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool _obscureText = true;

  // This method will refresh the state when called
  void refreshCallback() {
    setState(() {
      nameController.text = "Updated Name"; // Replace with actual updated data
      emailController.text = "updated@example.com";
      passwordController.text = "newpassword";
    });
  }

  Future<void> updateRecord() async {
    try {
      String uri = "http://10.0.2.2/task_manager_api/update_data.php";
      var response = await http.post(Uri.parse(uri), body: {
        "name": nameController.text,
        "email": emailController.text,
        "password": passwordController.text,
      });

      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['success'] == true) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Success"),
              content: Text("Record updated successfully!"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    refreshCallback(); // Call the refresh callback
                    Navigator.pop(context, true);
                  },
                  child: Text("OK"),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Error"),
              content:
                  Text(jsonResponse['message'] ?? "Failed to update record."),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                ),
              ],
            ),
          );
        }
      } else {
        throw Exception("Failed to update record");
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text("An error occurred: $e"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text("OK"),
            ),
          ],
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    emailController.text = widget.email;
    passwordController.text = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Update Record"),
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter your name"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter your Email"),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                controller: passwordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Enter your password"),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  updateRecord();
                },
                child: Text("Update", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
