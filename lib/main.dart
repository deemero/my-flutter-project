import 'package:flutter/material.dart';
import 'package:my_news_app/login/login_ui.dart';

import 'menu/nested_json.dart';
import 'menu/news_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const LoginScreen(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController? tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
          controller: tabController,
          children: const [NestedJsonPage(), NewsPage()]),
      bottomNavigationBar: TabBar(
          indicatorWeight: 3.0,
          indicatorColor: Colors.grey,
          unselectedLabelColor: Colors.grey,
          labelColor: Colors.black,
          controller: tabController,
          tabs: const [
            Tab(
              text: "Nested Json",
              icon: Icon(
                Icons.person,
                color: Colors.blueGrey,
              ),
            ),
            Tab(
              text: "News",
              icon: Icon(
                Icons.newspaper,
                color: Colors.red,
              ),
            )
          ]),
    );
  }
}
