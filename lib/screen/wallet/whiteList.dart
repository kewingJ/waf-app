import 'package:flutter/material.dart';
import 'package:waf_app/screen/market/TabBarBody/ip_desbloqueadas.dart';

class whiteList extends StatefulWidget {
  final Widget child;

  whiteList({Key key, this.child}) : super(key: key);

  _whiteListState createState() => _whiteListState();
}

class _whiteListState extends State<whiteList> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = new TabController(length: 1, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        centerTitle: true,
        title: Text(
          "Lista de Blanca",
          style: TextStyle(
              color: Theme.of(context).textSelectionColor,
              fontFamily: "Gotik",
              fontWeight: FontWeight.w600,
              fontSize: 18.5),
        ),
        // actions: <Widget>[
        //   Padding(
        //     padding: const EdgeInsets.only(right: 8.0),
        //     child: Icon(
        //       Icons.search,
        //       color: Theme.of(context).textSelectionColor,
        //     ),
        //   ),
        // ],
        elevation: 3.0,
        backgroundColor: Theme.of(context).canvasColor,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Theme.of(context).accentColor,
          labelColor: Theme.of(context).accentColor,
          unselectedLabelColor: Theme.of(context).textSelectionColor,
          tabs: <Widget>[
            new Tab(
              child: Text(
                "",
                style: TextStyle(fontFamily: "Popins"),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(  
        //favorite
        children: <Widget>[ip_desbloqueadas()],
        controller: _tabController,
      ),
    );
  }
}
