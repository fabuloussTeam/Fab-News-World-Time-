import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webfeed/webfeed.dart';
import 'custom_text.dart';
import 'package:applicationdefluxrss/modules/date_convertisseur.dart';
class FeedItem extends StatefulWidget {

  RssItem feedItem;
  FeedItem(feedItem){
    this.feedItem = feedItem;
  }

  @override
  _FeedItemState createState() => new _FeedItemState();
}

class _FeedItemState extends State<FeedItem> {

 // static const String url = "https://www.france24.com/fr/afrique/rss";
  String titleItem = "titre de l'article";
  static const String loadingFeedMsg = 'Loading  Feed...';
  Object objectItem;
  List singleNews = [];
  int differenceInHours = 0;
  int differenceInMinutes = 0;
  int differenceInDays = 0;

  // Affichage en portrait
  Widget singleItem() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    print(widget.feedItem.pubDate);
    RssItem itemInfo = widget.feedItem;
     return  new Column(
             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
             children: <Widget>[

               new CustomTextCodabee(itemInfo.title, fontSize: 22.0,),
               new Container(
                 width: width/1.1,
                 height: height/2.5,
                 child: new Card(
                   color: Colors.pinkAccent,
                   child: new Image.network(itemInfo.enclosure.url, fit: BoxFit.fill,),
                 ),
               ),
               new Row(
                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                 children: <Widget>[
                   new CustomTextCodabee(itemInfo.dc.creator, color: Colors.pinkAccent, fonStyle: FontStyle.normal),
                   new Container(
                     width: width/3,
                   ),
                   new CustomTextCodabee(new DateConvertisseur().calculerDiffDate(itemInfo.pubDate), color: Colors.pinkAccent, fonStyle: FontStyle.normal),
                 ],
               ),
               new Container(
                 width: width/1.1,
                 padding: EdgeInsets.only(bottom: 20, ),
                 child: new CustomTextCodabee(itemInfo.description, color: Colors.grey[900], textAlign: TextAlign.justify, fonStyle: FontStyle.normal,)
               )
             ]
           );

  }


// Charger les datas venant vers url
 /* Future<RssFeed> loadFeed() async {
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
  }*/

  /* Future load(idIt) async {
    loadFeed().then((result){
      if(result == null || result.items.toString().isEmpty){
       // updateTitle(loadingFeedMsg);
        return;
      } else {
       // updateFeed(result);
        // updateTitle(result.title);
       // print(idIt);

         var resultFilter = (result.items.firstWhere((news) => news.guid == idIt));
         updateSingleItem(resultFilter);
       /*  print(resultFilter.guid);
         print(resultFilter.title);*/
      // singleNews.forEach((f) => print(f.description));
     //  print(singleNews.);

      }
    });
  }*/
 // body(){ return  singleItem(); }

  body(){
    return  singleItem();
  }


  @override
   Widget build(BuildContext context){
      return new Scaffold(
        appBar: new AppBar(
          title: new Text(titleItem),
        ),
        body: body(),
        );
   }



  isFeeEmpty(){
    return singleNews == null || singleNews[0] == null;
  }







}