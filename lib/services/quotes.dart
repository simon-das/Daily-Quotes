import 'package:hive/hive.dart';

part 'quotes.g.dart';

@HiveType(typeId: 0)
class Quotes {
  @HiveField(0)
  String quote;
  @HiveField(1)
  String author;

  Quotes({this.quote, this.author});

  String getQuote() {
    return this.quote;
  }

  String getAuthor() {
    return this.author;
  }
}
