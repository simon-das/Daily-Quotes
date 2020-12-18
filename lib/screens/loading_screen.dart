import 'package:daily_quotes/screens/daily_quotes_screen.dart';
import 'package:daily_quotes/services/network.dart';
import 'package:daily_quotes/services/quotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    storeData();
  }

  Future getData() async {
    //fetching the quotes data
    NetworkHelper networkHelper =
        NetworkHelper(url: 'https://type.fit/api/quotes');
    var data = await networkHelper.getData();

    return data;
  }

  void storeData() async {
    var data = await getData();
    var quoteBox = await Hive.openBox('quotes');

    if (quoteBox.length == 0) {
      for (var i in data) {
        quoteBox.add(Quotes(quote: i['text'], author: i['author']));
      }
    }

    //pushing to daily quotes screen
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) {
        return DailyQuotesScreen(
          quotesData: quoteBox,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: SpinKitDoubleBounce(
        color: Colors.white,
        size: 100,
      ),
    );
  }
}
