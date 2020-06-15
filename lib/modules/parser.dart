import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';

class Parser {
  final url = "https://www.france24.com/fr/rss";

  Future chargerRSS() async {
    final client = http.Client();
    final response = await client.get(url);
    if (response.statusCode == 200){
      final feed =  RssFeed.parse(response.body);
      return feed;
    } else {
      print("Erreur ${response.statusCode}");
    }
  }



}