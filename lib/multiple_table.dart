import 'package:flutter/material.dart';

class Multiple_table extends StatefulWidget {
  const Multiple_table({super.key});

  @override
  State<Multiple_table> createState() => _Multiple_tableState();
}

class _Multiple_tableState extends State<Multiple_table> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text("Dashboard"),
        ),
        body: Column(children: [
          Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                  // controller: ,
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Enter your name"),
              ))),
          Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                  // controller: ,
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Enter your email"),
              ))),
          Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                  // controller: ,
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Enter your password"),
              ))),
          Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                  // controller: ,
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Enter your Phone 1"),
              ))),
          Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                  // controller: ,
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Enter your Phone 2"),
              ))),
          Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                  // controller: ,
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Enter your Address 1"),
              ))),
          Container(
              margin: EdgeInsets.all(10),
              child: TextField(
                  // controller: ,
                  decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text("Enter your Address 2"),
              ))),
          Container(
            margin: EdgeInsets.all(10),
            child: Builder(builder: (cntext) {
              return ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Colors.blue), // Set button background color
                ),
                onPressed: () {},
                child: Text("Add", style: TextStyle(color: Colors.white)),
              );
            }),
          )
        ]));
  }
}
