import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class Single_Api extends StatefulWidget {
  const Single_Api({super.key});

  @override
  State<Single_Api> createState() => _Single_ApiState();
}

class _Single_ApiState extends State<Single_Api> {

 String? stringResponse;
 Map? dataResponse;
 Map? mapResponse;

  Future apicall()async{
    http.Response response;
    response =await http.get(Uri.parse(
        "https://reqres.in/api/users/2"
    ));
    if(response.statusCode == 200)
     {
       setState(() {
         stringResponse = response.body;
         mapResponse = jsonDecode(response.body);
         dataResponse =mapResponse!["data"];



       }
   );
  }
}

void initState(){
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
              height: 150,
              width: 250,
              color: Colors.red,
              child: Text("${stringResponse.toString()}",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Container(
              height: 500,
              width: 392,
              color: Colors.blue,

              child: Column(
                children: [
                  dataResponse == null?Text("Loading"):Text("${dataResponse!["first_name"].toString()}"),
                  dataResponse == null?Text("Loading"):Text("${dataResponse!["last_name"].toString()}"),
                  dataResponse == null?Text("Loading"):Text("${dataResponse!["email"].toString()}"),
                  dataResponse == null?Text("Loading"):Text("${dataResponse!["id"].toString()}"),
                  dataResponse == null?Text("Loading"):Image.network("${dataResponse!["avatar"]}"),

                ],
              ),
            ),
          )

        ],
      ),
    );
  }
}
