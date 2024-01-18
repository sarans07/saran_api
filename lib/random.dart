import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:saran_api/Model/randomClass.dart';
class random extends StatefulWidget {
  const random({super.key});

  @override
  State<random> createState() => _randomState();
}

class _randomState extends State<random> {
  Future<List<Name>> fetchNameDetails() async {
    var res = await http.get(Uri.parse("https://randomuser.me/api/?results=5")); // Change the number of results as needed
    print(res.body);
    var responseData = jsonDecode(res.body)["results"] as List;
    return responseData.map<Name>((nameJson) {
      return Name.fromJson(nameJson["name"]);
    }).toList();
  }
  Future<List<Results>> fetchLocationDetails() async {
    var loc = await http.get(Uri.parse("https://randomuser.me/api/?results=5")); // Change the number of results as needed
    //print(loc.body);
    var locData = jsonDecode(loc.body)["0"]["results"] as List;
    return locData.map<Results>((locationJson) {
      return Results.fromJson(locationJson["location"]);
    }).toList();
  }


  Future<List<Results>> fetchResultsDetails() async {
    var ress = await http.get(Uri.parse("http://universities.hipolabs.com/search?country=United+States"));
    print(ress.body);
    var result =(jsonDecode(ress.body)["results"]);
    return (result as List).map((e) => Results.fromJson(e)).toList();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchResultsDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random User"),
      ),
      body: SafeArea(
          child: FutureBuilder<List<Name>>(
            future: fetchNameDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var names = snapshot.data!;
                return ListView.builder(
                  itemCount: names.length,
                  itemBuilder: (BuildContext context, int index) {
                    var name = names[index];
                    return ListTile(
                      title: Column(
                        children: [
                          Text('${name.title}. ${name.first} ${name.last}'),
                          // FutureBuilder<List<Results>>(
                          //   future: fetchLocationDetails(),
                          //   builder: (context, snapshot) {
                          //     if (snapshot.hasData) {
                          //       var locations = snapshot.data!;
                          //       return ListView.builder(
                          //         itemCount: locations.length,
                          //         itemBuilder: (BuildContext context, int index) {
                          //           var location = locations[index];
                          //           return ListTile(
                          //             title: Column(
                          //               children: [
                          //                 Text(location.email.toString()),
                          //               ],
                          //             ),
                          //           );
                          //         },
                          //       );
                          //     } else if (snapshot.hasError) {
                          //       return Text('${snapshot.error}');
                          //     }
                          //     return CircularProgressIndicator();
                          //   },
                          // ),
                          // FutureBuilder<List<Results>>(
                          //     future: fetchResultsDetails(),
                          //     builder: (context, snapshot) {
                          //       if (snapshot.hasData){
                          //         return  ListView.builder(
                          //             itemCount: snapshot.data!.length,
                          //             itemBuilder: (BuildContext context, int index) {
                          //               return Column(
                          //                     children: [
                          //                       Text(snapshot.data![index].name!.first.toString()),
                          //                     ],
                          //               );
                          //             });
                          //
                          //       }else if(snapshot.hasError){
                          //         return Text('${snapshot.hasError}');
                          //       }
                          //       return CircularProgressIndicator();
                          //     }
                          // ),
                        ],
                      ),
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return CircularProgressIndicator();
            },
          )



      ),
    );
  }
}
