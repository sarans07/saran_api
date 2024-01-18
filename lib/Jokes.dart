import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'Model/jokesClass.dart';

class jokes extends StatefulWidget {
  const jokes({super.key});

  @override
  State<jokes> createState() => _jokesState();
}

class _jokesState extends State<jokes> {
  
  Future<Jokes> fetchJokesDetails()async{
    var response = await http.get(Uri.parse("https://official-joke-api.appspot.com/random_joke"));
    return Jokes.fromJson(jsonDecode(response.body));
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
        title: Text("Jokes"),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
              future: fetchJokesDetails(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.type.toString()),
                      Text(snapshot.data!.setup.toString()),
                      Text(snapshot.data!.punchline.toString()),
                      Text(snapshot.data!.id.toString()),
                    ],
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
