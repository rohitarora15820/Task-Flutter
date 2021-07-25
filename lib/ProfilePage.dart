import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';



import 'package:shared_preferences/shared_preferences.dart';
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late SharedPreferences logindata;
   String username=" ";

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
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff749eea),
        body: Container(
        width: double.infinity,
    height: 350.0,
    child: Center(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Logged In User",
        style: TextStyle(
          fontSize: 32.0,
          color:  Color(0xff000000),
          fontWeight: FontWeight.bold
        ),
      ),
      SizedBox(
        height: 10.0,
      ),
    CircleAvatar(
    backgroundImage: AssetImage('images/download2.png'),
    radius: 50.0,
    ),
    SizedBox(
    height: 10.0,
    ),
    Text(
    "${username}",
    style: TextStyle(
    fontSize: 22.0,fontWeight: FontWeight.bold,
    color:  Color(0xff000000),
    ),
      ),
    ],
    ),
    ),
    )));
  }
}

