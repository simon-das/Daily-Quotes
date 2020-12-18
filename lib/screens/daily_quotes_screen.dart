import 'package:daily_quotes/screens/pie_chart.dart';
import 'package:daily_quotes/screens/see_all_quotes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:math';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

class DailyQuotesScreen extends StatefulWidget {
  final quotesData;

  DailyQuotesScreen({this.quotesData});

  @override
  _DailyQuotesScreenState createState() => _DailyQuotesScreenState();
}

class _DailyQuotesScreenState extends State<DailyQuotesScreen> {
  double _height, _width;
  int randomNumber;
  var quoteBox;
  DateTime _date = DateTime.now();
  TimeOfDay _time = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    quoteBox = Hive.box('quotes');
    //making the current date to seed to update quotes everyday
    DateFormat dateFormat = DateFormat('ddMMyyyy');
    int seed = int.parse(dateFormat.format(_date));
    randomNumber = Random(seed).nextInt(quoteBox.length);
  }

  String getDate(DateTime date) {
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');
    return dateFormat.format(date);
  }

  String getTimePeriod(int time) {
    if (time > 12) return ' pm';
    return ' am';
  }

  List<String> getAuthorList() {
    List<String> authors = List();
    for (int i = 0; i < quoteBox.length; i++) {
      authors.add(quoteBox.getAt(i).getAuthor());
    }
    authors = authors.toSet().toList();
    return authors;
  }

  List<List> getQuotes(List<String> authorList) {
    List<List> quotes = List.generate(authorList.length, (index) => List());
    for (int i = 0; i < quotes.length; i++) {
      int index = authorList.indexOf(quoteBox.getAt(i).getAuthor());
      quotes[index].add(quoteBox.getAt(i).getQuote());
    }
    return quotes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Color(0xFF8FB7F4).withOpacity(0.5),
            ),
            child: Text(
              'Daily Quotes',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            _height = constraints.maxHeight;
            _width = constraints.maxWidth;
            return Padding(
              padding: EdgeInsets.all(_height * 0.02),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: _height * 0.08,
                    width: _width,
                    child: LayoutBuilder(
                      builder: (ctx, cnstrnt) {
                        double localWidth = cnstrnt.maxWidth;
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Quotes of the day',
                              style: TextStyle(
                                fontSize: _height * 0.05,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            IconButton(
                                icon: Icon(
                                  Icons.refresh,
                                  size: _height * 0.065,
                                ),
                                onPressed: () {
                                  setState(() {
                                    randomNumber =
                                        Random().nextInt(quoteBox.length);
                                  });
                                }),
                          ],
                        );
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.34,
                    width: _width,
                    padding: EdgeInsets.all(_height * 0.025),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(_height * 0.02),
                      color: Colors.amber.withOpacity(0.4),
                    ),
                    child: LayoutBuilder(
                      builder: (ctx, cons) {
                        double localHeight = cons.maxHeight;
                        return Center(
                          child: Text(
                            quoteBox.getAt(randomNumber).getQuote(),
                            style: TextStyle(
                              fontSize: localHeight * 0.127,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: _height * 0.06,
                    width: _width,
                    padding: EdgeInsets.only(
                        top: _height * 0.015, left: _width * 0.02),
                    child: Text(
                      getDate(_date),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: _height * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _height * 0.01),
                    height: _height * 0.06,
                    width: _width * 0.5,
                    padding: EdgeInsets.only(
                        top: _height * 0.001, left: _width * 0.02),
                    child: RaisedButton(
                        color: Colors.amber.withOpacity(0.9),
                        child: Text(
                          'Choose date',
                          style: TextStyle(
                              fontSize: _height * 0.035,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () async {
                          DateTime pickedDate = await showDatePicker(
                            context: context,
                            initialDate: _date,
                            firstDate: DateTime(1996),
                            lastDate: DateTime(2022),
                          );
                          setState(() {
                            if (pickedDate != null) _date = pickedDate;
                          });
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _height * 0.02),
                    height: _height * 0.06,
                    width: _width,
                    padding: EdgeInsets.only(
                        top: _height * 0.01, left: _width * 0.02),
                    child: Text(
                      _time.hourOfPeriod.toString() +
                          ':' +
                          _time.minute.toString() +
                          getTimePeriod(_time.hour),
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: _height * 0.04,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _height * 0.01),
                    height: _height * 0.06,
                    width: _width * 0.5,
                    padding: EdgeInsets.only(
                        top: _height * 0.0005, left: _width * 0.02),
                    child: RaisedButton(
                        color: Colors.amber.withOpacity(0.9),
                        child: Text(
                          'Choose time',
                          style: TextStyle(
                              fontSize: _height * 0.035,
                              fontWeight: FontWeight.w500),
                        ),
                        onPressed: () async {
                          TimeOfDay pickedTime = await showTimePicker(
                              context: context, initialTime: _time);
                          setState(() {
                            if (pickedTime != null) _time = pickedTime;
                          });
                        }),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _height * 0.02),
                    height: _height * 0.06,
                    width: _width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        RaisedButton(
                            color: Colors.amber[800],
                            child: Text(
                              'Share',
                              style: TextStyle(
                                  fontSize: _height * 0.035,
                                  fontWeight: FontWeight.w500),
                            ),
                            onPressed: () {}),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _height * 0.02),
                    height: _height * 0.065,
                    width: _width,
                    child: Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                              color: Colors.amber.withOpacity(0.9),
                              child: Text(
                                'See all',
                                style: TextStyle(
                                    fontSize: _height * 0.035,
                                    fontWeight: FontWeight.w500),
                              ),
                              onPressed: () {
                                List<String> authorList = getAuthorList();
                                List<List> quotesList = getQuotes(authorList);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SeeAllQuotes(
                                    authors: authorList,
                                    quotes: quotesList,
                                  );
                                }));
                              }),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: _height * 0.02),
                    height: _height * 0.065,
                    width: _width,
                    child: Row(
                      children: [
                        Expanded(
                          child: RaisedButton(
                              color: Colors.amber.withOpacity(0.9),
                              child: Text(
                                'See Pie Chart',
                                style: TextStyle(
                                    fontSize: _height * 0.035,
                                    fontWeight: FontWeight.w500),
                              ),
                              onPressed: () {
                                List<String> authorList = getAuthorList();
                                List<List> quotesList = getQuotes(authorList);
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return Chart(
                                    authors: authorList,
                                    quotes: quotesList,
                                    totalQuotes: quoteBox.length,
                                  );
                                }));
                              }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
