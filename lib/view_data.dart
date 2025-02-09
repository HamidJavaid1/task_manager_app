import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager_app/update_record.dart';

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  List userdata = [];
  bool isLoading = true;
  bool hasError = false;

  Future<void> delrecord(String id) async {
    String uri = "http://10.0.2.2/task_manager_api/delete_data.php";

    try {
      var res = await http.post(Uri.parse(uri), body: {"id": id});
      var response = jsonDecode(res.body);

      if (response["success"] == "true") {
        setState(() {
          userdata.removeWhere((element) => element["uid"] == id);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Record deleted successfully."),
            backgroundColor: Colors.green,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Failed to delete record."),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error deleting record: $e"),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> getRecord() async {
    String uri = "http://10.0.2.2/task_manager_api/view_data.php";

    try {
      var response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        setState(() {
          userdata = jsonDecode(response.body);
          isLoading = false;
        });
      } else {
        setState(() {
          hasError = true;
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      print("Error fetching data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    getRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text("View Data"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : hasError
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Failed to load data.",
                        style: TextStyle(fontSize: 18, color: Colors.red),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: getRecord,
                        child: const Text("Retry"),
                      )
                    ],
                  ),
                )
              : userdata.isEmpty
                  ? const Center(
                      child: Text(
                        "No data available.",
                        style: TextStyle(fontSize: 18),
                      ),
                    )
                  : ListView.builder(
                      itemCount: userdata.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => UpdateRecord(
                                        userdata[index]["uname"],
                                        userdata[index]["uemail"],
                                        userdata[index]["upassword"])),
                              );
                            },
                            title: Text(
                              userdata[index]["uname"],
                              style: const TextStyle(fontSize: 20),
                            ),
                            subtitle: Text(
                              userdata[index]["uemail"],
                            ),
                            trailing: IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  delrecord(userdata[index]["uid"]);
                                }),
                          ),
                        );
                      },
                    ),
    );
  }
}
