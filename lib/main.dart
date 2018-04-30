import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'home_page.dart';
import 'package:http/http.dart' as http;

void main() async {
  List currencies = await getCurrencies();
  print(currencies);
  runApp(new MyApp(currencies));
}

class MyApp extends StatelessWidget {
  List _currencies;
  MyApp(this._currencies); 
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(primarySwatch: Colors.teal),
      home: new HomePage(_currencies),
    );
  }
}

Future<List> getCurrencies() async {
  final String url = "https://api.coinmarketcap.com/v1/ticker/?limit=50";
  http.Response response = await http.get(url);
  return JSON.decode(response.body);
}
