import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('REST API called'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context,index){
          final user = users[index];
          final email = user.email;
          final name = user.name;
          return ListTile(
            leading: ClipRRect(
              borderRadius:BorderRadius.circular(100),
            ),
            title: Text(email),
            subtitle: Text(name.ToString()),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchUsers,
      ),
    );
  }

  void fetchUsers() async{
    print('fetchUsers called');
    const url = 'https://randomuser.me/api/?results=20';
    final uri = Uri.parse(url);
    final response  = await http.get(uri);
    final body = response.body;
    final jsResult = jsonDecode(body);
    final result = jsResult['results'] as List<dynamic>;
    final transformed = result.map((e){
      final name = UserName(title: e['name']['title'], first: e['name']['first'], last: e['name']['last']);
        return User(
          cell: e['cell'],
          email: e['email'],
          gender: e['gender'],
          nat: e['nat'],
          phone: e['phone'],
          name: name
        );
    }).toList();
    setState(() {
      users = transformed;
    });
    print('fetch users completed');


  }
}
