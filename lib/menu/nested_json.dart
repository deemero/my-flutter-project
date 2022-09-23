import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NestedJsonPage extends StatefulWidget {
  const NestedJsonPage({super.key});

  @override
  State<NestedJsonPage> createState() => _NestedJsonPageState();
}

class _NestedJsonPageState extends State<NestedJsonPage> {
  // variable to store url api
  final String api = "https://jsonplaceholder.typicode.com/users";
  List listUser = [];
  bool isLoading = false;

  // function for get data from web server api
  Future<List?> getDataUser() async {
    try {
      setState(() {
        isLoading = true;
      });
      // creating a url object by parsing url string
      var res = await http.get(Uri.parse(api));
      // this variable for store response body
      List data = jsonDecode(res.body);
      setState(() {
        isLoading = false;
        // enter the response body to the list user variable
        listUser = data;
        log('data user: $listUser');
      });
      // catch an error when get data
    } catch (e) {
      setState(() {
        isLoading = false;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    }
    return null;
  }

  @override
  void initState() {
    getDataUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Public API"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: 10,
              itemBuilder: ((context, index) {
                return Card(
                  child: ListTile(
                    leading: const Icon(Icons.picture_in_picture_rounded),
                    title: Text(listUser[index]["name"]),
                    subtitle: Text(listUser[index]["website"]),
                    trailing: Text(listUser[index]["address"]["city"]),
                  ),
                );
              })),
    );
  }
}
