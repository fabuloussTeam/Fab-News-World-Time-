import 'package:flutter/material.dart';
import 'package:webfeed/domain/rss_feed.dart';
import 'package:webfeed/domain/rss_item.dart';
import 'feedItem.dart';
import 'package:applicationdefluxrss/modules/date_convertisseur.dart';

class Grid extends StatefulWidget {
  RssFeed rssFeed;

  Grid(RssFeed rssFeed){
    this.rssFeed = rssFeed;
  }


  @override
  _GridState createState() => new _GridState();
}
class _GridState extends State<Grid> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return new GridView.builder(
      gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (context, i){
        RssItem _rssItem = widget.rssFeed.items[i];
        String key = widget.rssFeed.items[i].title;
        return new Dismissible(
            key: new Key(key.toString()),
            child: new Container(
              padding: EdgeInsets.only(left: 5.0, top: 1.0, right: 5.0, bottom: 1.0),
              height: 200,
              child: new Card(
                elevation: 7.5,
                child: new InkWell(
                  onTap: () => pageItemFeed(_rssItem),
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
                              style: new TextStyle(color: Colors.blue, fontSize: 14.0),
                            ),
                            new Container(
                              width: width/8,
                            ),
                            new Text(
                              new DateConvertisseur().calculerDiffDate(_rssItem.pubDate != null ? _rssItem.pubDate: new  DateTime.now()),
                              textAlign: TextAlign.right,
                              style:  new TextStyle(
                                  color: Colors.pinkAccent,
                                  fontSize: 14

                              ),
                            )
                          ],
                        ),
                      ),
                      new Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: new Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            new Card(
                              borderOnForeground: true,
                              elevation: 7.5,
                              child: new Container(
                                width: width/2.4,
                                height: height/2.1,
                                child: new Image.network(
                                  _rssItem.enclosure.url,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            new Container( width: 10,),
                            new Container(

                              width: width/2,
                              // height: 100,
                              padding: EdgeInsets.only(right: 12, left: 12, bottom: 10),
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


