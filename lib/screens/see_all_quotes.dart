import 'package:flutter/material.dart';

class SeeAllQuotes extends StatefulWidget {
  final List<String> authors;
  final List<List> quotes;
  SeeAllQuotes({this.authors, this.quotes});

  @override
  _SeeAllQuotesState createState() => _SeeAllQuotesState();
}

class _SeeAllQuotesState extends State<SeeAllQuotes> {
  List<String> authorList;
  List<List> quotesList;

  @override
  void initState() {
    super.initState();
    authorList = widget.authors;
    quotesList = widget.quotes;
  }

  List<Text> getTabs() {
    int count = 0;
    List<Text> tabList = new List<Text>();
    for (int i = 0; i < authorList.length; i++) {
      if (authorList[i] == null) {
        tabList.add(Text('Unknown'));
      } else {
        tabList.add(Text(authorList[i]));
      }
    }
    // print(count);
    return tabList;
  }

  List<ListView> getTabBarView() {
    List<ListView> tabBarViewList = List<ListView>();
    for (int i = 0; i < authorList.length; i++) {
      tabBarViewList.add(ListView.builder(
          itemCount: quotesList[i].length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(quotesList[i][index]),
              ),
            );
          }));
    }
    return tabBarViewList;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: authorList.length,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child: Text('All Quotes')),
          bottom: TabBar(
            isScrollable: true,
            tabs: getTabs(),
          ),
        ),
        body: TabBarView(
          children: getTabBarView(),
        ),
      ),
    );
  }
}
