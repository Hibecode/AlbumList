

import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:newproject/model/albumItem.dart';

import '../home/constants/api_url.dart';



/*Future<Album> fetchAlbum() async {
  final response = await http
      .get(Uri.parse(AppUrl.url));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load album');
  }
}*/

class MainProvider extends ChangeNotifier{



  Future<List<Album>> getItems() async {
    var result;

    //notifyListeners();


    var headers =  {
      'Content-Type': 'application/json',
    };


    var request = http.Request('GET',
        Uri.parse(AppUrl.url) );

    request.headers.addAll(headers);

    http.StreamedResponse streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    final List<dynamic> responseData = json.decode(response.body);
    print("workk $responseData");

    if (response.statusCode == 200) {

      List<Album> responseList = (responseData as List).map((e) => Album.fromJson(e)).toList();


      result = responseList;
      /*result = {
        'status': true,
        'data': responseList,
      };*/

    } else {

      result = [];
      /*result = {
        'status': false,
      };*/
    }

    return result;

  }

}