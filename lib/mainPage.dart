
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertask/CartPage.dart';
import 'package:fluttertask/HomePage.dart';
import 'package:fluttertask/ProfilePage.dart';

import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';



class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Welcome Screen',
      theme: ThemeData(
        primaryColor: Color(0xff494cf6), accentColor: Color(0xfff4786e),
      ),

      home: MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  int currentIndex =0;
  List<Widget> _widgetOption=<Widget>[

    MyHomePage(),
    CartPage(),
    ProfilePage(),
  ];
  late SharedPreferences logindata;
   String username="";
  @override
  void initState() {
    super.initState();
    initial();


  }
  void initial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString('username')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff749eea),

      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(onPressed: (){

            logindata.setBool('login', true);
            Navigator.pushReplacement(context,
                new MaterialPageRoute(builder: (context) => MyLoginPage()));
          }, icon: Icon(Icons.logout),),

        ],
        title: Text('WELCOME $username',),
      ),
    bottomNavigationBar: CurvedNavigationBar(
    color: Color(0xff494cf6),
    backgroundColor: Color(0xff749eea),
    buttonBackgroundColor: Colors.black,
    height: 50.0,
    items: [
    Icon(Icons.home,size: 20,color: Colors.white,),
    Icon(Icons.shopping_cart,size: 20,color: Colors.white,),
    Icon(Icons.person,size: 20,color: Colors.white,),
    ],
      index: currentIndex,
      onTap: (index){
      setState(() {
        currentIndex=index;
      });
      },


    ),

      body: Container(
        child: _widgetOption.elementAt(currentIndex),
      ),
    );
  }
}


