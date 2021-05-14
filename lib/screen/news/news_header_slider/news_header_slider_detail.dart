import 'package:waf_app/component/News/newsHeaderModel.dart';
import 'package:flutter/material.dart';

class headerSliderDetail extends StatefulWidget {
  newsHeader item;

  headerSliderDetail({Key key, this.item}) : super(key: key);

  _headerSliderDetailState createState() => _headerSliderDetailState(item);
}

class _headerSliderDetailState extends State<headerSliderDetail> {
  newsHeader item;
  _headerSliderDetailState(this.item);

  @override
  Widget build(BuildContext context) {
    double _fullHeight = MediaQuery.of(context).size.height;

    /// Hero animation for image
    final hero = Hero(
      tag: 'hero-tag-${item.id}',
      child: new DecoratedBox(
        decoration: new BoxDecoration(
          image: new DecorationImage(
            fit: BoxFit.cover,
            image: new AssetImage(item.imageUrl),
          ),
          shape: BoxShape.rectangle,
        ),
        child: Container(
          margin: EdgeInsets.only(top: 130.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.bottomCenter,
              end: FractionalOffset.topCenter,
              colors: [
                const Color(0xFF000000),
                const Color(0x00000000),
              ],
            ),
          ),
        ),
      ),
    );

    return Scaffold(
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        slivers: <Widget>[
          /// Appbar Custom using a SliverAppBar
          SliverAppBar(
            centerTitle: true,
            backgroundColor: Color(0xFF172E4D),
            iconTheme: IconThemeData(color: Colors.white),
            expandedHeight: _fullHeight - 20,
            elevation: 0.1,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Container(
                  width: 220.0,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 50.0),
                    child: Text(
                      item.title,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.5,
                          fontFamily: "Popins",
                          fontWeight: FontWeight.w700),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
                background: Stack(
                  children: <Widget>[
                    Material(
                      child: hero,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 540.0, left: 20.0),
                      child: Text(
                        item.category,
                        style: TextStyle(
                            color: Colors.white54,
                            fontSize: 16.0,
                            fontFamily: "Popins",
                            fontWeight: FontWeight.w400),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    )
                  ],
                )),
          ),

          SliverToBoxAdapter(
              child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(
                  top: 40.0, left: 20.0, right: 20.0, bottom: 20.0),
              child: Text(
                item.desc1,
                style: TextStyle(
                    fontFamily: "Popins",
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
              child: Text(
                item.desc2,
                style: TextStyle(
                    fontFamily: "Popins",
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, left: 20.0, right: 20.0, bottom: 20.0),
              child: Text(
                item.desc3,
                style: TextStyle(
                    fontFamily: "Popins",
                    color: Theme.of(context).textSelectionColor,
                    fontSize: 15.0,
                    fontWeight: FontWeight.w400),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(
              height: 50.0,
            )
          ])),
        ],
      ),
    );
  }
}
