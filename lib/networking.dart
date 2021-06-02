import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class NetworkHelper {
  final String url;

  NetworkHelper(this.url);

  Future getData() async {
    http.Response response = await http.get(Uri.parse(url));

    // if (response.statusCode == 200)
    String data = response.body;
    // print(response.body);

    var decodeData = jsonDecode(data);
    return decodeData;
  }
}
