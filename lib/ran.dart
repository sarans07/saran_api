import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'Model/randomClass.dart';
class ran extends StatefulWidget {
  const ran({super.key});

  @override
  State<ran> createState() => _ranState();
}

class _ranState extends State<ran> {


  late Future<List<Results>> _resultData;



  Future<List<Results>> fetchResultDetails() async{
    var response = await http.get(Uri.parse("https://fakestoreapi.com/products"));
    var data = jsonDecode(response.body);

    return (data as List).map((e) => Results.fromJson(e)).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _resultData = fetchResultDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Results"),
      ),
      body: SafeArea(
        child: FutureBuilder<List<Results>>(
            future: _resultData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Results> list = snapshot.data!;
                return ListView.builder(
                  itemCount: list.length,
                  itemBuilder: (BuildContext context, int index) {
                    var result = list[index];
                    return Column(
                      children: [
                        // Text(result.name!.first.toString()),
                        // Text(result.location!.city.toString()),
                        Text("Rating ${list[index].name!.first.toString()}"),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            }
        )
      ),
    );
  }
}
