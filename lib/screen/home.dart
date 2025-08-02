import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> users = [];
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
          final name = '${user['name']['title']} ${user['name']['first']} ${user['name']['last']}';
          final email = user['email'];
          final avatar = user['picture']['thumbnail'];
          return ListTile(
            leading: CircleAvatar(
                child: Text('${++index}'),
            ),
            title: Text(email),
            subtitle: Text(name),
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
    setState(() {
      users = jsResult['results'];
    });
    print('fetch users completed');


  }
}
