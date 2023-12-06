import 'dart:convert';

import 'package:final_h_hotels/model/hotel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Hotel> hotels = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Rest API Call',
          style: TextStyle(

          ),),
        ),
        body: ListView.builder(
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotel = hotels[index];
              final name = hotel.name;
              final location = hotel.location;
              final profilePicture = hotel.profilePicture;
              return ListTile(
                leading: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(profilePicture)),
                title: Text(name),
                subtitle: Text(location),
              );
            }),
        floatingActionButton: FloatingActionButton(
          onPressed: fetchUsers,
          backgroundColor: Colors.teal, // Set the background color
          foregroundColor: Colors.white, // Set the icon color
          elevation: 5.0,
          child: const Icon(Icons.arrow_forward,
            size: 30.0,
              semanticLabel: 'FetchUser',
          ), // Set the shadow elevation
          ),
        );
  }

  void fetchUsers() async {
    print('FetchUsers Called');
    const url =
        'https://raw.githubusercontent.com/tamer-alhashmi/Json_Data_Files_Example/main/hotelsproperties.json';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final property = json['property'] as List<dynamic>;
    final transformed = property.map((e) {
      return Hotel(
          name: e['name'],
          description: e['description'],
          location: e['location'],
          id: e['id'],
          profilePicture: e['profilePicture']);
    }).toList();
    setState(() {
      hotels = transformed;
    });

    print('FetchUser Completed');
  }
}
