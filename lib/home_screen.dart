// import 'package:final_h_hotels/Properties/Hotels.dart';
import 'package:final_h_hotels/model/hotel.dart';
import 'package:final_h_hotels/services/hotels_apis.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Hotel> hotels = [];

  // this override to call data
  @override
  void initState(){
    super.initState();
    fetchHotel();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text('Rest API Call',
          style: TextStyle(
            color: Colors.white,
          ),),
        ),
        body: ListView.builder(
            itemCount: hotels.length,
            itemBuilder: (context, index) {
              final hotel = hotels[index];
              final name = hotel.name;
              final location = hotel.location;
              final description = hotel.description;
              final profilePicture = hotel.profilePicture;
              // final manned = hotel.reception == "manned" ? Colors.teal : Colors.tealAccent;
              return Column(
                children: [ListTile(
                  leading: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(profilePicture)
                      ),
                  title: Text(name),
                  // tileColor: manned,
                  subtitle: Text(location),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  color: Colors.yellow,
                  child: Text(description)),
                  ],
                );
            }),

        // floatingActionButton: FloatingActionButton(
        //   onPressed: fetchUsers,
        //   backgroundColor: Colors.teal, // Set the background color
        //   foregroundColor: Colors.white, // Set the icon color
        //   elevation: 5.0,
        //   child: const Icon(Icons.arrow_forward,
        //     size: 30.0,
        //       semanticLabel: 'FetchUser',
        //   ), // Set the shadow elevation
        //   ),
        );
  }

  Future<void> fetchHotel() async {
    final response = await HotelsApi.fetchHotel();
    setState(() {
      hotels = response.cast<Hotel>();
    });
  }
}
