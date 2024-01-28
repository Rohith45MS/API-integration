import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiCallList extends StatefulWidget {
  const ApiCallList({super.key});

  @override
  State<ApiCallList> createState() => _ApiCallListState();
}

class _ApiCallListState extends State<ApiCallList> {
  String? stringResponse;
  Map? mapResponse;
  Map? dataResponse;
  List? listResponse;
  Future apicall() async
  {
    http.Response response;
    response = await http.get(Uri.parse("https://reqres.in/api/users?page=2"));
    // response = await http.get(Uri.parse("https://reqres.in/api/users/2"));
    if(response.statusCode == 200)
    {
      setState(() {
        stringResponse =response.body;
        mapResponse = jsonDecode(response.body);
        // dataResponse = mapResponse!["data"];
        listResponse =mapResponse!["data"];
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    apicall();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text("Api Example"),
      ),
      // body: Column(
      //   children: [
      //     Container(
      //       height: 200,
      //       width: 400,
      //       color: Colors.green,
      //       child: Text("${stringResponse.toString()}"),
      //     ),
      //     Padding(
      //       padding: const EdgeInsets.all(8.0),
      //       child: Container(
      //           height: 100,
      //           width: 400,
      //           color: Colors.green,
      //           child: Column(
      //             children: [
      //               listResponse==null?Text("data loading"):Text("${listResponse![0].toString()}"),
      //               listResponse==null?Text("data loading"):Text("${listResponse![0]["first_name"].toString()}"),
      //             ],
      //           )
      //       ),
      //     ),
          body:ListView.builder(
            itemCount: listResponse==0?0:listResponse!.length,
              itemBuilder: (BuildContext context,int index){
                return Card(
                  child: ListTile(
                    leading: Container(
                      width: 50,
                        height: 50,
                      child: Image.network("${listResponse![index]["avatar"]}"),
                    ),
                    title: Row(
                      children: [
                        Text("${listResponse![index]["first_name"]}"),
                        SizedBox(width: 5,),
                        Text("${listResponse![index]["last_name"]}"),
                      ],
                    ),
                    subtitle: Text("${listResponse![index]["email"]}"),
                    
                    trailing: Text("${listResponse![index]["id"]}"),
                  ),
                );
              }
          ),


      
    );
  }
}