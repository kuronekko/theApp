import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:the_app/utils/FirebaseAuthentication.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final service = FirebaseService();
  int _currentIndex = 0;
  PageController _pageController;

//  @override
//  Widget build(BuildContext context) {
//    return WillPopScope(
//      onWillPop: _onWillPop,
//      child: Container(
//          color: Colors.blue,
//          child: Image(image: AssetImage("assets/images/horo.gif"), height: 35.0)),
//    );
//  }

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nav Bar")),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(color: Colors.blueGrey,),
            Container(color: Colors.red,),
            Container(color: Colors.green,),
            Container(color: Colors.blue,),
          ],
        ),
      ),

      //TODO
      drawer: SafeArea(child: Drawer(child: ListView(children: <Widget>[ListTile(
          leading: Icon(Icons.exit_to_app),
          title: Text("Logout"),
          trailing: Icon(Icons.arrow_forward),
          onTap: (){
            _signOutGoogle();
          }
      )],
      )),
      ),




      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Item One'),
              icon: Icon(Icons.home),
              activeColor: Colors.white,
              inactiveColor: Colors.grey
          ),
          BottomNavyBarItem(
              title: Text('Item One'),
              icon: Icon(Icons.apps),
              activeColor: Colors.white,
              inactiveColor: Colors.grey
          ),
          BottomNavyBarItem(
              title: Text('Item One'),
              icon: Icon(Icons.chat_bubble),
              activeColor: Colors.white,
              inactiveColor: Colors.grey
          ),
          BottomNavyBarItem(
              title: Text('Item One'),
              icon: Icon(Icons.settings),
              activeColor: Colors.white,
              inactiveColor: Colors.grey
          ),
        ],
      ),
    );
  }

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          child: new AlertDialog(
            title: new Text('Are you sure?'),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () => _signOutGoogle(),
                child: new Text('Yes'),
              ),
            ],
          ),
    ) ??
        false;
  }

  void _signOutGoogle() async{
    service.signOutGoogle();
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
