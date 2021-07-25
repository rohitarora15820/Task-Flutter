import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'mainpage.dart';
import 'package:rflutter_alert/rflutter_alert.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter-Task',
      theme: ThemeData(
          primaryColor: Color(0xff494cf6), accentColor: Color(0xfff4786e),
      ),
      home: MyLoginPage(),
    );
  }
}

class MyLoginPage extends StatefulWidget {
  @override
  _MyLoginPageState createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final username_controller = TextEditingController();
  final password_controller = TextEditingController();
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String username='Rohit';
  String password='123456';

  late SharedPreferences logindata;
 late bool newuser;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    check_if_already_login();
  }

  void check_if_already_login() async {
    logindata = await SharedPreferences.getInstance();
    newuser = (logindata.getBool('login') ?? true);

    print(newuser);
    if (newuser == false) {
      Navigator.pushReplacement(
          context, new MaterialPageRoute(builder: (context) => MyDashboard()));
    }
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    username_controller.dispose();
    password_controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,

        backgroundColor: Color(0xff749eea),
    appBar: AppBar(
    title: Text('Login'),
    centerTitle: true,
      ),
      body: ListView(
        children: [
        Center(
          child: Form(key: formkey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Container(
                  width: 500,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                      Radius.circular(8.0),
                    ),
                    image: DecorationImage(
                      image: AssetImage('images/download.jpg'),
                    ),
                  ),
                ),

                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter user name';

                        }
                        return null;
                      },
                      controller: username_controller,
                      style: TextStyle(
                        color: Color(0xff494cf6),
                      ),
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.person,
                            color: Color(0xfff4786e),
                          ),
                          labelText: 'UserName',
                          labelStyle: TextStyle(color: Color(0xfff4786e))),
                    ),
                  ),
                ),
                Padding(
                  padding:
                  const EdgeInsets.symmetric(vertical: 0.0, horizontal: 20.0),
                  child: Card(
                    margin: EdgeInsets.all(10.0),
                    child: TextFormField(
                      validator: (value){
                        if(value!.isEmpty){
                          return 'Please enter password';

                        }else if(value.length<6){
                          return 'Please enter password greater than 6';
                        }
                        return null;
                      },
                      controller: password_controller,
                      style: TextStyle(
                        color: Color(0xff494cf6),
                      ),
                      obscureText: true,
                      obscuringCharacter: '*',
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          icon: Icon(
                            Icons.lock,
                            color: Color(0xfff4786e),
                          ),
                          labelText: 'Password',
                          labelStyle: TextStyle(color: Color(0xfff4786e))),
                    ),
                  ),
                ),
                RaisedButton(
                  textColor: Colors.white,
                  color: Color(0xff494cf6),
                  onPressed: () {
    if(formkey.currentState!.validate()){
    if(username_controller.text != username ){
    Alert(context: context, title: "Login Failed", desc: "wrong username",image: Icon(Icons.close),).show();

    }else if(password_controller.text != password){
    Alert(context: context, title: "Login Failed", desc: "wrong password",image: Icon(Icons.close),).show();


    }else {
                      print('Successfull');
                      logindata.setBool('login', false);

                      logindata.setString('username', username);

                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => MyDashboard()));

                      Alert(
                        context: context,

                        type: AlertType.success,
                        title: "Login Successfull",
                        desc: "Welcome",
                        buttons: [
                          DialogButton(
                            child: Text(
                              "Ok",
                              style: TextStyle(color: Colors.white, fontSize: 20),
                            ),
                            onPressed: () => Navigator.pop(context),
                            color: Color.fromRGBO(0, 179, 134, 1.0),
                            radius: BorderRadius.circular(0.0),
                          ),
                        ],
                      ).show();

                    }}
                  },
                  child: Text("Log-In"),
                )
              ],
            ),
          ),
        ),]
      ),
    );
  }
}