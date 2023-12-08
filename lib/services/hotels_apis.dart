import 'dart:convert';

import 'package:http/http.dart' as http;

import '../model/hotel.dart';


class HotelsApi {

  static Future<List<Hotel>> fetchHotel() async {
    print('fetchHotel Called');
    const url =
        'https://raw.githubusercontent.com/tamer-alhashmi/hh_hotels/master/JasonFiles/properties.json';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final property = json['property'] as List<dynamic>;
    final hotels = property.map((e) {
      // final like = Like(
      //   likes: e['likeDislike']['likes'],
      //   dislikes: e['likeDislike']['dislikes'],
      //   userAction: e['likeDislike']['userAction'],
      // );
      return Hotel(
        name: e['name'],
        reception: e['reception'],
        description: e['description'],
        location: e['location'],
        id: e['id'],
        profilePicture: e['profilePicture'],
      );
    }).toList();
    return hotels;


    // ignore: dead_code
    print('FetchUser Completed');
  }
}