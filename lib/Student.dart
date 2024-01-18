import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'Model/StudentClass.dart';
class student extends StatefulWidget {
  const student({super.key});

  @override
  State<student> createState() => _studentState();
}

class _studentState extends State<student> {

  Future<List<Student>> fetchStudentDetails() async {
    var res = await http.get(Uri.parse("http://universities.hipolabs.com/search?country=United+States"));
    print(res.body);
    var studentname =(jsonDecode(res.body));
    return (studentname as List).map((e) => Student.fromJson(e)).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Student Details"),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<Student>>(
              future: fetchStudentDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  return  ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                            leading: const Icon(Icons.list),
                            trailing: const Text(
                              "GFG",
                              style: TextStyle(color: Colors.green, fontSize: 15),
                            ),
                            title: Text(snapshot.data![index].domains.toString()));
                      });

                }else if(snapshot.hasError){
                  return Text('${snapshot.hasError}');
                }
                return CircularProgressIndicator();
              }
          ),
        ),
      ),
    );
  }
}
