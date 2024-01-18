import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;

import 'Model/BoardClass.dart';
class board extends StatefulWidget {
  const board({super.key});

  @override
  State<board> createState() => _boardState();
}

class _boardState extends State<board> {
  
  Future<Board> fetchBoardDetails() async{
   var resp = await http.get(Uri.parse("https://www.boredapi.com/api/activity"));
   return Board.fromJson(jsonDecode(resp.body));
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
        title: Text("Board Details"),
      ),
      body: SafeArea(
        child: Center(
          child: FutureBuilder(
              future: fetchBoardDetails(),
              builder: (context, snapshot) {
                if (snapshot.hasData){
                  return Column(
                    children: [
                      Text(snapshot.data!.activity.toString()),
                      Text(snapshot.data!.type.toString()),
                      Text(snapshot.data!.participants.toString()),
                      Text(snapshot.data!.price.toString()),
                      Text(snapshot.data!.link.toString()),
                      Text(snapshot.data!.key.toString()),
                      Text(snapshot.data!.accessibility.toString()),

                    ],
                  );
                } else if(snapshot.hasError){
                  return Text('${snapshot.hasError}');
                }
                return const CircularProgressIndicator();
              }
          ),
        ),
      ),
    );
  }
}
