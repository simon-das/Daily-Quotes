import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class Chart extends StatefulWidget {
  final List<String> authors;
  final List<List> quotes;
  final int totalQuotes;
  Chart({this.authors, this.quotes, this.totalQuotes});

  @override
  _ChartState createState() => _ChartState();
}

class _ChartState extends State<Chart> {
  List<String> authorList;
  List<List> quotesList;

  @override
  void initState() {
    super.initState();
    authorList = widget.authors;
    quotesList = widget.quotes;
  }

  List<PieChartSectionData> getSections() {
    List<PieChartSectionData> items = List<PieChartSectionData>();
    int colorCount = 0;

    List<Color> colorList = [
      Colors.amberAccent,
      Colors.blue,
      Colors.red,
      Colors.green,
      Colors.purple,
      Colors.lightBlueAccent,
      Colors.pinkAccent
    ];

    for (int i = 0; i < quotesList.length; i++) {
      items.add(PieChartSectionData(
        color: colorList[colorCount++],
        value: (quotesList[i].length / widget.totalQuotes) * 100,
        title: authorList[i],
        radius: 120,
        showTitle: false,
      ));
      if (colorCount > 6) colorCount = 0;
    }

    return items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pie Chart'),
      ),
      body: SafeArea(
        child: Center(
          child: PieChart(
            PieChartData(
              sections: getSections(),
              borderData: FlBorderData(show: false),
              centerSpaceRadius: 60,
              sectionsSpace: 0,
            ),
          ),
        ),
      ),
    );
  }
}

// child: SizedBox(
// height: 800,
// width: 800,
// child: Container(
// child: AspectRatio(
// aspectRatio: 1,
// child:
// ),
// ),
// ),
