import 'package:waf_app/screen/market/TabBarBody/hosting.dart';
import 'package:flutter/material.dart';

class wallet extends StatefulWidget {
  final Widget child;

  wallet({Key key, this.child}) : super(key: key);

  _walletState createState() => _walletState();
}

class _walletState extends State<wallet> with SingleTickerProviderStateMixin {
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
        centerTitle: true,
        title: Text(
          "Lista de Hosting",
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
        children: <Widget>[hosting()],
        controller: _tabController,
      ),
    );
  }
}
