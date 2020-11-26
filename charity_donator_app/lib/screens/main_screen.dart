import 'package:charity_donator_app/constants.dart';
import 'package:charity_donator_app/screens/screens.dart';
import 'package:charity_donator_app/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class MainScreen extends StatefulWidget {
  @override
  MainScreenState createState()=> MainScreenState();
}

class MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
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
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              title: Text(
                'chari',
                style: const TextStyle(
                  color: kPrimaryColor,
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: -1.2,
                ),
              ),
              backgroundColor: Colors.white,
              pinned: true,
              floating: true,
              snap: true,
              forceElevated: innerBoxIsScrolled,
              bottom: TabBar(
                tabs: <Tab>[
                  Tab(icon: Icon(Icons.home)),
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
            Scaffold(),
            Scaffold(),
            Scaffold(),
            PersonalScreen(),
          ],
          controller: _tabController,
        ),
      ),
    );
  }
}