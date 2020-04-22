import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:the_app/pages/login/actions/Actions.dart';
import 'package:the_app/pages/manga/MangaPage.dart';
import 'package:the_app/redux/AppState.dart';
import 'package:the_app/utils/FirebaseAuthentication.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin<HomePage>, AutomaticKeepAliveClientMixin<HomePage>{

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
      child: IgnorePointer(
        ignoring: !isCollapsed,
        child: PageView(
          controller: _pageTabController,
          onPageChanged: (index) {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            MangaPage(),
            Container(color: Colors.red,),
            Container(color: Colors.green,),
            Container(color: Colors.blue,),
          ],
        ),
      ),
    );
  }

  _bottomNavyBar() {
    return IgnorePointer(
      ignoring: !isCollapsed,
      child: BottomNavyBar(
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
      ),
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
            child: ListView(
              children: <Widget>[
                FutureBuilder<FirebaseUser>(
                  future: FirebaseService().currentUser,
                  builder: (BuildContext context, AsyncSnapshot snapshot){
                    FirebaseUser user = snapshot.data;
                    return user != null ? _userAccountsHeader(user) : Container();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.home),
                  title: Text("Home"),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(Icons.ac_unit),
                  title: Text("Animes"),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(Icons.library_books),
                  title: Text("Mangas"),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(Icons.movie),
                  title: Text("Filmes"),
                  onTap: (){},
                ),
                ListTile(
                  leading: Icon(Icons.live_tv),
                  title: Text("Séries"),
                  onTap: (){},
                ),
                SizedBox(height: 100,),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text("Logout"),
                  subtitle: Text("Deslogar do app...", ),
                  onTap: () => _signOutGoogle(),
                ),
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
  }//

  UserAccountsDrawerHeader _userAccountsHeader(FirebaseUser user) {
    return UserAccountsDrawerHeader(
      margin: EdgeInsets.only(bottom: 15.0, right: 13),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(15.0), color: Colors.blueAccent),
      accountName: Text(user.displayName),
      accountEmail: Text(user.email, style: TextStyle(fontSize: 10),),
      currentAccountPicture: CircleAvatar(
        backgroundImage: NetworkImage(user.photoUrl,),
      ),
    );
  }

  void _signOutGoogle() async{
    service.signOutGoogle();
    StoreProvider.of<AppState>(context).dispatch(AnimationStatusLoginChange(0));
    Navigator.pushReplacementNamed(context, "/login");
  }

  @override
  bool get wantKeepAlive => true;

}
