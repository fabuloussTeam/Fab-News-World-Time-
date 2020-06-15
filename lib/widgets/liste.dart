import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'feedItem.dart';
import 'package:applicationdefluxrss/modules/date_convertisseur.dart';

class List extends StatefulWidget {
  RssFeed rssFeed;

  List(RssFeed rssFeed){
    this.rssFeed = rssFeed;
  }


  @override
  _ListState createState() => new _ListState();
}
class _ListState extends State<List> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new ListView.builder(
      itemBuilder: (context, i){
       RssItem  _rssItem = widget.rssFeed.items[i];
        String key = widget.rssFeed.items[i].title;
        return new Dismissible(
            key: new Key(i.toString()),
            child: new SingleChildScrollView(
              padding: EdgeInsets.only(left: 5.0, top: 1.0, right: 5.0, bottom: 8.0),
            //  height: height / 5,
              child: new Card(
                elevation: 7.5,

                child: new InkWell(
                  // onTap: (()=>openFeed(_feed.items[i].link)),
                  onTap: () => pageItemFeed(_rssItem),
                  child: new Column(

                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Container(
                        margin: EdgeInsets.only(top: 15.0),
                        padding: EdgeInsets.only(right: 5),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Text(
                              (_rssItem.dc.creator != null) ? _rssItem.dc.creator : "Author" ,
                              textAlign: TextAlign.left,
                              style: new TextStyle(color: Colors.blue, fontSize: 15.0),
                            ),
                            new Container(
                              width: width/3,
                            ),
                            new Text(
                              new DateConvertisseur().calculerDiffDate(_rssItem.pubDate != null ? _rssItem.pubDate: new  DateTime.now()),
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
      itemCount: widget.rssFeed.items.length,
    );
  }

  pageItemFeed(RssItem item){
    Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context) {
      return new FeedItem(item);
    }));
  }

}


