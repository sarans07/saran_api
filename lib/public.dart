import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'Model/PublicClass.dart';
class public extends StatefulWidget {
  const public({super.key});

  @override
  State<public> createState() => _publicState();
}

class _publicState extends State<public> {

  Future<List<Entries>> fetchEntriesDetails()async{
    var res = await http.get(Uri.parse("https://api.publicapis.org/entries"));
    var publicdetails = (jsonDecode(res.body)["entries"]);
    return (publicdetails as List).map((e) => Entries.fromJson(e)).toList();
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
        title: Text("Public Details"),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder<List<Entries>>(
              future: fetchEntriesDetails(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index){
                        return Card(
                          child: ListTile(
                            title: Column(
                              children: [
                                Text(snapshot.data![index].api.toString()),
                                Text(snapshot.data![index].description.toString()),
                                Text(snapshot.data![index].auth.toString()),
                                Text(snapshot.data![index].https.toString()),
                                Text(snapshot.data![index].cors.toString()),
                                Text(snapshot.data![index].link.toString()),
                                Text(snapshot.data![index].category.toString()),
                              ],
                            ),
                          
                          ),
                        );
                      }
                  );
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
