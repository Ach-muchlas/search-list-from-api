// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:api_without_model/model/image_model.dart';
import 'package:api_without_model/model/user_model.dart';
import 'package:api_without_model/model/username_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // list get data api
  List<User> users = [];

  // text editing search
  TextEditingController searchDatauser = TextEditingController();

  // list display
  late List<User> displayItem = List.from(users);

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Rest API Call',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(20.0),
            child: TextField(
              controller: searchDatauser,
              onChanged: ((value) => searchData(value)),
              decoration: InputDecoration(
                  filled: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20.0)),
                  hintText: 'Masukan Nama yang dicari',
                  prefixIcon: const Icon(Icons.search)),
            ),
          ),
          Container(
              padding: const EdgeInsets.all(20.0),
              child: (searchDatauser.text == '')
                  ? SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: users.length,
                        itemBuilder: (context, index) {
                          // final email = datauser.email;
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child:
                                  Image.network(users[index].picture.thumbnail),
                            ),
                            title: Text(users[index].name.first),
                            subtitle: Text(users[index].email),
                          );
                        },
                      ),
                    )
                  : SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        itemCount: displayItem.length,
                        itemBuilder: (context, index) {
                          // final email = datauser.email;
                          return ListTile(
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(100.0),
                              child: Image.network(
                                  displayItem[index].picture.thumbnail),
                            ),
                            title: Text(displayItem[index].name.first),
                            subtitle: Text(displayItem[index].email),
                          );
                        },
                      ),
                    ))
        ],
      ),
    );
  }

  void fetchUsers() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=10'));
    final body = response.body;
    final json = jsonDecode(body);
    final result = json['results'] as List<dynamic>;
    final transform = result.map(
      (e) {
        final nama = Username(
            title: e['name']['title'],
            first: e['name']['first'],
            last: e['name']['last']);
        final image = Imageuser(
            large: e['picture']['large'],
            medium: e['picture']['medium'],
            thumbnail: e['picture']['thumbnail']);
        return User(
          picture: image,
          name: nama,
          gender: e['gender'],
          email: e['email'],
          phone: e['phone'],
          nat: e['nat'],
        );
      },
    ).toList();
    setState(() {
      users = transform;
    });
    print('fetch data berhasil');
  }

  void searchData(String data) {
    setState(() {
      displayItem = users
          .where((value) =>
              value.name.first.toLowerCase().contains(data.toLowerCase()))
          .toList();
    });
  }
}
