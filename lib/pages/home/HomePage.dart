import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:the_app/utils/FirebaseAuthentication.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage>{

  final service = FirebaseService();

  //Page e bottom nav
  int _currentIndex = 0;
  PageController _pageTabController;

  //animation
  bool isCollapsed = true;
  double screenWidth, screenHeight;
  final Duration duration = const Duration(milliseconds: 500);
  AnimationController _drawerAnimationController;
  double borderRadius = 0.0;


  @override
  void initState() {
    super.initState();
    _pageTabController = PageController();
    _drawerAnimationController = AnimationController(vsync: this, duration: duration);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    screenHeight = size.height;
    screenWidth = size.width;

    return WillPopScope(
      onWillPop: () async {
        if (!isCollapsed) {
          setState(() {
            _drawerAnimationController.reverse();
            borderRadius = 0.0;
            isCollapsed = !isCollapsed;
          });
        }
          return false;
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Stack(
          children: <Widget>[
            _drawerMenu(context),
            AnimatedPositioned(
                left: isCollapsed ? 0 : 0.6 * screenWidth,
                right: isCollapsed ? 0 : -0.2 * screenWidth,
                top: isCollapsed ? 0 : screenHeight * 0.1,
                bottom: isCollapsed ? 0 : screenHeight * 0.1,
                duration: duration,
                curve: Curves.fastOutSlowIn,
                child: _dashboard(context)),
          ],
        ),
      ),
    );
  }

  _dashboard(BuildContext context) {
    return InkWell(
      child: SafeArea(
          child: Material(
              borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
              type: MaterialType.card,
              animationDuration: duration,
              color: Theme.of(context).scaffoldBackgroundColor,
              elevation: 8,
              child: InkWell(
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
                    child: Scaffold(
                      appBar: AppBar(
                        title: Text('Dashboard'),
                        leading: IconButton(
                            icon: AnimatedIcon(
                              icon: AnimatedIcons.menu_close,
                              progress: _drawerAnimationController,
                            ),
                            onPressed: () {
                              setState(() {
                                if (isCollapsed) {
                                  _drawerAnimationController.forward();
                                  borderRadius = 16.0;
                                } else {
                                  _drawerAnimationController.reverse();
                                  borderRadius = 0.0;
                                }
                                isCollapsed = !isCollapsed;
                              });
                            }),
                      ),
                      body: _body(),
                      bottomNavigationBar: _bottomNavyBar(),
                    )
                ),
                onTap: () {
                  setState(() {
                    if (!isCollapsed) {
                      _drawerAnimationController.reverse();
                      borderRadius = 0.0;
                      isCollapsed = !isCollapsed;
                    }
                  });
                },
              )
          )
      ),
    );
  }

  SizedBox _body() {
    return SizedBox.expand(
      child: PageView(
        controller: _pageTabController,
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
    );
  }

  BottomNavyBar _bottomNavyBar() {
    return BottomNavyBar(
      selectedIndex: _currentIndex,
      onItemSelected: (index) {
        setState(() => _currentIndex = index);
        _pageTabController.jumpToPage(index);
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
    );
  }

  Widget _drawerMenu(context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(left: 32.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: FractionallySizedBox(
            widthFactor: 0.6,
            heightFactor: 0.8,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'Menu item 1',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: 10),
                Text(
                  'Menu item 2',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: 10),
                Text(
                  'Menu item 3',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: 10),
                Text(
                  'Menu item 4',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                ),
                SizedBox(height: 10),
                InkWell(
                  child: Text(
                    'Sign Out',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
                  ),
                  onTap: () => _signOutGoogle(),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageTabController.dispose();
    super.dispose();
  }




//TO REMOVE
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

}
