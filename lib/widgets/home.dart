import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:applicationdefluxrss/modules/parser.dart';
import 'dart:async';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:applicationdefluxrss/widgets/feedItem.dart';
import 'package:applicationdefluxrss/modules/date_convertisseur.dart';
import 'package:applicationdefluxrss/widgets/liste.dart';
import 'package:applicationdefluxrss/widgets/grid.dart';



class Home extends StatefulWidget {
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _HomeState createState() => _HomeState();
}


class _HomeState extends State<Home> {

static const String url = "https://www.france24.com/fr/rss";
RssFeed _feed;
RssItem _rssItem;
String title;
static const String loadingFeedMsg = 'Loading  Feed...';
static String placeHolderImage = "images/chat.jpg";

// Charger les datas venant vers url
updateTitle(title){
  setState(() {
    title = title;
  //  print(title);
  });
}

updateFeed(feed){
  setState(() {
    _feed = feed;
  });
}

// Ouvrir un itemvers le navigateur
  // Lancer un item dans le navigateur
  Future<void> openFeed(String url) async{
    if(await canLaunch(url)){
      await launch(
          url,
          forceSafariVC: false,
          forceWebView: true
      );
      return;
    }
  //  updateTitle(title);
  }

Future load() async {
   updateTitle(loadingFeedMsg);
    RssFeed recu = await Parser().chargerRSS();
  if (recu != null){
    setState(() {
       _feed = recu;
    });
  }
}


isFeeEmpty(){
  return null == _feed || null == _feed.items;
}

body(){
  Orientation orientation = MediaQuery.of(context).orientation;

  return isFeeEmpty() ? Center(
    child: CircularProgressIndicator(),
  ) : RefreshIndicator(
    child: (orientation == Orientation.portrait) ? new List(_feed) : new Grid(_feed),
    onRefresh: () => load(),
  );
}


// Function du calcul de la diffrence de date

  @override
  void initState(){
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    print(orientation);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue[880],
        centerTitle: true,
        actions: <Widget>[
          new IconButton(
               icon: const Icon(Icons.refresh, color: Colors.white),
               onPressed: (){
                 _feed = null;
                 load();
               },
               iconSize: 33.0,
            ),
        ],
      ),
      body: body()
    );
  }


  // Affichage en portrait

  pageItemFeed(RssItem item){
  Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
      return new FeedItem(item);
    }));
  }

 

}
