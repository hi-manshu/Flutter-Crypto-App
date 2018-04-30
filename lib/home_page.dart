import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  List currencies;
  HomePage(this.currencies);
  @override
  _HomePageState createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List currencies;
  final List<MaterialColor> _color = [Colors.blue, Colors.indigo, Colors.red];

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Crypto App"),
      ),
      body: _cryptoWidget(),
    );
  }

  Widget _cryptoWidget() {
    return new Container(
      child: new Column(
        children: <Widget>[
          new Flexible(
            child: new ListView.builder(
              itemCount: widget.currencies.length,
              itemBuilder: (BuildContext context, int index) {
                final Map currency = widget.currencies[index];
                final MaterialColor color = _color[index % _color.length];
                return _getListItemUi(currency, color);
              },
            ),
          ),
        ],
      ),
    );
  }

  ListTile _getListItemUi(Map currency, MaterialColor color) {
    return new ListTile(
      leading: new CircleAvatar(
        backgroundColor: color,
        child: new Text(currency['name'][0]),
      ),
      title: new Text(currency['name'],
          style: new TextStyle(fontWeight: FontWeight.bold)),
      subtitle: _getSubtitleText(
          currency['price_usd'], currency['percent_change_1h']),
      isThreeLine: true,
    );
  }

  Widget _getSubtitleText(String price, String percentChange) {
    TextSpan priceTextWidget = new TextSpan(
        text: "\$$price\n", style: new TextStyle(color: Colors.black));
    String percentChangeText = "1 hour: $percentChange%";
    TextSpan percentageChangeTextWidget;
    if (double.parse(percentChange) > 0) {
      percentageChangeTextWidget = new TextSpan(
          text: "\$$price\n", style: new TextStyle(color: Colors.green));
    } else {
      percentageChangeTextWidget = new TextSpan(
          text: "\$$price\n", style: new TextStyle(color: Colors.red));
    }
    return new RichText(
      text:
          new TextSpan(children: [priceTextWidget, percentageChangeTextWidget]),
    );
  }
}
