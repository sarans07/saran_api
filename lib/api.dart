import 'dart:convert';

import 'package:flutter/material.dart';

import 'Model/CatFactClass.dart';
import 'package:http/http.dart' as http;
class api extends StatefulWidget {
  const api({super.key});

  @override
  State<api> createState() => _apiState();
}

class _apiState extends State<api> {


  Future<CatFact> fetchCatDetails() async{

    var resp = await http.get(Uri.parse("https://catfact.ninja/fact"));
    return CatFact.fromjson(jsonDecode(resp.body));

  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // fetchCatDetails();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fetch Data Example',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Fetch Data Example'),
        ),
        body: Center(
          child: FutureBuilder<CatFact>(
            future: fetchCatDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Column(
                  children: [
                    Text(snapshot.data!.fact.toString()),
                    Text(snapshot.data!.length.toString())
                  ],
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }

              // By default, show a loading spinner.
              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
