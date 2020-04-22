import 'package:flutter/material.dart';
import 'package:the_app/utils/AssetsController.dart';

enum AppBarBehavior { normal, pinned, floating, snapping }


class MangaPage extends StatefulWidget {
  @override
  _MangaPageState createState() => _MangaPageState();
}


class _MangaPageState extends State<MangaPage> with TickerProviderStateMixin{

  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  double _appBarHeight = 256.0;

  AnimationController _containerController;

  Animation<double> width;

  Animation<double> heigth;

  void initState() {
    _containerController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    super.initState();
    width = new Tween<double>(
      begin: 200.0,
      end: 220.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth = new Tween<double>(
      begin: 400.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth.addListener(() {
      setState(() {
        if (heigth.isCompleted) {}
      });
    });
    _containerController.forward();
  }


  @override
  Widget build(BuildContext context) {

    Size screenSize = MediaQuery.of(context).size;

    return Container(
      child: ListView(
        children: <Widget>[
          _card(screenSize),
        ],
      )
    );
  }

  _card(Size screenSize) {
    return Hero(
      tag: "card",
      child: GestureDetector(
        onTap: () => Navigator.push(context, PageRouteBuilder(transitionDuration: Duration(seconds: 1), pageBuilder: (_,__,___) => _extendedCard(screenSize))),
        child: Card(
          color: Colors.transparent,
          elevation: 4.0,
          child: new Container(
          alignment: Alignment.center,
          width: screenSize.width / 1.2,
          height: screenSize.height / 3.5,
          decoration: new BoxDecoration(
          color: Colors.blueAccent,
          //color: new Color.fromRGBO(121, 114, 173, 1.0),
          borderRadius: new BorderRadius.all(Radius.circular(30.0)),)
          ),
        ),
      ),
    );
  }



  _extendedCard(Size screenSize) {
    return Hero(
      tag: "card",
      child: SafeArea(
        child: Card(
          color: Colors.transparent,
          elevation: 4.0,
          child: new Container(
            alignment: Alignment.center,
            width: screenSize.width / 1.2,
            height: screenSize.height / 1.7,
            decoration: new BoxDecoration(
              color: Colors.blueAccent,
              //color: new Color.fromRGBO(121, 114, 173, 1.0),
              borderRadius: new BorderRadius.all(Radius.circular(30.0)),),
            child: CustomScrollView(
                shrinkWrap: false,
                slivers: <Widget>[
                  new SliverAppBar(
                    elevation: 0.0,
                    forceElevated: true,
                    leading: new IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: new Icon(
                        Icons.arrow_back,
                        color: Colors.cyan,
                        size: 30.0,
                      ),
                    ),
                    expandedHeight: _appBarHeight,
                    pinned: _appBarBehavior == AppBarBehavior.pinned,
                    floating: _appBarBehavior == AppBarBehavior.floating || _appBarBehavior == AppBarBehavior.snapping,
                    snap: _appBarBehavior == AppBarBehavior.snapping,
                    flexibleSpace: new FlexibleSpaceBar(
                      title: new Text("Party"),
                      background: new Stack(
                        fit: StackFit.expand,
                        children: <Widget>[
                          new Container(
                            width: width.value,
                            height: _appBarHeight,
                            decoration: new BoxDecoration(
                              image: logoLogin,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ]
            ),
          ),
        ),
      ),
    );
  }

}
