import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

class ApiList extends StatefulWidget {
  const ApiList({super.key});

  @override
  State<ApiList> createState() => _ApiListState();
}

class _ApiListState extends State<ApiList> {

  String? stringResponse;
  Map? dataResponse;
  Map? mapResponse;
  List? listResponse;

  Future apicall()async{
    http.Response response;
    response =await http.get(Uri.parse(
        "https://reqres.in/api/users?page=2"
    ));
    if(response.statusCode == 200)
    {
      setState(() {
        stringResponse = response.body;
        mapResponse = jsonDecode(response.body);
        dataResponse =mapResponse!["data"];
        listResponse=mapResponse!["data"];



      }
      );
    }
  }
  void initstate(){
    super.initState();
    apicall();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 500,
              width: 350,
              color: Colors.cyan,
              child: Text("${stringResponse.toString()}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              height: 100,
              width: 400,
              color: Colors.green,
              child: Column(
                children: [
                  listResponse==null?Text("data loading"):Text("${listResponse![0].toString()}"),
                  listResponse==null?Text("data loading"):Text("${listResponse![0]["first_name"].toString()}"),
                ],
              ),
              ),
        ),

        ],
      ),
    );
  }
}
