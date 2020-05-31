import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:applicationdefluxrss/modules/parse.dart';
import 'dart:async';
import 'package:webfeed/webfeed.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

//import 'package:webfeed/domain/atom_feed.dart';

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
String currentDatePostString;

int differenceInHours = 0;
int differenceInMinutes = 0;



// Charger les datas venant vers url
Future<RssFeed> loadFeed() async {
  try{
    final client = http.Client();
    final response = await client.get(url);
    if (response.statusCode == 200){
   //   final feed =  RssFeed.parse(response.body);
      return RssFeed.parse(response.body);
    }
  } catch (e) {
    print("Une Erreur de chargement est $e ");
  }
  return null;
}

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
    updateTitle(title);
  }


Future load() async {
   updateTitle(loadingFeedMsg);
  loadFeed().then((result){
   if(result == null || result.items.toString().isEmpty){
      updateTitle(loadingFeedMsg);
      return;
    } else {
      updateFeed(result);
      updateTitle(result.title);
    }
  });
}



thumbnail(imageUrl) {
  print(imageUrl);
  return new Padding(
    padding: EdgeInsets.only(left: 15.0),
    child: new CachedNetworkImage(
      placeholder: (context, url) => Image.asset(placeHolderImage),
      imageUrl: imageUrl,
      height: 50,
      width: 70,
      alignment: Alignment.center,
      fit: BoxFit.cover,
    ),
  );
}

isFeeEmpty(){
  return null == _feed || null == _feed.items;
}

body(){
  return isFeeEmpty() ? Center(
    child: CircularProgressIndicator(),
  ) : RefreshIndicator(
    child: listeNews(),
    onRefresh: () => load(),
  );
}

 calculerDiffDate(valDate) {
   var string = valDate;
    // Conversion de la string date
   DateFormat format = new DateFormat("EEE, dd MMM yyyy hh:mm:ss zzz");
   //print(format.parse(string));
   DateTime valDateParsed = format.parse(string);
   var difference = new DateTime.now().difference(valDateParsed);
     // print(difference.inMinutes);
   differenceInHours = difference.inHours;
   differenceInMinutes = difference.inMinutes;
   if (differenceInMinutes < 60){
     return "il y a $differenceInMinutes minutes";
   } else {
     return "il y a $differenceInHours heures";
   }
 }

  @override
  void initState(){
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blue[880],
        centerTitle: true,
      ),
      body: body()
    );
  }

  Widget listeNews() {
   double width = MediaQuery.of(context).size.width;
   double height = MediaQuery.of(context).size.height;
   return new ListView.builder(
       itemBuilder: (context, i){
         _rssItem = _feed.items[i];
         String key = _feed.items[i].title;
         return new Dismissible(
              key: new Key(i.toString()),
              child: new Container(
                padding: EdgeInsets.only(left: 5.0, top: 1.0, right: 5.0, bottom: 1.0),
                height: 200,
                child: new Card(
                  elevation: 7.5,
                  child: new InkWell(
                    onTap: (()=>openFeed(_feed.items[i].link)),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        new Container(
                          margin: EdgeInsets.only(top: 15.0),
                         child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Text(
                                (_rssItem.dc.creator != null) ? _rssItem.dc.creator : "Author" ,
                                textAlign: TextAlign.left,
                                style: new TextStyle(color: Colors.blue, fontSize: 15.0),
                              ),
                              new Container(
                                width: 180,
                              ),
                              new Text(
                                calculerDiffDate(_rssItem.pubDate != null ? _rssItem.pubDate: new  DateTime.now()),
                                 textAlign: TextAlign.right,
                                style:  new TextStyle(
                                  color: Colors.pinkAccent
                                ),
                              )
                            ],
                          ),
                        ),
                        new Container(
                          margin: EdgeInsets.only(top: 5.0),

                          child: new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Card(
                               borderOnForeground: true,
                                elevation: 7.5,
                                child: new Container(
                                  width: width/2.8,
                                  height: height/5.5,
                                  child: new Image.network(
                                    _rssItem.enclosure.url,
                                    fit: BoxFit.cover,),
                                ),
                              ),
                              new Container( width: 10,),
                              new Container(
                                width: width/2,
                               // height: 100,
                                padding: EdgeInsets.only(right: 4, left: 0),
                                child: new Text(
                                  _rssItem.description.substring(0, 100),
                                  textAlign: TextAlign.center,
                                  style: new TextStyle(color: Colors.blue[400], fontSize: 15.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
          );

       },
     itemCount: _feed.items.length,

   );
  }






}
