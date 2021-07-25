import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

List userData=[];
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Home Screen',
      theme: ThemeData(
        primaryColor: Color(0xff494cf6), accentColor: Color(0xfff4786e),
      ),

      home: MyHomePage(),
    );
  }
}
class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  getData() async {
    var response = await http.get(Uri.https('test.extensionceramics.com',
        '/api/method/erpnext.accounts.doctype.purchase_invoice.purchase_invoice.tally_integration'));
    Map decodeData = jsonDecode(response.body);
    setState(() {
      userData = decodeData['message'];
    });
  }

  late SharedPreferences logindata;
  late String username;

  @override
  void initState() {
    super.initState();
    initial();
    getData();
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



      body:
      Container(

        child: ListView.builder(
          itemCount: userData == null ? 0 : userData.length,
          itemBuilder: (BuildContext context, int position) {
            return Container(width: 200,
              child: Card(shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),),
                elevation: 10,
                color: Color(0xffffffff),
                child: Column(
                  children: <Widget>[
                    ListTile(
                      leading: Icon(Icons.person, color: Colors.black,),
                      title: Text("${userData[position]["supplier_name"]}",
                        style: TextStyle(color: Colors.black),),
                      subtitle: Text("${userData[position]["cost"]}",
                        style: TextStyle(color: Colors.black),),
                      trailing: Text("${userData[position]["posting_date"]}",
                        style: TextStyle(color: Colors.black),),
                    )


                  ],

                ),
              ),

            );
          }
          ,),
      ),


    );
  }
}

