import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/screens/home_screen.dart';
import 'package:charity_donator_app/screens/login_screen.dart';
import 'package:charity_donator_app/screens/personal_screen.dart';
import 'package:charity_donator_app/screens/projectdetails_screen.dart';
import 'package:charity_donator_app/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var jwt = prefs.getString('jwt');
//   print(jwt);
//   runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primaryColor: kPrimaryColor,
//         scaffoldBackgroundColor: Colors.white,
//       ),
//       home: jwt == null ? LoginScreen() : HomeScreen()
//   ));
// }

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: kPrimaryColor,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: MainPage()
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  MainPageState createState()=> MainPageState();
}

class MainPageState extends State<MainPage> with SingleTickerProviderStateMixin {
  ScrollController _scrollViewController;
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _scrollViewController = ScrollController();
    _tabController = TabController(vsync: this, length: 5);
  }

  @override
  void dispose() {
    _scrollViewController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        controller: _scrollViewController,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) { //<-- headerSliverBuilder
          return <Widget>[
            SliverAppBar(
              title: Text("Chari"),
              backgroundColor: Colors.white,
              pinned: true,                       //<-- pinned to true
              floating: true,                     //<-- floating to true
              snap: true,
              forceElevated: innerBoxIsScrolled,  //<-- forceElevated to innerBoxIsScrolled
              bottom: TabBar(
                tabs: <Tab>[
                  Tab(icon: Icon(Icons.home),),
                  Tab(icon: Icon(Icons.favorite),),
                  Tab(icon: Icon(Icons.notifications),),
                  Tab(icon: Icon(Icons.history),),
                  Tab(icon: Icon(Icons.account_circle),),
                ],
                controller: _tabController,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            HomeScreen(),
            HomeScreen(),
            HomeScreen(),
            HomeScreen(),
            PersonalScreen(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}